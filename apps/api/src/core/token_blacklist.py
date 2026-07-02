from typing import Protocol


class TokenBlacklistProtocol(Protocol):
    async def blacklist_token(self, jti: str, expire_in_seconds: int) -> None: ...

    async def is_blacklisted(self, jti: str) -> bool: ...
