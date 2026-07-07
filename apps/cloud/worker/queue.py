import logging

logger = logging.getLogger(__name__)

class RedisQueueMock:
    """
    Mocks the Redis queue for distributing ingested events to the Family's outboxes.
    """
    def publish_event(self, family_id: str, event_id: str):
        # Fan-out to all active devices in the family (excluding the sender)
        logger.info(f"EVENT_PUBLISHED family_id_hash=MASKED event_id={event_id}")
        pass

redis_queue = RedisQueueMock()
