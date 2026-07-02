import os
from email.message import EmailMessage

import aiosmtplib

from src.core.logger import get_logger
from src.organizations.invitations.email_protocol import EmailSenderProtocol

logger = get_logger(__name__)


class SMTPProvider(EmailSenderProtocol):
    def __init__(self):
        self.host = os.getenv("SMTP_HOST", "localhost")
        self.port = int(os.getenv("SMTP_PORT", "1025"))  # Default to MailHog/Mailpit
        self.username = os.getenv("SMTP_USER", "")
        self.password = os.getenv("SMTP_PASS", "")
        self.use_tls = os.getenv("SMTP_TLS", "false").lower() == "true"
        self.from_email = os.getenv("SMTP_FROM", "noreply@lifecircle.os")

    async def send_invitation(
        self,
        email: str,
        organization_name: str,
        invitation_link: str,
    ) -> None:
        message = EmailMessage()
        message["From"] = self.from_email
        message["To"] = email
        message["Subject"] = f"You have been invited to {organization_name}"

        content = (
            f"Hello,\n\n"
            f"You have been invited to join the organization '{organization_name}'.\n"
            f"Please click the link below to accept the invitation:\n"
            f"{invitation_link}\n\n"
            f"Best regards,\nLife Circle OS Team"
        )
        message.set_content(content)

        logger.info("Sending invitation email", to=email, org=organization_name)

        await aiosmtplib.send(
            message,
            hostname=self.host,
            port=self.port,
            username=self.username if self.username else None,
            password=self.password if self.password else None,
            use_tls=self.use_tls,
        )
        logger.info("Invitation email sent successfully", to=email)
