from uuid import UUID

from sqlalchemy.ext.asyncio import AsyncSession

from src.audit.models import AuditLog
from src.outbox.publisher import publish_event


def log_audit_event(
    session: AsyncSession,
    event_type: str,
    user_id: UUID | str | None = None,
    ip_address: str | None = None,
    user_agent: str | None = None,
) -> None:
    """
    Creates an audit log entry in the database.
    """
    audit = AuditLog(
        user_id=user_id if isinstance(user_id, UUID) else (UUID(user_id) if user_id else None),
        event_type=event_type,
        ip_address=ip_address,
        user_agent=user_agent,
    )
    session.add(audit)


def publish_audit_event(
    session: AsyncSession,
    event_type: str,
    user_id: UUID | str | None = None,
    ip_address: str | None = None,
    user_agent: str | None = None,
) -> None:
    """
    Publishes an audit event to the outbox for asynchronous processing.
    """
    from src.outbox.schemas import AuditLogEventV1

    event = AuditLogEventV1(
        action=event_type,
        user_id=str(user_id) if user_id else None,
        ip_address=ip_address,
        user_agent=user_agent,
    )

    publish_event(
        session=session,
        aggregate_type="audit",
        aggregate_id=str(user_id) if user_id else "system",
        event=event,
    )
