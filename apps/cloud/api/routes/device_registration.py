from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
import logging

router = APIRouter()
logger = logging.getLogger(__name__)

class DeviceRegistrationRequest(BaseModel):
    device_id: str
    user_id: str
    family_id: str
    public_key_pem: str

class DeviceRegistrationResponse(BaseModel):
    status: str
    jwt_token: str

@router.post("/register", response_model=DeviceRegistrationResponse)
async def register_device(request: DeviceRegistrationRequest):
    """
    ADR-028: Asymmetric Device Binding.
    The device sends its public key generated from the Secure Enclave.
    """
    # 1. Insert into Device table (Mocked for Phase 4.4C skeleton)
    logger.info(f"DEVICE_REGISTERED family_id_hash=MASKED status=SUCCESS")
    
    # 2. Issue a temporary session JWT
    token = "mock_jwt_token_for_phase_4_4c"
    
    return DeviceRegistrationResponse(status="registered", jwt_token=token)
