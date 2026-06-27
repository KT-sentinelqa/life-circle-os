"""
LifeCircle OS — SQLAlchemy async engine and session factory.

Governed by: docs/database-architecture.md | docs/coding-standards.md
"""

from __future__ import annotations

from collections.abc import AsyncGenerator
from typing import Annotated

from fastapi import Depends
from sqlalchemy.ext.asyncio import (
    AsyncSession,
    async_sessionmaker,
    create_async_engine,
)
from sqlalchemy.orm import DeclarativeBase

from lifecircle.config import Settings, get_settings


class Base(DeclarativeBase):
    """Shared SQLAlchemy declarative base for all ORM models."""


def build_engine(settings: Settings):  # type: ignore[no-untyped-def]
    """Create the async SQLAlchemy engine from application settings.

    Args:
        settings: The validated application settings instance.

    Returns:
        An async SQLAlchemy engine.
    """
    return create_async_engine(
        str(settings.database_url),
        echo=settings.app_debug,
        pool_size=5,
        max_overflow=10,
        pool_pre_ping=True,
    )


def build_session_factory(settings: Settings) -> async_sessionmaker[AsyncSession]:
    """Create the async session factory bound to the engine.

    Args:
        settings: The validated application settings instance.
    """
    engine = build_engine(settings)
    return async_sessionmaker(
        engine,
        class_=AsyncSession,
        expire_on_commit=False,
    )


# ── FastAPI Dependency ─────────────────────────────────────────────────────────


async def get_db_session(
    settings: Annotated[Settings, Depends(get_settings)],
) -> AsyncGenerator[AsyncSession, None]:
    """FastAPI dependency that yields a database session per request.

    Rolls back on exception, always closes the session.

    Usage:
        async def my_route(db: Annotated[AsyncSession, Depends(get_db_session)]):
            ...
    """
    session_factory = build_session_factory(settings)
    async with session_factory() as session:
        try:
            yield session
            await session.commit()
        except Exception:
            await session.rollback()
            raise
