from uuid import uuid4

import pytest
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select

from src.audit.models import AuditLog
from src.audit.service import log_audit_event, publish_audit_event
from src.outbox.models import OutboxEvent


@pytest.mark.asyncio
async def test_audit_event_creation(db_session: AsyncSession, test_user):
    user_id = test_user.id
    log_audit_event(
        session=db_session,
        event_type="test_action",
        user_id=user_id,
        ip_address="192.168.1.1",
        user_agent="pytest",
    )
    await db_session.commit()

    result = await db_session.execute(select(AuditLog).filter(AuditLog.event_type == "test_action"))
    audit = result.scalars().first()

    assert audit is not None
    assert audit.user_id == user_id
    assert audit.ip_address == "192.168.1.1"
    assert audit.user_agent == "pytest"
    assert audit.created_at is not None


@pytest.mark.asyncio
async def test_publish_audit_metadata(db_session: AsyncSession):
    user_id = uuid4()
    publish_audit_event(
        session=db_session,
        event_type="auth.login",
        user_id=user_id,
        ip_address="10.0.0.1",
        user_agent="Mozilla",
    )
    await db_session.commit()

    result = await db_session.execute(
        select(OutboxEvent).filter(OutboxEvent.event_type == "audit_log_v1")
    )
    event = result.scalars().first()

    assert event is not None
    assert event.aggregate_type == "audit"
    assert event.aggregate_id == str(user_id)

    import json

    payload = json.loads(event.payload)
    assert payload["event_type"] == "audit_log_v1"
    assert payload["action"] == "auth.login"
    assert payload["user_id"] == str(user_id)
    assert payload["ip_address"] == "10.0.0.1"
    assert payload["user_agent"] == "Mozilla"
