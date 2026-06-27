import asyncio
import os
import sys

# Add src to python path to resolve lifecircle imports
sys.path.append(os.path.join(os.path.dirname(__file__), "..", "src"))

from sqlalchemy import text
from lifecircle.config import get_settings
from lifecircle.infrastructure.database.connection import build_engine

async def main():
    settings = get_settings()
    engine = build_engine(settings)
    
    # 1. Truncate tables
    async with engine.begin() as conn:
        await conn.execute(text("TRUNCATE TABLE families, users RESTART IDENTITY CASCADE;"))
    await engine.dispose()
    
    # 2. Clear Redis rate limiter keys
    import redis.asyncio as aioredis
    redis_client = aioredis.from_url(str(settings.redis_url))
    async with redis_client as r:
        keys = await r.keys("rl:*")
        if keys:
            await r.delete(*keys)
    
    print("Test database and Redis rate-limits cleared successfully.")

if __name__ == "__main__":
    asyncio.run(main())
