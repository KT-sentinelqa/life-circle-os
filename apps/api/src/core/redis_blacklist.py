import redis.asyncio as redis

from src.core.config import settings
from src.core.token_blacklist import TokenBlacklistProtocol

redis_client: redis.Redis | None = None


async def get_redis() -> redis.Redis:
    global redis_client
    if redis_client is None:
        from redis.asyncio import Redis

        redis_client = Redis.from_url(settings.REDIS_URL, decode_responses=True)
    return redis_client


async def close_redis() -> None:
    global redis_client
    if redis_client:
        await redis_client.aclose()
        redis_client = None


class RedisTokenBlacklist(TokenBlacklistProtocol):
    async def blacklist_token(self, jti: str, expire_in_seconds: int) -> None:
        client = await get_redis()
        # Key expires in Redis exactly when the JWT naturally expires
        await client.setex(f"blacklist:{jti}", expire_in_seconds, "revoked")

    async def is_blacklisted(self, jti: str) -> bool:
        client = await get_redis()
        exists: int = await client.exists(f"blacklist:{jti}")
        return exists > 0
