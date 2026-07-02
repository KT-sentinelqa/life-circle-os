import enum
from datetime import UTC, datetime
from uuid import UUID, uuid4

import sqlalchemy as sa
from sqlalchemy import DateTime, Enum, ForeignKey, Index, String, UniqueConstraint
from sqlalchemy.orm import Mapped, mapped_column, relationship

from src.core.database import Base


class PermissionType(enum.Enum):
    ORGANIZATION_READ = "organization.read"
    ORGANIZATION_UPDATE = "organization.update"
    ORGANIZATION_DELETE = "organization.delete"
    MEMBERS_READ = "members.read"
    MEMBERS_INVITE = "members.invite"
    MEMBERS_UPDATE = "members.update"
    MEMBERS_REMOVE = "members.remove"
    BILLING_READ = "billing.read"
    BILLING_MANAGE = "billing.manage"
    PROFILE_MANAGE = "profile.manage"


class Role(Base):
    __tablename__ = "roles"
    __table_args__ = (
        UniqueConstraint("organization_id", "name", name="uq_roles_org_name"),
        Index(
            "uq_roles_global_name",
            "name",
            unique=True,
            postgresql_where=sa.text("organization_id IS NULL"),
        ),
    )

    id: Mapped[UUID] = mapped_column(primary_key=True, default=uuid4)
    organization_id: Mapped[UUID | None] = mapped_column(
        ForeignKey("organizations.id", ondelete="CASCADE"),
        index=True,
        nullable=True,  # Null for system-wide default roles
    )
    name: Mapped[str] = mapped_column(String(50), index=True)
    description: Mapped[str | None] = mapped_column(String(255))
    is_system_default: Mapped[bool] = mapped_column(default=False)

    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=lambda: datetime.now(UTC)
    )
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        default=lambda: datetime.now(UTC),
        onupdate=lambda: datetime.now(UTC),
    )

    permissions: Mapped[list["RolePermission"]] = relationship(
        back_populates="role", cascade="all, delete-orphan"
    )


class RolePermission(Base):
    __tablename__ = "role_permissions"
    __table_args__ = (UniqueConstraint("role_id", "permission", name="uq_role_permission"),)

    id: Mapped[UUID] = mapped_column(primary_key=True, default=uuid4)
    role_id: Mapped[UUID] = mapped_column(ForeignKey("roles.id", ondelete="CASCADE"), index=True)
    permission: Mapped[PermissionType] = mapped_column(
        Enum(PermissionType, name="permission_type"), index=True
    )

    role: Mapped["Role"] = relationship(back_populates="permissions")
