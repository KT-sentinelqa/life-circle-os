import urllib.parse

from arq.connections import RedisSettings
from arq.cron import cron

from src.core.config import settings
from src.worker.main import process_outbox_events

parsed = urllib.parse.urlparse(settings.REDIS_URL)
redis_settings = RedisSettings(
    host=parsed.hostname or "localhost",
    port=parsed.port or 6379,
    database=int(parsed.path.strip("/")) if parsed.path and parsed.path.strip("/") else 0,
)


class WorkerSettings:
    redis_settings = redis_settings
    cron_jobs = [
        # Run outbox processing every 5 seconds
        cron(process_outbox_events, second=set(range(0, 60, 5)))
    ]
    # Register any background tasks that are not cron-based
    functions = []
