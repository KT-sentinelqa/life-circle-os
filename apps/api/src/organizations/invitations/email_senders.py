import logging

from src.organizations.invitations.email_protocol import EmailSenderProtocol

logger = logging.getLogger(__name__)


class ConsoleEmailSender(EmailSenderProtocol):
    async def send_invitation(
        self,
        email: str,
        organization_name: str,
        invitation_link: str,
    ) -> None:
        logger.info(
            "--- EMAIL INVITATION ---\n"
            f"To: {email}\n"
            f"Subject: You have been invited to join {organization_name}\n"
            f"Body: Please click the following link to accept the invitation:\n"
            f"{invitation_link}\n"
            "------------------------"
        )
