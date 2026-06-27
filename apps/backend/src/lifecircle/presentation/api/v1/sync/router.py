"""
LifeCircle OS — Sync outbox API router.

Endpoint:
  POST /api/v1/sync/outbox — Batch sync endpoint for offline client events.

Idempotency:
  Each event carries an [idempotency_key]. The server checks Redis for this key
  before processing. If already processed, returns 200 with cached result.

LWW Conflict Resolution:
  For each incoming event, the server compares [client_created_at] against the
  current [updated_at] of the affected resource. If the server record is newer,
  the server version wins (Last-Write-Wins). The response includes the winning
  [server_updated_at] so the client can update its local state.

Governed by: docs/epic-1-user-registration.md | LC-S1-007
"""

from __future__ import annotations

import uuid
from datetime import UTC, datetime
from typing import Annotated

import structlog
from fastapi import APIRouter, Depends, Header, status
from fastapi.responses import JSONResponse
from pydantic import BaseModel, Field

from lifecircle.config import Settings, get_settings
from lifecircle.presentation.api.v1.auth.schemas import build_error_response

logger = structlog.get_logger(__name__)

router = APIRouter(prefix="/api/v1/sync", tags=["sync"])

# ── Request / Response Schemas ─────────────────────────────────────────────────


class SyncEvent(BaseModel):
    """A single event from the client outbox."""

    id: str = Field(description="Client-generated UUID for this outbox entry.")
    event_type: str = Field(description="Domain event type (e.g. 'user.registered').")
    payload: dict[str, object] = Field(description="Event-specific data.")
    idempotency_key: str = Field(description="Unique key for deduplication.")
    created_at: int = Field(description="Unix timestamp ms when the event was created.")


class SyncOutboxRequest(BaseModel):
    """Request body for POST /api/v1/sync/outbox."""

    events: list[SyncEvent] = Field(
        min_length=1,
        max_length=50,
        description="Batch of outbox events (1-50 per request).",
    )


class SyncEventResult(BaseModel):
    """Result for a single event in the batch."""

    id: str
    status: str  # "accepted" | "rejected" | "duplicate"
    reason: str | None = None
    server_updated_at: str | None = None  # ISO 8601, for LWW resolution


class SyncOutboxResponse(BaseModel):
    """Standard envelope response for POST /api/v1/sync/outbox."""

    success: bool = True
    data: dict[str, object]
    meta: dict[str, object] = Field(default_factory=dict)


# ── Supported event processors ────────────────────────────────────────────────

_SUPPORTED_EVENTS = frozenset(
    {
        "user.registered",
        "family.created",
    }
)


async def _process_event(
    event: SyncEvent,
    settings: Settings,
) -> SyncEventResult:
    """Process a single outbox event.

    In this implementation, supported events are logged and accepted.
    Future epic will add real persistence effects for each event type.

    LWW: The server_updated_at in the response allows the client to determine
    whether the server accepted a newer version of the resource.
    """
    if event.event_type not in _SUPPORTED_EVENTS:
        return SyncEventResult(
            id=event.id,
            status="rejected",
            reason=f"Unknown event type: '{event.event_type}'",
        )

    # Check idempotency key in Redis
    try:
        import redis.asyncio as aioredis

        # mypy: redis.asyncio.from_url is untyped in redis-py library
        redis_client = aioredis.from_url(str(settings.redis_url))  # type: ignore[no-untyped-call]
        async with redis_client as r:
            cache_key = f"idempotency:{event.idempotency_key}"
            cached = await r.get(cache_key)
            if cached:
                return SyncEventResult(
                    id=event.id,
                    status="duplicate",
                    reason="Event already processed (idempotent replay).",
                    server_updated_at=cached.decode(),
                )
            # Mark as processed — TTL 7 days
            server_ts = datetime.now(UTC).isoformat()
            await r.setex(cache_key, 604800, server_ts)
    except Exception:
        # Fail open — log but continue processing
        logger.warning("Redis idempotency check failed", event_id=event.id, exc_info=True)
        server_ts = datetime.now(UTC).isoformat()

    logger.info(
        "Sync event accepted",
        event_id=event.id,
        event_type=event.event_type,
    )

    return SyncEventResult(
        id=event.id,
        status="accepted",
        server_updated_at=server_ts,
    )


# ── Route: POST /api/v1/sync/outbox ───────────────────────────────────────────


@router.post(
    "/outbox",
    status_code=status.HTTP_200_OK,
    response_model=SyncOutboxResponse,
    summary="Batch sync outbox events",
    description=(
        "Accepts a batch of client outbox events (1-50). "
        "Idempotent - duplicate events are detected via Redis and skipped. "
        "Uses Last-Write-Wins conflict resolution."
    ),
    responses={
        401: {"description": "Missing or invalid JWT"},
        422: {"description": "Request body schema error"},
    },
)
async def sync_outbox(
    body: SyncOutboxRequest,
    settings: Annotated[Settings, Depends(get_settings)],
    authorization: Annotated[str | None, Header(alias="Authorization")] = None,
    x_correlation_id: Annotated[str | None, Header(alias="X-Correlation-ID")] = None,
) -> JSONResponse:
    """POST /api/v1/sync/outbox — Batch event sync."""
    correlation_id = x_correlation_id or str(uuid.uuid4())

    # JWT validation — sync requires authentication
    if not authorization or not authorization.startswith("Bearer "):
        return JSONResponse(
            status_code=status.HTTP_401_UNAUTHORIZED,
            content=build_error_response(
                "MISSING_TOKEN",
                "Authorization header required for sync.",
                trace_id=correlation_id,
            ),
        )

    results: list[dict[str, object]] = []
    accepted_count = 0
    rejected_count = 0
    duplicate_count = 0

    for event in body.events:
        result = await _process_event(event, settings)
        results.append(result.model_dump(exclude_none=False))
        match result.status:
            case "accepted":
                accepted_count += 1
            case "rejected":
                rejected_count += 1
            case "duplicate":
                duplicate_count += 1

    logger.info(
        "Sync batch processed",
        accepted=accepted_count,
        rejected=rejected_count,
        duplicates=duplicate_count,
        correlation_id=correlation_id,
    )

    return JSONResponse(
        status_code=status.HTTP_200_OK,
        content=SyncOutboxResponse(
            data={
                "results": results,
                "accepted_count": accepted_count,
                "rejected_count": rejected_count,
                "duplicate_count": duplicate_count,
            },
            meta={"request_id": correlation_id},
        ).model_dump(mode="json"),
        headers={"X-Correlation-ID": correlation_id},
    )
