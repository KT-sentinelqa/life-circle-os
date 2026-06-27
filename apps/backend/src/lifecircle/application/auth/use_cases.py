"""
LifeCircle OS — Auth application use cases.

DEPENDENCY RULE: May import from domain only. Must NOT import from infrastructure or presentation.

Use cases are the authoritative orchestrators of domain logic. They:
  1. Accept command objects (plain dataclasses).
  2. Coordinate domain entities and repository ports.
  3. Publish domain events.
  4. Return domain entities (never ORM models or HTTP schemas).

Governed by: docs/epic-1-user-registration.md §6
"""

from __future__ import annotations

import logging
import uuid
from dataclasses import dataclass
from datetime import UTC, datetime

from argon2 import PasswordHasher
from argon2.exceptions import VerifyMismatchError

from lifecircle.domain.auth.entities import Family, PasswordPolicy, User, UserRole
from lifecircle.domain.auth.repositories import (
    DuplicateEmailError,
    EventPublisher,
    FamilyRepository,
    UnauthorizedError,
    UserRepository,
)
from lifecircle.infrastructure.observability.tracing import get_tracer

logger = logging.getLogger(__name__)

# ── Argon2id Parameters ────────────────────────────────────────────────────────
# Governed by: docs/epic-1-user-registration.md §4
# m=65536 (64 MiB memory), t=3 iterations, p=4 parallelism
_HASHER = PasswordHasher(
    memory_cost=65536,
    time_cost=3,
    parallelism=4,
)


# ── Command Objects ────────────────────────────────────────────────────────────


@dataclass(frozen=True)
class RegisterUserCommand:
    """Input command for the RegisterUserUseCase.

    Fields are validated by the presentation layer (Pydantic) before
    the use case receives them. The use case applies domain-level validation.
    """

    email: str
    plaintext_password: str
    full_name: str
    role: UserRole = UserRole.GUARDIAN


@dataclass(frozen=True)
class CreateFamilyCommand:
    """Input command for the CreateFamilyUseCase."""

    name: str
    owner_id: uuid.UUID


# ── Use Cases ─────────────────────────────────────────────────────────────────


class RegisterUserUseCase:
    """Orchestrates the user registration flow.

    Steps:
      1. Validate domain-level password policy.
      2. Check for duplicate email.
      3. Hash password with Argon2id (m=65536, t=3, p=4).
      4. Persist the new User via UserRepository.
      5. Publish 'user.registered.v1' domain event.
      6. Return the created User entity.

    Raises:
        ValueError: If the password fails domain policy validation.
        DuplicateEmailError: If the email is already registered.
    """

    def __init__(
        self,
        user_repository: UserRepository,
        event_publisher: EventPublisher,
    ) -> None:
        self._users = user_repository
        self._publisher = event_publisher

    async def execute(self, command: RegisterUserCommand) -> User:
        """Execute the user registration command."""
        tracer = get_tracer("lifecircle.auth")
        with tracer.start_as_current_span("auth.register_user") as span:
            # Span attributes — PII scrubbed: no email, no password
            span.set_attribute("user.role", command.role.value)

            # 1 — Domain-level password validation
            PasswordPolicy.validate(command.plaintext_password)

            # 2 — Duplicate email check
            existing = await self._users.find_by_email(command.email)
            if existing is not None:
                raise DuplicateEmailError(command.email)

            # 3 — Hash password with Argon2id
            password_hash = _HASHER.hash(command.plaintext_password)

            # 4 — Construct and persist domain entity
            user = User(
                id=uuid.uuid4(),
                email=command.email,
                password_hash=password_hash,
                full_name=command.full_name,
                role=command.role,
                created_at=datetime.now(UTC),
                updated_at=datetime.now(UTC),
                is_verified=False,
            )
            with tracer.start_as_current_span("db.insert_user") as db_span:
                db_span.set_attribute("db.operation", "INSERT")
                db_span.set_attribute("db.table", "users")
                saved_user = await self._users.save(user)
            span.set_attribute("user.id", str(saved_user.id))

            # 5 — Publish domain event
            await self._publisher.publish(
                event_type="user.registered.v1",
                payload={
                    "event_id": str(uuid.uuid4()),
                    "event_type": "user.registered.v1",
                    "timestamp": datetime.now(UTC).isoformat(),
                    "data": {
                        "user_id": str(saved_user.id),
                        "email": saved_user.email,
                        "full_name": saved_user.full_name,
                        "role": saved_user.role.value,
                    },
                },
            )

            logger.info(
                "User registered",
                extra={"user_id": str(saved_user.id), "role": saved_user.role.value},
            )
            return saved_user


class CreateFamilyUseCase:
    """Orchestrates family creation for an authenticated guardian.

    Steps:
      1. Verify the owner user exists and is a guardian.
      2. Construct the Family entity.
      3. Persist via FamilyRepository.
      4. Publish 'family.created.v1' domain event.
      5. Return the created Family.

    Raises:
        UnauthorizedError: If the owner is not a guardian.
    """

    def __init__(
        self,
        user_repository: UserRepository,
        family_repository: FamilyRepository,
        event_publisher: EventPublisher,
    ) -> None:
        self._users = user_repository
        self._families = family_repository
        self._publisher = event_publisher

    async def execute(self, command: CreateFamilyCommand) -> Family:
        """Execute the family creation command."""
        # 1 — Verify owner exists and has guardian role
        owner = await self._users.find_by_id(command.owner_id)
        if owner is None:
            raise UnauthorizedError("Owner user not found.")
        if owner.role != UserRole.GUARDIAN:
            raise UnauthorizedError("Only guardians may create families.")

        # 2 — Construct and persist
        family = Family(
            id=uuid.uuid4(),
            name=command.name,
            owner_id=command.owner_id,
            created_at=datetime.now(UTC),
            updated_at=datetime.now(UTC),
        )
        saved_family = await self._families.save(family)

        # 3 — Publish domain event
        await self._publisher.publish(
            event_type="family.created.v1",
            payload={
                "event_id": str(uuid.uuid4()),
                "event_type": "family.created.v1",
                "timestamp": datetime.now(UTC).isoformat(),
                "data": {
                    "family_id": str(saved_family.id),
                    "name": saved_family.name,
                    "owner_id": str(saved_family.owner_id),
                },
            },
        )

        logger.info(
            "Family created",
            extra={"family_id": str(saved_family.id), "owner_id": str(command.owner_id)},
        )
        return saved_family


class VerifyPasswordUseCase:
    """Verifies a plaintext password against an Argon2id hash.

    Used by the login flow (future epic). Isolated here to keep hash
    verification logic centralized and testable.
    """

    @staticmethod
    def verify(plaintext: str, hashed: str) -> bool:
        """Return True if plaintext matches the hash, False otherwise."""
        try:
            _HASHER.verify(hashed, plaintext)
            return True
        except VerifyMismatchError:
            return False
