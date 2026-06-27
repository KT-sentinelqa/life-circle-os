"""
LifeCircle OS — SQLAlchemy implementation of UserRepository and FamilyRepository.

These are infrastructure adapters implementing the domain repository ports.
They translate between domain entities and ORM models.

Governed by: docs/golden-path/backend-feature.md | docs/database-architecture.md
"""

from __future__ import annotations

from uuid import UUID

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from lifecircle.domain.auth.entities import Family, User, UserRole
from lifecircle.domain.auth.repositories import (
    DuplicateEmailError,
    FamilyRepository,
    UserRepository,
)
from lifecircle.infrastructure.database.models import FamilyModel, UserModel


class SqlAlchemyUserRepository(UserRepository):
    """Concrete UserRepository backed by PostgreSQL via SQLAlchemy async."""

    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def save(self, user: User) -> User:
        """Persist a User domain entity and return it.

        Raises:
            DuplicateEmailError: If a unique constraint violation occurs.
        """
        from sqlalchemy.exc import IntegrityError

        model = UserModel(
            id=user.id,
            email=user.email,
            password_hash=user.password_hash,
            full_name=user.full_name,
            role=user.role.value,
            is_verified=user.is_verified,
            created_at=user.created_at,
            updated_at=user.updated_at,
        )
        self._session.add(model)
        try:
            await self._session.flush()
        except IntegrityError as exc:
            await self._session.rollback()
            if "users_email_key" in str(exc.orig) or "unique" in str(exc.orig).lower():
                raise DuplicateEmailError(user.email) from exc
            raise
        return self._model_to_entity(model)

    async def find_by_email(self, email: str) -> User | None:
        result = await self._session.execute(select(UserModel).where(UserModel.email == email))
        model = result.scalar_one_or_none()
        return self._model_to_entity(model) if model else None

    async def find_by_id(self, user_id: UUID) -> User | None:
        result = await self._session.execute(select(UserModel).where(UserModel.id == user_id))
        model = result.scalar_one_or_none()
        return self._model_to_entity(model) if model else None

    @staticmethod
    def _model_to_entity(model: UserModel) -> User:
        """Convert ORM model to domain entity."""
        return User(
            id=model.id,
            email=model.email,
            password_hash=model.password_hash,
            full_name=model.full_name,
            role=UserRole(model.role),
            is_verified=model.is_verified,
            created_at=model.created_at,
            updated_at=model.updated_at,
        )


class SqlAlchemyFamilyRepository(FamilyRepository):
    """Concrete FamilyRepository backed by PostgreSQL via SQLAlchemy async."""

    def __init__(self, session: AsyncSession) -> None:
        self._session = session

    async def save(self, family: Family) -> Family:
        model = FamilyModel(
            id=family.id,
            name=family.name,
            owner_id=family.owner_id,
            created_at=family.created_at,
            updated_at=family.updated_at,
        )
        self._session.add(model)
        await self._session.flush()
        return self._model_to_entity(model)

    async def find_by_id(self, family_id: UUID) -> Family | None:
        result = await self._session.execute(select(FamilyModel).where(FamilyModel.id == family_id))
        model = result.scalar_one_or_none()
        return self._model_to_entity(model) if model else None

    async def find_by_owner(self, owner_id: UUID) -> list[Family]:
        result = await self._session.execute(
            select(FamilyModel).where(FamilyModel.owner_id == owner_id)
        )
        return [self._model_to_entity(m) for m in result.scalars().all()]

    @staticmethod
    def _model_to_entity(model: FamilyModel) -> Family:
        """Convert ORM model to domain entity."""
        return Family(
            id=model.id,
            name=model.name,
            owner_id=model.owner_id,
            created_at=model.created_at,
            updated_at=model.updated_at,
        )
