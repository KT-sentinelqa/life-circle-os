from src.core.token_blacklist import TokenBlacklistProtocol


class InMemoryTokenBlacklist(TokenBlacklistProtocol):
    def __init__(self) -> None:
        self.blacklisted_jtis: set[str] = set()

    async def blacklist_token(self, jti: str, expire_in_seconds: int) -> None:
        self.blacklisted_jtis.add(jti)

    async def is_blacklisted(self, jti: str) -> bool:
        return jti in self.blacklisted_jtis
