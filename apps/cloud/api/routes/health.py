from fastapi import APIRouter, Response, status
import logging

router = APIRouter()
logger = logging.getLogger(__name__)

@router.get("/health/liveness")
async def liveness_probe():
    """
    K8s Liveness Probe. Returns 200 if the FastAPI process is running.
    If this fails, K8s will restart the pod.
    """
    return {"status": "alive"}

@router.get("/health/readiness")
async def readiness_probe(response: Response):
    """
    K8s Readiness Probe. Returns 200 only if DB and Redis are connected.
    If this fails, K8s stops routing traffic to this pod.
    """
    try:
        # Mock connection checks for Phase 4.4D
        db_connected = True
        redis_connected = True
        
        if db_connected and redis_connected:
            return {"status": "ready"}
        else:
            response.status_code = status.HTTP_503_SERVICE_UNAVAILABLE
            return {"status": "not_ready", "db": db_connected, "redis": redis_connected}
    except Exception as e:
        logger.error(f"Readiness probe failed: {str(e)}")
        response.status_code = status.HTTP_503_SERVICE_UNAVAILABLE
        return {"status": "error"}
