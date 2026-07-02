from fastapi import APIRouter, Depends, Response, status
from sqlalchemy import text
from sqlalchemy.ext.asyncio import AsyncSession

from src.core.database import get_db
from src.core.logger import get_logger
from src.core.redis_blacklist import get_redis

logger = get_logger(__name__)

router = APIRouter(prefix="/health", tags=["Health"])


@router.get("", status_code=status.HTTP_200_OK)
async def legacy_health_check():
    """
    Legacy health check endpoint for backward compatibility.
    """
    return {"status": "ok", "service": "life-circle-api"}


@router.get("/live", status_code=status.HTTP_200_OK)
async def liveness_probe():
    """
    Basic application heartbeat. Returns 200 OK if the service is running.
    """
    return {"status": "ok", "service": "life-circle-api"}


@router.get("/ready", status_code=status.HTTP_200_OK)
async def readiness_probe(response: Response, session: AsyncSession = Depends(get_db)):
    """
    Deep health check verifying connectivity to critical dependencies (PostgreSQL, Redis).
    """
    health_status = {"status": "ready", "dependencies": {"postgres": "unknown", "redis": "unknown"}}

    # Check PostgreSQL
    try:
        await session.execute(text("SELECT 1"))
        health_status["dependencies"]["postgres"] = "up"
    except Exception as e:
        logger.error(f"PostgreSQL health check failed: {e}")
        health_status["dependencies"]["postgres"] = "down"
        health_status["status"] = "not_ready"

    # Check Redis
    try:
        redis_client = await get_redis()
        pong = await redis_client.ping()
        if pong:
            health_status["dependencies"]["redis"] = "up"
        else:
            health_status["dependencies"]["redis"] = "down"
            health_status["status"] = "not_ready"
    except Exception as e:
        logger.error(f"Redis health check failed: {e}")
        health_status["dependencies"]["redis"] = "down"
        health_status["status"] = "not_ready"

    if health_status["status"] != "ready":
        response.status_code = status.HTTP_503_SERVICE_UNAVAILABLE

    return health_status
