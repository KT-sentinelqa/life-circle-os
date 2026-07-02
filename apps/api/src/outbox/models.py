import enum
from datetime import UTC, datetime
from uuid import UUID, uuid4

from sqlalchemy import DateTime, Enum, String, Text
from sqlalchemy.orm import Mapped, mapped_column

from src.core.database import Base


class OutboxEventState(enum.Enum):
    PENDING = "pending"
    PROCESSED = "processed"
    FAILED = "failed"


class OutboxEvent(Base):
    __tablename__ = "outbox_events"

    id: Mapped[UUID] = mapped_column(primary_key=True, default=uuid4)
    aggregate_type: Mapped[str] = mapped_column(String(100), index=True)
    aggregate_id: Mapped[str] = mapped_column(String(255), index=True)
    event_type: Mapped[str] = mapped_column(String(100), index=True)
    payload: Mapped[str] = mapped_column(Text)

    status: Mapped[OutboxEventState] = mapped_column(
        Enum(OutboxEventState, name="outbox_event_state"),
        default=OutboxEventState.PENDING,
        index=True,
    )

    error_message: Mapped[str | None] = mapped_column(Text, nullable=True)

    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), default=lambda: datetime.now(UTC)
    )
    processed_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True), nullable=True)
