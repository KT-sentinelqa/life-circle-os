from __future__ import annotations

import uuid

import pytest

from lifecircle.domain.auth.repositories import (
    DuplicateEmailError,
    EventPublisher,
    FamilyNotFoundError,
    FamilyRepository,
    UnauthorizedError,
    UserNotFoundError,
    UserRepository,
)


class StubUserRepository(UserRepository):
    async def save(self, user: any) -> any:
        return await super().save(user)

    async def find_by_email(self, email: str) -> any:
        return await super().find_by_email(email)

    async def find_by_id(self, user_id: uuid.UUID) -> any:
        return await super().find_by_id(user_id)


class StubFamilyRepository(FamilyRepository):
    async def save(self, family: any) -> any:
        return await super().save(family)

    async def find_by_id(self, family_id: uuid.UUID) -> any:
        return await super().find_by_id(family_id)

    async def find_by_owner(self, owner_id: uuid.UUID) -> any:
        return await super().find_by_owner(owner_id)


class StubEventPublisher(EventPublisher):
    async def publish(self, event_type: str, payload: dict[str, object]) -> None:
        await super().publish(event_type, payload)


@pytest.mark.asyncio
async def test_repository_interfaces() -> None:
    """Verify that interface base definitions can be reached via stubs."""
    u_repo = StubUserRepository()
    await u_repo.save(None)
    await u_repo.find_by_email("test")
    await u_repo.find_by_id(uuid.uuid4())

    f_repo = StubFamilyRepository()
    await f_repo.save(None)
    await f_repo.find_by_id(uuid.uuid4())
    await f_repo.find_by_owner(uuid.uuid4())

    pub = StubEventPublisher()
    await pub.publish("test", {})


def test_domain_exceptions() -> None:
    """Verify initialization and attributes of domain layer error models."""
    dup_err = DuplicateEmailError("dup@lifecircle.dev")
    assert dup_err.email == "dup@lifecircle.dev"
    assert "dup@lifecircle.dev" in str(dup_err)

    assert isinstance(UserNotFoundError(), Exception)
    assert isinstance(FamilyNotFoundError(), Exception)
    assert isinstance(UnauthorizedError(), Exception)
