import json

import pytest
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from src.audit.models import AuditLog
from src.outbox.models import OutboxEvent, OutboxEventState
from src.worker.main import process_outbox_events


@pytest.mark.asyncio
async def test_outbox_event_processed(db_session: AsyncSession, test_user):
    user_id = test_user.id
    payload = {
        "action": "user.login",
        "user_id": str(user_id),
        "ip_address": "127.0.0.1",
        "user_agent": "test",
    }

    event = OutboxEvent(
        aggregate_type="audit",
        aggregate_id=str(user_id),
        event_type="audit_log_v1",
        payload=json.dumps(payload),
        status=OutboxEventState.PENDING,
    )
    db_session.add(event)
    await db_session.commit()

    # Run the worker function
    await process_outbox_events({}, test_session=db_session)

    # Check that event is processed
    result = await db_session.execute(select(OutboxEvent).filter(OutboxEvent.id == event.id))
    processed_event = result.scalars().first()

    assert processed_event.status == OutboxEventState.PROCESSED

    # Check that audit log was created
    audit_result = await db_session.execute(select(AuditLog).filter(AuditLog.user_id == user_id))
    audit = audit_result.scalars().first()

    assert audit is not None
    assert audit.event_type == "user.login"


@pytest.mark.asyncio
async def test_failure_handling(db_session: AsyncSession):
    event = OutboxEvent(
        aggregate_type="unknown",
        aggregate_id="123",
        event_type="audit_log_v1",
        payload="invalid json",  # This will cause json.loads to fail
        status=OutboxEventState.PENDING,
    )
    db_session.add(event)
    await db_session.commit()

    # Run the worker function
    await process_outbox_events({}, test_session=db_session)

    # Check that event failed
    result = await db_session.execute(select(OutboxEvent).filter(OutboxEvent.id == event.id))
    failed_event = result.scalars().first()

    assert failed_event.status == OutboxEventState.FAILED
    assert failed_event.error_message is not None


@pytest.mark.asyncio
async def test_idempotency(db_session: AsyncSession, test_user):
    user_id = test_user.id
    payload = {"action": "user.logout", "user_id": str(user_id)}

    event = OutboxEvent(
        aggregate_type="audit",
        aggregate_id=str(user_id),
        event_type="audit_log_v1",
        payload=json.dumps(payload),
        status=OutboxEventState.PENDING,
    )
    db_session.add(event)
    await db_session.commit()

    # Run the worker function twice
    await process_outbox_events({}, test_session=db_session)
    await process_outbox_events({}, test_session=db_session)

    # Should only be processed once because it was marked PROCESSED in the first run
    audit_result = await db_session.execute(select(AuditLog).filter(AuditLog.user_id == user_id))
    audits = audit_result.scalars().all()

    assert len(audits) == 1


@pytest.mark.asyncio
async def test_email_delivery_event_processed(db_session: AsyncSession, monkeypatch):
    # Mock aiosmtplib.send
    sent_messages = []

    async def mock_send(message, **kwargs):
        sent_messages.append((message, kwargs))
        return ({}, "OK")

    monkeypatch.setattr("aiosmtplib.send", mock_send)

    payload = {
        "to_email": "test@example.com",
        "subject": "You are invited!",
        "template_name": "organization_invitation",
        "template_context": {
            "organization_name": "Test Org",
            "invitation_link": "http://test/accept",
        },
    }

    event = OutboxEvent(
        aggregate_type="invitation",
        aggregate_id="123",
        event_type="email_delivery_v1",
        payload=json.dumps(payload),
        status=OutboxEventState.PENDING,
    )
    db_session.add(event)
    await db_session.commit()

    # Run the worker function
    await process_outbox_events({}, test_session=db_session)

    # Check that event is processed
    result = await db_session.execute(select(OutboxEvent).filter(OutboxEvent.id == event.id))
    processed_event = result.scalars().first()

    assert processed_event.status == OutboxEventState.PROCESSED

    # Check that email was sent
    assert len(sent_messages) == 1
    msg, kwargs = sent_messages[0]

    assert msg["To"] == "test@example.com"
    assert "Test Org" in msg.get_content()
