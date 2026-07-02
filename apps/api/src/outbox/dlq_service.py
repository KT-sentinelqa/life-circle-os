from collections.abc import Sequence

from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from src.core.logger import get_logger
from src.outbox.models import OutboxEvent, OutboxEventState

logger = get_logger(__name__)


async def get_failed_events(session: AsyncSession, limit: int = 100) -> Sequence[OutboxEvent]:
    """
    Fetches events that have permanently failed processing.
    """
    result = await session.execute(
        select(OutboxEvent)
        .filter(OutboxEvent.status == OutboxEventState.FAILED)
        .order_by(OutboxEvent.created_at.asc())
        .limit(limit)
    )
    return result.scalars().all()


async def replay_event(session: AsyncSession, event_id: str) -> bool:
    """
    Replays a specific failed event by resetting its status to PENDING.
    Returns True if the event was found and updated, False otherwise.
    """
    import uuid

    try:
        parsed_id = uuid.UUID(event_id)
    except ValueError:
        return False

    result = await session.execute(select(OutboxEvent).filter(OutboxEvent.id == parsed_id))
    event = result.scalars().first()

    if not event or event.status != OutboxEventState.FAILED:
        return False

    event.status = OutboxEventState.PENDING
    event.error_message = None
    # Assuming retries logic exists or just resetting for a fresh attempt

    await session.commit()
    logger.info(f"Requeued event {event_id} for processing")
    return True
