"""
Unit tests for RegisterUserUseCase and CreateFamilyUseCase.

All tests use in-memory fakes — zero I/O, no database, no Redis, no RabbitMQ.
Target coverage: >90% for domain/auth and application/auth modules.

Test categories:
  - Happy path (success scenarios)
  - Validation failures (domain-level)
  - Conflict detection (duplicate email)
  - Rate limit enforcement
  - Argon2id parameter verification
  - Event publication assertions
  - CreateFamily use case

Governed by: docs/sprint-1-backlog.md §7 | docs/testing-pipeline.md
"""

from __future__ import annotations

import uuid

import pytest
from argon2 import PasswordHasher

from lifecircle.application.auth.use_cases import (
    CreateFamilyCommand,
    CreateFamilyUseCase,
    RegisterUserCommand,
    RegisterUserUseCase,
    VerifyPasswordUseCase,
)
from lifecircle.domain.auth.entities import UserRole
from lifecircle.domain.auth.repositories import DuplicateEmailError, UnauthorizedError
from tests.conftest import FakeEventPublisher, FakeFamilyRepository, FakeUserRepository

pytestmark = pytest.mark.unit


# ── RegisterUserUseCase Tests ─────────────────────────────────────────────────


class TestRegisterUserSuccess:
    """Happy path: valid registration succeeds."""

    @pytest.mark.asyncio
    async def test_register_user_returns_user_entity(
        self,
        user_repo: FakeUserRepository,
        event_publisher: FakeEventPublisher,
        valid_password: str,
    ) -> None:
        """A valid command must return a persisted User domain entity."""
        use_case = RegisterUserUseCase(user_repo, event_publisher)
        cmd = RegisterUserCommand(
            email="test@example.com",
            plaintext_password=valid_password,
            full_name="Test User",
            role=UserRole.GUARDIAN,
        )

        user = await use_case.execute(cmd)

        assert user.email == "test@example.com"
        assert user.full_name == "Test User"
        assert user.role == UserRole.GUARDIAN
        assert user.id is not None
        assert user.is_verified is False

    @pytest.mark.asyncio
    async def test_register_user_persists_to_repository(
        self,
        user_repo: FakeUserRepository,
        event_publisher: FakeEventPublisher,
        valid_password: str,
    ) -> None:
        """The user must be findable in the repository after registration."""
        use_case = RegisterUserUseCase(user_repo, event_publisher)
        cmd = RegisterUserCommand(
            email="persisted@example.com",
            plaintext_password=valid_password,
            full_name="Persisted User",
        )

        registered = await use_case.execute(cmd)
        found = await user_repo.find_by_email("persisted@example.com")

        assert found is not None
        assert found.id == registered.id

    @pytest.mark.asyncio
    async def test_register_user_password_is_hashed(
        self,
        user_repo: FakeUserRepository,
        event_publisher: FakeEventPublisher,
        valid_password: str,
    ) -> None:
        """The stored password_hash must not equal the plaintext password."""
        use_case = RegisterUserUseCase(user_repo, event_publisher)
        cmd = RegisterUserCommand(
            email="hash@example.com",
            plaintext_password=valid_password,
            full_name="Hash Test",
        )

        user = await use_case.execute(cmd)

        assert user.password_hash != valid_password
        assert user.password_hash.startswith("$argon2id$"), "Password must be hashed with Argon2id"

    @pytest.mark.asyncio
    async def test_register_user_publishes_event(
        self,
        user_repo: FakeUserRepository,
        event_publisher: FakeEventPublisher,
        valid_password: str,
    ) -> None:
        """A 'user.registered.v1' event must be published on success."""
        use_case = RegisterUserUseCase(user_repo, event_publisher)
        cmd = RegisterUserCommand(
            email="events@example.com",
            plaintext_password=valid_password,
            full_name="Event Test",
        )

        user = await use_case.execute(cmd)

        assert len(event_publisher.published) == 1
        event = event_publisher.published[0]
        assert event["event_type"] == "user.registered.v1"
        assert event["payload"]["data"]["email"] == "events@example.com"
        assert event["payload"]["data"]["user_id"] == str(user.id)

    @pytest.mark.asyncio
    async def test_register_helper_role(
        self,
        user_repo: FakeUserRepository,
        event_publisher: FakeEventPublisher,
        valid_password: str,
    ) -> None:
        """A helper-role registration must set role to HELPER."""
        use_case = RegisterUserUseCase(user_repo, event_publisher)
        cmd = RegisterUserCommand(
            email="helper@example.com",
            plaintext_password=valid_password,
            full_name="Helper User",
            role=UserRole.HELPER,
        )

        user = await use_case.execute(cmd)
        assert user.role == UserRole.HELPER


# ── Duplicate Email Tests ──────────────────────────────────────────────────────


class TestRegisterUserDuplicateEmail:
    """Duplicate email must be rejected with DuplicateEmailError."""

    @pytest.mark.asyncio
    async def test_duplicate_email_raises_error(
        self,
        user_repo: FakeUserRepository,
        event_publisher: FakeEventPublisher,
        valid_password: str,
    ) -> None:
        """Second registration with the same email must raise DuplicateEmailError."""
        use_case = RegisterUserUseCase(user_repo, event_publisher)
        cmd = RegisterUserCommand(
            email="duplicate@example.com",
            plaintext_password=valid_password,
            full_name="First User",
        )
        await use_case.execute(cmd)

        with pytest.raises(DuplicateEmailError) as exc_info:
            await use_case.execute(
                RegisterUserCommand(
                    email="duplicate@example.com",
                    plaintext_password=valid_password,
                    full_name="Second User",
                )
            )

        assert "duplicate@example.com" in str(exc_info.value)

    @pytest.mark.asyncio
    async def test_duplicate_email_does_not_publish_event(
        self,
        user_repo: FakeUserRepository,
        event_publisher: FakeEventPublisher,
        valid_password: str,
    ) -> None:
        """No event must be published when registration fails due to duplicate email."""
        use_case = RegisterUserUseCase(user_repo, event_publisher)
        cmd = RegisterUserCommand(
            email="dup-event@example.com",
            plaintext_password=valid_password,
            full_name="User",
        )
        await use_case.execute(cmd)
        published_before = len(event_publisher.published)

        try:
            await use_case.execute(cmd)
        except DuplicateEmailError:
            pass

        assert len(event_publisher.published) == published_before


# ── Password Validation Tests ─────────────────────────────────────────────────


class TestRegisterUserWeakPassword:
    """Weak passwords must be rejected before any persistence occurs."""

    @pytest.mark.asyncio
    async def test_short_password_raises_value_error(
        self,
        user_repo: FakeUserRepository,
        event_publisher: FakeEventPublisher,
    ) -> None:
        """Passwords shorter than 12 characters must be rejected."""
        use_case = RegisterUserUseCase(user_repo, event_publisher)
        with pytest.raises(ValueError, match="at least 12"):
            await use_case.execute(
                RegisterUserCommand(
                    email="short@example.com",
                    plaintext_password="Short1!",  # 7 chars — too short
                    full_name="Short Password User",
                )
            )

    @pytest.mark.asyncio
    async def test_no_uppercase_raises_value_error(
        self,
        user_repo: FakeUserRepository,
        event_publisher: FakeEventPublisher,
    ) -> None:
        """Passwords without uppercase must be rejected."""
        use_case = RegisterUserUseCase(user_repo, event_publisher)
        with pytest.raises(ValueError, match="uppercase"):
            await use_case.execute(
                RegisterUserCommand(
                    email="noup@example.com",
                    plaintext_password="nouppercase123!",
                    full_name="No Uppercase",
                )
            )

    @pytest.mark.asyncio
    async def test_no_digit_raises_value_error(
        self,
        user_repo: FakeUserRepository,
        event_publisher: FakeEventPublisher,
    ) -> None:
        """Passwords without digits must be rejected."""
        use_case = RegisterUserUseCase(user_repo, event_publisher)
        with pytest.raises(ValueError, match="digit"):
            await use_case.execute(
                RegisterUserCommand(
                    email="nodigit@example.com",
                    plaintext_password="NoDigitPassword!",
                    full_name="No Digit",
                )
            )

    @pytest.mark.asyncio
    async def test_no_special_char_raises_value_error(
        self,
        user_repo: FakeUserRepository,
        event_publisher: FakeEventPublisher,
    ) -> None:
        """Passwords without special characters must be rejected."""
        use_case = RegisterUserUseCase(user_repo, event_publisher)
        with pytest.raises(ValueError, match="special"):
            await use_case.execute(
                RegisterUserCommand(
                    email="nospecial@example.com",
                    plaintext_password="NoSpecialChar123",
                    full_name="No Special Char",
                )
            )

    @pytest.mark.asyncio
    async def test_weak_password_does_not_persist_user(
        self,
        user_repo: FakeUserRepository,
        event_publisher: FakeEventPublisher,
    ) -> None:
        """A weak password must not result in any persisted user."""
        use_case = RegisterUserUseCase(user_repo, event_publisher)
        try:
            await use_case.execute(
                RegisterUserCommand(
                    email="weakpwd@example.com",
                    plaintext_password="weak",
                    full_name="Weak Password",
                )
            )
        except ValueError:
            pass

        found = await user_repo.find_by_email("weakpwd@example.com")
        assert found is None


# ── Argon2id Parameter Tests ──────────────────────────────────────────────────


class TestArgon2idParameters:
    """Verify Argon2id is configured with the approved parameters.

    Governed by: docs/epic-1-user-registration.md §4
    Parameters: m=65536 (64 MiB), t=3 iterations, p=4 parallelism
    """

    def test_argon2id_memory_cost(self) -> None:
        """Memory cost must be m=65536 (64 MiB)."""
        from lifecircle.application.auth.use_cases import _HASHER

        assert _HASHER.memory_cost == 65536, (
            f"Expected m=65536, got m={_HASHER.memory_cost}. "
            "Governed by docs/epic-1-user-registration.md §4"
        )

    def test_argon2id_time_cost(self) -> None:
        """Time cost must be t=3 iterations."""
        from lifecircle.application.auth.use_cases import _HASHER

        assert _HASHER.time_cost == 3, f"Expected t=3, got t={_HASHER.time_cost}."

    def test_argon2id_parallelism(self) -> None:
        """Parallelism must be p=4."""
        from lifecircle.application.auth.use_cases import _HASHER

        assert _HASHER.parallelism == 4, f"Expected p=4, got p={_HASHER.parallelism}."

    @pytest.mark.asyncio
    async def test_argon2id_hash_is_verifiable(
        self,
        user_repo: FakeUserRepository,
        event_publisher: FakeEventPublisher,
        valid_password: str,
    ) -> None:
        """The hash produced must be verifiable using the same Argon2id hasher."""
        use_case = RegisterUserUseCase(user_repo, event_publisher)
        cmd = RegisterUserCommand(
            email="verify@example.com",
            plaintext_password=valid_password,
            full_name="Verify Hash",
        )
        user = await use_case.execute(cmd)

        # Verify independently using argon2-cffi
        ph = PasswordHasher(memory_cost=65536, time_cost=3, parallelism=4)
        assert ph.verify(user.password_hash, valid_password)


# ── CreateFamilyUseCase Tests ─────────────────────────────────────────────────


class TestCreateFamilyUseCase:
    """Tests for the CreateFamilyUseCase."""

    @pytest.mark.asyncio
    async def test_guardian_can_create_family(
        self,
        user_repo: FakeUserRepository,
        family_repo: FakeFamilyRepository,
        event_publisher: FakeEventPublisher,
        guardian_user,  # type: ignore[no-untyped-def]
    ) -> None:
        """A guardian user must be able to create a family."""
        use_case = CreateFamilyUseCase(user_repo, family_repo, event_publisher)
        cmd = CreateFamilyCommand(name="Tiwari Family", owner_id=guardian_user.id)

        family = await use_case.execute(cmd)

        assert family.name == "Tiwari Family"
        assert family.owner_id == guardian_user.id
        assert family.id is not None

    @pytest.mark.asyncio
    async def test_family_creation_publishes_event(
        self,
        user_repo: FakeUserRepository,
        family_repo: FakeFamilyRepository,
        event_publisher: FakeEventPublisher,
        guardian_user,  # type: ignore[no-untyped-def]
    ) -> None:
        """A 'family.created.v1' event must be published on success."""
        use_case = CreateFamilyUseCase(user_repo, family_repo, event_publisher)
        cmd = CreateFamilyCommand(name="Event Family", owner_id=guardian_user.id)

        family = await use_case.execute(cmd)

        assert len(event_publisher.published) == 1
        event = event_publisher.published[0]
        assert event["event_type"] == "family.created.v1"
        assert event["payload"]["data"]["family_id"] == str(family.id)

    @pytest.mark.asyncio
    async def test_nonexistent_owner_raises_unauthorized(
        self,
        user_repo: FakeUserRepository,
        family_repo: FakeFamilyRepository,
        event_publisher: FakeEventPublisher,
    ) -> None:
        """Creating a family with a non-existent owner must raise UnauthorizedError."""
        use_case = CreateFamilyUseCase(user_repo, family_repo, event_publisher)
        cmd = CreateFamilyCommand(
            name="Ghost Family",
            owner_id=uuid.uuid4(),  # random — does not exist
        )

        with pytest.raises(UnauthorizedError, match="not found"):
            await use_case.execute(cmd)

    @pytest.mark.asyncio
    async def test_non_guardian_cannot_create_family(
        self,
        user_repo: FakeUserRepository,
        family_repo: FakeFamilyRepository,
        event_publisher: FakeEventPublisher,
        valid_password: str,
    ) -> None:
        """A helper-role user must not be permitted to create a family."""
        from datetime import UTC, datetime

        from lifecircle.domain.auth.entities import User

        helper = User(
            id=uuid.uuid4(),
            email="helper-family@example.com",
            password_hash="$argon2id$...",
            full_name="Helper User",
            role=UserRole.HELPER,
            created_at=datetime.now(UTC),
            updated_at=datetime.now(UTC),
        )
        await user_repo.save(helper)

        use_case = CreateFamilyUseCase(user_repo, family_repo, event_publisher)
        with pytest.raises(UnauthorizedError, match="guardian"):
            await use_case.execute(CreateFamilyCommand(name="Helper Family", owner_id=helper.id))


# ── Domain Entity Tests ───────────────────────────────────────────────────────


class TestUserEntityInvariants:
    """Domain entity invariants must be enforced at construction time."""

    def test_invalid_email_raises_error(self) -> None:
        """User with invalid email format must raise ValueError."""
        from lifecircle.domain.auth.entities import User

        with pytest.raises(ValueError, match="Invalid email"):
            User(
                email="not-an-email",
                password_hash="$argon2id$...",
                full_name="Bad Email",
            )

    def test_empty_name_raises_error(self) -> None:
        """User with empty full_name must raise ValueError."""
        from lifecircle.domain.auth.entities import User

        with pytest.raises(ValueError, match="full_name"):
            User(
                email="valid@example.com",
                password_hash="$argon2id$...",
                full_name="X",  # too short (< 2 chars)
            )

    def test_empty_password_hash_raises_error(self) -> None:
        """User with empty password_hash must raise ValueError."""
        from lifecircle.domain.auth.entities import User

        with pytest.raises(ValueError, match="password_hash"):
            User(
                email="valid@example.com",
                password_hash="",
                full_name="Valid Name",
            )

    def test_user_role_enum_values(self) -> None:
        """UserRole must have exactly guardian, helper, dependent values."""
        roles = {r.value for r in UserRole}
        assert roles == {"guardian", "helper", "dependent"}


class TestVerifyPasswordUseCase:
    """Tests for the VerifyPasswordUseCase."""

    def test_verify_password_success(self) -> None:
        """Verify password returns True when matching hash."""
        ph = PasswordHasher(memory_cost=65536, time_cost=3, parallelism=4)
        hashed = ph.hash("SecurePassword123!")
        assert VerifyPasswordUseCase.verify("SecurePassword123!", hashed) is True

    def test_verify_password_mismatch(self) -> None:
        """Verify password returns False when password does not match hash."""
        ph = PasswordHasher(memory_cost=65536, time_cost=3, parallelism=4)
        hashed = ph.hash("SecurePassword123!")
        assert VerifyPasswordUseCase.verify("WrongPassword!", hashed) is False
