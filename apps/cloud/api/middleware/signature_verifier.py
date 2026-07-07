from fastapi import Request, HTTPException
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import padding
from cryptography.hazmat.primitives.serialization import load_pem_public_key
import base64
import json
import logging

logger = logging.getLogger(__name__)

async def verify_signature(request: Request, public_key_pem: str, signature_b64: str, payload_bytes: bytes) -> bool:
    """
    SEC-023: Verifies that the payload was signed by the Device's Secure Enclave Private Key.
    """
    try:
        public_key = load_pem_public_key(public_key_pem.encode('utf-8'))
        signature = base64.b64decode(signature_b64)
        
        # Verify
        public_key.verify(
            signature,
            payload_bytes,
            padding.PKCS1v15(),
            hashes.SHA256()
        )
        return True
    except Exception as e:
        logger.warning(f"Signature verification failed: {str(e)}")
        raise HTTPException(status_code=401, detail="Invalid cryptographic signature")
