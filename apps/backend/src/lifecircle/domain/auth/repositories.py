"""
LifeCircle OS — Auth domain repository interfaces (ports).

DEPENDENCY RULE: Only domain entities are imported here. No ORM, no SQLAlchemy.
These are abstract interfaces (ports) that the infrastructure layer implements (adapters).
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from uuid import UUID

from lifecircle.domain.auth.entities import Family, User


class UserRepository(ABC):
    """Port: defines the persistence contract for User entities.

    The infrastructure layer provides the concrete SQLAlchemy implementation.
    Tests provide in-memory fakes.
    """

    @abstractmethod
    async def save(self, user: User) -> User:
        """Persist a new User and return the saved entity.

        Args:
            user: The domain User entity to persist.

        Returns:
            The persisted User (may include DB-generated fields).

        Raises:
            DuplicateEmailError: If the email already exists.
        """
        ...

    @abstractmethod
    async def find_by_email(self, email: str) -> User | None:
        """Retrieve a User by email address.

        Args:
            email: The email address to search for.

        Returns:
            The User entity if found, None otherwise.
        """
        ...

    @abstractmethod
    async def find_by_id(self, user_id: UUID) -> User | None:
        """Retrieve a User by their unique identifier.

        Args:
            user_id: The UUID of the user to find.

        Returns:
            The User entity if found, None otherwise.
        """
        ...


class FamilyRepository(ABC):
    """Port: defines the persistence contract for Family entities."""

    @abstractmethod
    async def save(self, family: Family) -> Family:
        """Persist a new Family and return the saved entity.

        Args:
            family: The domain Family entity to persist.

        Returns:
            The persisted Family entity.
        """
        ...

    @abstractmethod
    async def find_by_id(self, family_id: UUID) -> Family | None:
        """Retrieve a Family by its unique identifier."""
        ...

    @abstractmethod
    async def find_by_owner(self, owner_id: UUID) -> list[Family]:
        """Retrieve all families owned by a given user."""
        ...


class EventPublisher(ABC):
    """Port: defines the contract for publishing domain events to the broker."""

    @abstractmethod
    async def publish(self, event_type: str, payload: dict[str, object]) -> None:
        """Publish an event to the message broker.

        Args:
            event_type: Routing key (e.g., 'user.registered.v1').
            payload:    The event data dictionary (must be JSON-serializable).
        """
        ...


# ── Domain Exceptions ─────────────────────────────────────────────────────────


class DomainError(Exception):
    """Base class for all domain-layer exceptions."""


class DuplicateEmailError(DomainError):
    """Raised when a registration attempt uses an already-registered email."""

    def __init__(self, email: str) -> None:
        super().__init__(f"The email address '{email}' is already registered.")
        self.email = email


class UserNotFoundError(DomainError):
    """Raised when a requested user does not exist."""


class FamilyNotFoundError(DomainError):
    """Raised when a requested family does not exist."""


class UnauthorizedError(DomainError):
    """Raised when an operation is attempted without sufficient permissions."""
