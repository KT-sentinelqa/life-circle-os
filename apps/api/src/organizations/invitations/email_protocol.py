from typing import Protocol


class EmailSenderProtocol(Protocol):
    async def send_invitation(
        self,
        email: str,
        organization_name: str,
        invitation_link: str,
    ) -> None: ...
