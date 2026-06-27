from __future__ import annotations

import uuid
from collections.abc import AsyncGenerator
from datetime import UTC, datetime

import pytest
from sqlalchemy.ext.asyncio import AsyncSession

from lifecircle.config import get_settings
from lifecircle.domain.auth.entities import Family, User, UserRole
from lifecircle.domain.auth.repositories import DuplicateEmailError
from lifecircle.infrastructure.database.connection import Base, build_engine
from lifecircle.infrastructure.repositories.user_repository import (
    SqlAlchemyFamilyRepository,
    SqlAlchemyUserRepository,
)

pytestmark = pytest.mark.asyncio


@pytest.fixture
async def db_session() -> AsyncGenerator[AsyncSession, None]:
    settings = get_settings()
    engine = build_engine(settings)

    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

    async_session = AsyncSession(engine, expire_on_commit=False)
    async with async_session as session:
        yield session
        await session.rollback()

    await engine.dispose()


async def test_user_repository_crud(db_session: AsyncSession) -> None:
    """Verify that SqlAlchemyUserRepository implements all UserRepository persistence contracts."""
    repo = SqlAlchemyUserRepository(db_session)
    user_id = uuid.uuid4()
    user = User(
        id=user_id,
        email="repo-test@example.com",
        password_hash="hash123",
        full_name="Repo Test User",
        role=UserRole.GUARDIAN,
        is_verified=False,
        created_at=datetime.now(UTC),
        updated_at=datetime.now(UTC),
    )

    # Save user
    saved = await repo.save(user)
    assert saved.email == user.email

    # Find by email
    found_by_email = await repo.find_by_email(user.email)
    assert found_by_email is not None
    assert found_by_email.id == user_id

    # Find by id
    found_by_id = await repo.find_by_id(user_id)
    assert found_by_id is not None
    assert found_by_id.email == user.email

    # Non-existing user search returns None
    assert await repo.find_by_email("non-existing@example.com") is None
    assert await repo.find_by_id(uuid.uuid4()) is None

    # Duplicate email exception validation
    duplicate = User(
        id=uuid.uuid4(),
        email="repo-test@example.com",
        password_hash="hash456",
        full_name="Duplicate User",
        role=UserRole.HELPER,
        is_verified=False,
        created_at=datetime.now(UTC),
        updated_at=datetime.now(UTC),
    )
    with pytest.raises(DuplicateEmailError):
        await repo.save(duplicate)


async def test_family_repository_crud(db_session: AsyncSession) -> None:
    """Verify that SqlAlchemyFamilyRepository implements all.

    FamilyRepository persistence contracts.
    """
    user_repo = SqlAlchemyUserRepository(db_session)
    family_repo = SqlAlchemyFamilyRepository(db_session)

    owner_id = uuid.uuid4()
    user = User(
        id=owner_id,
        email="family-owner@example.com",
        password_hash="hash123",
        full_name="Family Owner",
        role=UserRole.GUARDIAN,
        is_verified=True,
        created_at=datetime.now(UTC),
        updated_at=datetime.now(UTC),
    )
    await user_repo.save(user)

    family_id = uuid.uuid4()
    family = Family(
        id=family_id,
        name="Test Family",
        owner_id=owner_id,
        created_at=datetime.now(UTC),
        updated_at=datetime.now(UTC),
    )

    # Save family
    saved = await family_repo.save(family)
    assert saved.name == "Test Family"

    # Find by id
    found = await family_repo.find_by_id(family_id)
    assert found is not None
    assert found.name == "Test Family"

    # Find by owner
    by_owner = await family_repo.find_by_owner(owner_id)
    assert len(by_owner) == 1
    assert by_owner[0].id == family_id

    # Non-existing queries return empty / None
    assert await family_repo.find_by_id(uuid.uuid4()) is None
    assert await family_repo.find_by_owner(uuid.uuid4()) == []
