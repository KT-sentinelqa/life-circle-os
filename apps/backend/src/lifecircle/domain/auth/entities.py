"""
LifeCircle OS — Auth domain entities.

DEPENDENCY RULE: This module MUST NOT import from:
  - FastAPI, SQLAlchemy, Pydantic, Redis, or any infrastructure package.
  - Only stdlib and domain-internal imports are permitted.

These are pure Python value objects representing the core business model.
"""

from __future__ import annotations

import re
from dataclasses import dataclass, field
from datetime import UTC, datetime
from enum import Enum
from uuid import UUID, uuid4


class UserRole(str, Enum):
    """Permitted roles within a family unit.

    - guardian:  Primary decision-maker; full family management access.
    - helper:    Caregiver or support person with delegated access.
    - dependent: Family member receiving care (elder, child).
    """

    GUARDIAN = "guardian"
    HELPER = "helper"
    DEPENDENT = "dependent"


# ── Password Policy ────────────────────────────────────────────────────────────
# Governed by: docs/epic-1-user-registration.md §6
_PASSWORD_MIN_LENGTH = 12
_PASSWORD_PATTERN = re.compile(
    r"^(?=.*[A-Z])"  # at least one uppercase letter
    r"(?=.*[a-z])"  # at least one lowercase letter
    r"(?=.*\d)"  # at least one digit
    r"(?=.*[!@#$%^&*()_+])"  # at least one special character
    r".{" + str(_PASSWORD_MIN_LENGTH) + r",}$"
)


class PasswordPolicy:
    """Encapsulates the password validation rules.

    Validated here in the domain so that the use case can enforce the rules
    without depending on any framework-specific validation library.
    """

    @staticmethod
    def validate(plaintext: str) -> None:
        """Raise ValueError if the password does not meet policy requirements.

        Args:
            plaintext: The raw plaintext password to validate.

        Raises:
            ValueError: With a descriptive message if validation fails.
        """
        if len(plaintext) < _PASSWORD_MIN_LENGTH:
            raise ValueError(f"Password must be at least {_PASSWORD_MIN_LENGTH} characters long.")
        if not _PASSWORD_PATTERN.match(plaintext):
            raise ValueError(
                "Password must contain at least one uppercase letter, "
                "one lowercase letter, one digit, and one special character "
                "(!@#$%^&*()_+)."
            )


@dataclass(frozen=True)
class User:
    """Immutable domain entity representing a registered user.

    This is the authoritative representation of a User within the domain.
    It is NOT an ORM model — persistence concerns belong in the infrastructure layer.

    Attributes:
        id:            Unique user identifier.
        email:         Verified email address (unique across the system).
        password_hash: Argon2id hash of the user's password.
        full_name:     Display name of the user.
        role:          UserRole enum value.
        created_at:    UTC timestamp of account creation.
        updated_at:    UTC timestamp of last update.
        is_verified:   Whether the user has completed email OTP verification.
    """

    id: UUID = field(default_factory=uuid4)
    email: str = field(default="")
    password_hash: str = field(default="")
    full_name: str = field(default="")
    role: UserRole = field(default=UserRole.GUARDIAN)
    created_at: datetime = field(default_factory=lambda: datetime.now(UTC))
    updated_at: datetime = field(default_factory=lambda: datetime.now(UTC))
    is_verified: bool = field(default=False)

    def __post_init__(self) -> None:
        """Enforce invariants at construction time."""
        if not self.email or "@" not in self.email:
            raise ValueError(f"Invalid email address: '{self.email}'")
        if not self.full_name or len(self.full_name.strip()) < 2:
            raise ValueError("full_name must be at least 2 characters.")
        if not self.password_hash:
            raise ValueError("password_hash must not be empty.")


@dataclass(frozen=True)
class Family:
    """Immutable domain entity representing a family unit.

    A Family is owned by a single guardian (owner_id) and contains
    one or more members. Member management is handled in a future epic.

    Attributes:
        id:         Unique family identifier.
        name:       Human-readable family name.
        owner_id:   UUID of the guardian User who created the family.
        created_at: UTC timestamp of family creation.
        updated_at: UTC timestamp of last update.
    """

    id: UUID = field(default_factory=uuid4)
    name: str = field(default="")
    owner_id: UUID = field(default_factory=uuid4)
    created_at: datetime = field(default_factory=lambda: datetime.now(UTC))
    updated_at: datetime = field(default_factory=lambda: datetime.now(UTC))

    def __post_init__(self) -> None:
        """Enforce invariants at construction time."""
        if not self.name or len(self.name.strip()) < 2:
            raise ValueError("Family name must be at least 2 characters.")
