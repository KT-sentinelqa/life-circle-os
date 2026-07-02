from typing import Any, Literal

from pydantic import BaseModel, ConfigDict, Field


class EventBase(BaseModel):
    """Base class for all Outbox Events"""

    event_type: str

    model_config = ConfigDict(extra="forbid")


class AuditLogEventV1(EventBase):
    event_type: Literal["audit_log_v1"] = "audit_log_v1"
    action: str
    user_id: str | None = None
    ip_address: str | None = None
    user_agent: str | None = None


class EmailDeliveryEventV1(EventBase):
    event_type: Literal["email_delivery_v1"] = "email_delivery_v1"
    to_email: str
    subject: str
    template_name: str
    template_context: dict[str, Any] = Field(default_factory=dict)
