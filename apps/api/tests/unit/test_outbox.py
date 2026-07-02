import json

import pytest
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from src.outbox.models import OutboxEvent, OutboxEventState
from src.outbox.publisher import publish_event


@pytest.mark.asyncio
async def test_publish_event(db_session: AsyncSession):
    from src.outbox.schemas import ConfigDict, EventBase

    class DummyEvent(EventBase):
        event_type: str = "test_event"
        foo: str
        retry_count: int
        model_config = ConfigDict(extra="allow")

    event = DummyEvent(foo="bar", retry_count=0)

    publish_event(
        session=db_session,
        aggregate_type="test_aggregate",
        aggregate_id="123",
        event=event,
    )
    await db_session.commit()

    result = await db_session.execute(select(OutboxEvent).filter(OutboxEvent.aggregate_id == "123"))
    event = result.scalars().first()

    assert event is not None
    assert event.aggregate_type == "test_aggregate"
    assert event.event_type == "test_event"
    assert event.status == OutboxEventState.PENDING
    assert event.processed_at is None

    # Test payload serialization
    saved_payload = json.loads(event.payload)
    assert saved_payload["foo"] == "bar"
    assert saved_payload["retry_count"] == 0


@pytest.mark.asyncio
async def test_mark_processed(db_session: AsyncSession):
    event = OutboxEvent(
        aggregate_type="test", aggregate_id="test_id", event_type="event", payload="{}"
    )
    db_session.add(event)
    await db_session.commit()

    event.status = OutboxEventState.PROCESSED
    db_session.add(event)
    await db_session.commit()

    assert event.status == OutboxEventState.PROCESSED


@pytest.mark.asyncio
async def test_retry_behavior_status(db_session: AsyncSession):
    event = OutboxEvent(
        aggregate_type="test", aggregate_id="test_id", event_type="event", payload="{}"
    )
    db_session.add(event)
    await db_session.commit()

    # Simulating failure
    event.status = OutboxEventState.FAILED
    event.error_message = "Network error"
    db_session.add(event)
    await db_session.commit()

    assert event.status == OutboxEventState.FAILED
    assert event.error_message == "Network error"
