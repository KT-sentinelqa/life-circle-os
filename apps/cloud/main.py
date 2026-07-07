from fastapi import FastAPI
from api.routes import device_registration, sync
import logging

# Configure minimal JSON logging for SEC-024 compliance
logging.basicConfig(format='{"time":"%(asctime)s", "level":"%(levelname)s", "message":"%(message)s"}', level=logging.INFO)

app = FastAPI(title="LifeCircle OS Cloud Trust Platform")

# Register Routers
app.include_router(device_registration.router, prefix="/api/v1/auth", tags=["auth"])
app.include_router(sync.router, prefix="/api/v1/sync", tags=["sync"])

@app.get("/health")
async def health_check():
    return {"status": "ok", "role": "coordinator"}
