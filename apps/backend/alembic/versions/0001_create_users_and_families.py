"""
0001 — Create users and families tables.

Implements the exact schema specified in:
  docs/epic-1-user-registration.md §3

Rollback: Fully implemented in downgrade().
          Verified by: make migrate-base (run before each production deploy review).

Governed by: docs/golden-path/database-change.md (Expand-Contract pattern)
"""

from __future__ import annotations

import sqlalchemy as sa
from alembic import op

# Revision metadata
revision = "0001"
down_revision = None
branch_labels = None
depends_on = None


def upgrade() -> None:
    """Create users and families tables with indexes and constraints."""

    # ── users table ───────────────────────────────────────────────────────────
    op.create_table(
        "users",
        sa.Column(
            "id",
            sa.dialects.postgresql.UUID(as_uuid=True),  # type: ignore[attr-defined]
            primary_key=True,
            server_default=sa.text("gen_random_uuid()"),
            nullable=False,
        ),
        sa.Column("email", sa.String(255), nullable=False),
        sa.Column("password_hash", sa.String(255), nullable=False),
        sa.Column("full_name", sa.String(255), nullable=False),
        sa.Column("role", sa.String(50), nullable=False),
        sa.Column("is_verified", sa.Boolean(), nullable=False, server_default="false"),
        sa.Column(
            "created_at",
            sa.DateTime(timezone=True),
            nullable=False,
            server_default=sa.text("CURRENT_TIMESTAMP"),
        ),
        sa.Column(
            "updated_at",
            sa.DateTime(timezone=True),
            nullable=False,
            server_default=sa.text("CURRENT_TIMESTAMP"),
        ),
        sa.UniqueConstraint("email", name="uq_users_email"),
        sa.CheckConstraint(
            "role IN ('guardian', 'helper', 'dependent')",
            name="ck_users_role",
        ),
    )
    op.create_index("idx_users_email", "users", ["email"], unique=True)

    # ── families table ────────────────────────────────────────────────────────
    op.create_table(
        "families",
        sa.Column(
            "id",
            sa.dialects.postgresql.UUID(as_uuid=True),  # type: ignore[attr-defined]
            primary_key=True,
            server_default=sa.text("gen_random_uuid()"),
            nullable=False,
        ),
        sa.Column("name", sa.String(255), nullable=False),
        sa.Column(
            "owner_id",
            sa.dialects.postgresql.UUID(as_uuid=True),  # type: ignore[attr-defined]
            sa.ForeignKey("users.id", ondelete="CASCADE", name="fk_families_owner_id"),
            nullable=False,
        ),
        sa.Column(
            "created_at",
            sa.DateTime(timezone=True),
            nullable=False,
            server_default=sa.text("CURRENT_TIMESTAMP"),
        ),
        sa.Column(
            "updated_at",
            sa.DateTime(timezone=True),
            nullable=False,
            server_default=sa.text("CURRENT_TIMESTAMP"),
        ),
    )
    op.create_index("idx_families_owner", "families", ["owner_id"])


def downgrade() -> None:
    """Drop families then users (respects FK dependency order).

    Rollback verified by: make migrate-base
    Must succeed cleanly before any production deployment is approved.
    """
    op.drop_table("families")
    op.drop_table("users")
