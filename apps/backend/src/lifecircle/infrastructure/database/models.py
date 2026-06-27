"""
LifeCircle OS — SQLAlchemy ORM models for auth entities.

IMPORTANT: These are infrastructure-layer persistence models.
They are NOT the domain entities. Conversion is handled in the repository adapters.

Table schemas are authoritative in Alembic migrations.
These models must remain in sync with the migration files.

Governed by: docs/epic-1-user-registration.md §3 | docs/database-architecture.md
"""

from __future__ import annotations

import uuid
from datetime import datetime

from sqlalchemy import (
    Boolean,
    CheckConstraint,
    DateTime,
    ForeignKey,
    Index,
    String,
    text,
)
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.sql import func

from lifecircle.infrastructure.database.connection import Base


class UserModel(Base):
    """ORM model mapping to the 'users' table.

    Mirrors the schema defined in:
      alembic/versions/0001_create_users_and_families.py
    """

    __tablename__ = "users"
    __table_args__ = (
        CheckConstraint(
            "role IN ('guardian', 'helper', 'dependent')",
            name="ck_users_role",
        ),
        Index("idx_users_email", "email"),
    )

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        primary_key=True,
        default=uuid.uuid4,
        server_default=text("gen_random_uuid()"),
    )
    email: Mapped[str] = mapped_column(
        String(255),
        unique=True,
        nullable=False,
        index=True,
    )
    password_hash: Mapped[str] = mapped_column(String(255), nullable=False)
    full_name: Mapped[str] = mapped_column(String(255), nullable=False)
    role: Mapped[str] = mapped_column(String(50), nullable=False)
    is_verified: Mapped[bool] = mapped_column(Boolean, nullable=False, default=False)
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        nullable=False,
        server_default=func.now(),
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        nullable=False,
        server_default=func.now(),
        onupdate=func.now(),
    )

    # Relationship back-reference — families owned by this user
    owned_families: Mapped[list[FamilyModel]] = relationship(
        "FamilyModel",
        back_populates="owner",
        cascade="all, delete-orphan",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<UserModel id={self.id} email={self.email!r}>"


class FamilyModel(Base):
    """ORM model mapping to the 'families' table.

    Mirrors the schema defined in:
      alembic/versions/0001_create_users_and_families.py
    """

    __tablename__ = "families"
    __table_args__ = (Index("idx_families_owner", "owner_id"),)

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        primary_key=True,
        default=uuid.uuid4,
        server_default=text("gen_random_uuid()"),
    )
    name: Mapped[str] = mapped_column(String(255), nullable=False)
    owner_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
    )
    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        nullable=False,
        server_default=func.now(),
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        nullable=False,
        server_default=func.now(),
        onupdate=func.now(),
    )

    # Relationship to owner
    owner: Mapped[UserModel] = relationship(
        "UserModel",
        back_populates="owned_families",
        lazy="selectin",
    )

    def __repr__(self) -> str:
        return f"<FamilyModel id={self.id} name={self.name!r} owner={self.owner_id}>"
