from sqlalchemy import Column, String, Integer, DateTime, JSON, UniqueConstraint
from sqlalchemy.orm import declarative_base
from datetime import datetime, UTC

Base = declarative_base()

class Device(Base):
    __tablename__ = "devices"
    
    device_id = Column(String, primary_key=True, index=True)
    user_id = Column(String, index=True, nullable=False)
    family_id = Column(String, index=True, nullable=False)
    public_key_pem = Column(String, nullable=False)
    created_at = Column(DateTime, default=lambda: datetime.now(UTC))
    
    # Optional: status (active, revoked) for Remote Wipe scenarios (SEC-019)
    status = Column(String, default="active")

class SyncEventRecord(Base):
    """
    The persisted canonical envelope. 
    Notice we store the raw JSON payload, enforcing the Dumb Pipeline principle.
    """
    __tablename__ = "sync_events"
    
    event_id = Column(String, primary_key=True)
    idempotency_key = Column(String, nullable=False, unique=True, index=True)
    event_type = Column(String, nullable=False)
    schema_version = Column(Integer, nullable=False)
    aggregate_id = Column(String, index=True, nullable=False)
    device_id = Column(String, nullable=False)
    user_id = Column(String, nullable=False)
    family_id = Column(String, index=True, nullable=False)
    logical_timestamp = Column(Integer, nullable=False)
    
    payload_json = Column(JSON, nullable=False)
    signature = Column(String, nullable=False)
    
    # System timestamps
    received_at = Column(DateTime, default=lambda: datetime.now(UTC))
