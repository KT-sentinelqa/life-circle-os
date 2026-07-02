from src.organizations.invitations.email_protocol import EmailSenderProtocol


class FakeEmailSender(EmailSenderProtocol):
    def __init__(self):
        self.sent_emails = []

    async def send_invitation(
        self,
        email: str,
        organization_name: str,
        invitation_link: str,
    ) -> None:
        self.sent_emails.append(
            {
                "to": email,
                "org": organization_name,
                "link": invitation_link,
            }
        )
