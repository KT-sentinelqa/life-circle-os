from sqlalchemy.ext.asyncio import AsyncSession

from src.outbox.models import OutboxEvent
from src.outbox.schemas import EventBase


def publish_event(
    session: AsyncSession,
    aggregate_type: str,
    aggregate_id: str,
    event: EventBase,
) -> None:
    """
    Publishes an event to the outbox table within the current transaction.
    """
    outbox_event = OutboxEvent(
        aggregate_type=aggregate_type,
        aggregate_id=aggregate_id,
        event_type=event.event_type,
        payload=event.model_dump_json(),
    )
    session.add(outbox_event)
