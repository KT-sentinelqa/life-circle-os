"""
Pytest configuration and shared fixtures.

In-memory fake implementations of domain ports allow unit tests to run
without any I/O — no database, no Redis, no RabbitMQ.

Governed by: docs/testing-pipeline.md | docs/coding-standards.md
"""

from __future__ import annotations

import uuid
from datetime import UTC, datetime
from typing import Any
from uuid import UUID

import pytest

from lifecircle.domain.auth.entities import Family, User, UserRole
from lifecircle.domain.auth.repositories import (
    DuplicateEmailError,
    EventPublisher,
    FamilyRepository,
    UserRepository,
)

# ── In-Memory Fakes ───────────────────────────────────────────────────────────


class FakeUserRepository(UserRepository):
    """In-memory UserRepository for unit testing.

    Stores users in a plain dict keyed by email and by id.
    Raises DuplicateEmailError on duplicate email, matching production behaviour.
    """

    def __init__(self) -> None:
        self._by_email: dict[str, User] = {}
        self._by_id: dict[UUID, User] = {}

    async def save(self, user: User) -> User:
        if user.email in self._by_email:
            raise DuplicateEmailError(user.email)
        self._by_email[user.email] = user
        self._by_id[user.id] = user
        return user

    async def find_by_email(self, email: str) -> User | None:
        return self._by_email.get(email)

    async def find_by_id(self, user_id: UUID) -> User | None:
        return self._by_id.get(user_id)


class FakeFamilyRepository(FamilyRepository):
    """In-memory FamilyRepository for unit testing."""

    def __init__(self) -> None:
        self._by_id: dict[UUID, Family] = {}

    async def save(self, family: Family) -> Family:
        self._by_id[family.id] = family
        return family

    async def find_by_id(self, family_id: UUID) -> Family | None:
        return self._by_id.get(family_id)

    async def find_by_owner(self, owner_id: UUID) -> list[Family]:
        return [f for f in self._by_id.values() if f.owner_id == owner_id]


class FakeEventPublisher(EventPublisher):
    """In-memory EventPublisher that captures published events for assertion."""

    def __init__(self) -> None:
        self.published: list[dict[str, Any]] = []

    async def publish(self, event_type: str, payload: dict[str, object]) -> None:
        self.published.append({"event_type": event_type, "payload": payload})


# ── Fixtures ──────────────────────────────────────────────────────────────────


@pytest.fixture
def user_repo() -> FakeUserRepository:
    """Provide a fresh FakeUserRepository per test."""
    return FakeUserRepository()


@pytest.fixture
def family_repo() -> FakeFamilyRepository:
    """Provide a fresh FakeFamilyRepository per test."""
    return FakeFamilyRepository()


@pytest.fixture
def event_publisher() -> FakeEventPublisher:
    """Provide a fresh FakeEventPublisher per test."""
    return FakeEventPublisher()


@pytest.fixture
def valid_password() -> str:
    """A password that satisfies all domain policy requirements."""
    return "SecurePassword123!"


@pytest.fixture
def guardian_user(user_repo: FakeUserRepository) -> User:
    """A pre-existing guardian user inserted directly into the fake repository."""
    import asyncio

    user = User(
        id=uuid.uuid4(),
        email="guardian@example.com",
        password_hash="$argon2id$...",
        full_name="Test Guardian",
        role=UserRole.GUARDIAN,
        created_at=datetime.now(UTC),
        updated_at=datetime.now(UTC),
        is_verified=True,
    )
    asyncio.get_event_loop().run_until_complete(user_repo.save(user))
    return user
