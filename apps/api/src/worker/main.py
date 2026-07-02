import json
import time
from typing import Any

from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from src.core.database import AsyncSessionLocal
from src.core.logger import get_logger, setup_logger
from src.observability.metrics import (
    EMAIL_DELIVERY_TOTAL,
    OUTBOX_PROCESSING_DURATION,
    OUTBOX_QUEUE_DEPTH,
)
from src.outbox.models import OutboxEvent, OutboxEventState

setup_logger()
logger = get_logger(__name__)


async def process_outbox_events(
    ctx: dict[str, Any], test_session: AsyncSession | None = None
) -> None:
    """
    Task to poll and process outbox events.
    """
    if test_session is not None:
        await _process_with_session(test_session)
    else:
        async with AsyncSessionLocal() as session:
            await _process_with_session(session)


async def _process_with_session(session: AsyncSession) -> None:
    # 1. Fetch pending events
    result = await session.execute(
        select(OutboxEvent)
        .filter(OutboxEvent.status == OutboxEventState.PENDING)
        .order_by(OutboxEvent.created_at.asc())
        .limit(100)
    )
    events = result.scalars().all()

    # Update queue depth gauge
    OUTBOX_QUEUE_DEPTH.set(len(events))

    for event in events:
        start_time = time.perf_counter()
        try:
            # 2. Route event to handlers based on event_type
            payload = json.loads(event.payload)
            await dispatch_event(session, event.aggregate_type, event.event_type, payload)

            # 3. Mark as processed
            event.status = OutboxEventState.PROCESSED
            duration = time.perf_counter() - start_time
            OUTBOX_PROCESSING_DURATION.labels(
                event_type=event.event_type, status="success"
            ).observe(duration)
        except Exception as e:
            logger.error(f"Failed to process event {event.id}: {e}")
            event.status = OutboxEventState.FAILED
            event.error_message = str(e)
            duration = time.perf_counter() - start_time
            OUTBOX_PROCESSING_DURATION.labels(
                event_type=event.event_type, status="failure"
            ).observe(duration)

        # Commit after each event to avoid large transaction blocks
        await session.commit()


async def dispatch_event(
    session: AsyncSession, aggregate_type: str, event_type: str, payload: dict[str, Any]
) -> None:
    """
    Routes events to their respective handlers.
    """
    if event_type == "audit_log_v1":
        from src.audit.service import log_audit_event

        log_audit_event(
            session=session,
            event_type=payload.get("action", "unknown"),
            user_id=payload.get("user_id"),
            ip_address=payload.get("ip_address"),
            user_agent=payload.get("user_agent"),
        )
    elif event_type == "email_delivery_v1":
        from src.notifications.email import SMTPProvider

        email_sender = SMTPProvider()
        # Right now we only have one template defined
        if payload.get("template_name") == "organization_invitation":
            ctx = payload.get("template_context", {})
            try:
                await email_sender.send_invitation(
                    email=payload.get("to_email"),
                    organization_name=ctx.get("organization_name", "Unknown"),
                    invitation_link=ctx.get("invitation_link", "#"),
                )
                EMAIL_DELIVERY_TOTAL.labels(status="success").inc()
            except Exception as e:
                EMAIL_DELIVERY_TOTAL.labels(status="failure").inc()
                raise e
        else:
            logger.warning(f"Unknown template_name: {payload.get('template_name')}")
    pass
