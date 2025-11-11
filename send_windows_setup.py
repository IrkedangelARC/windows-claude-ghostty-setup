#!/usr/bin/env python3
"""
Send Windows setup package email with attachment
Uses Gmail API infrastructure from arc-events project
"""

import sys
import os
import base64
import pickle
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
from google.auth.transport.requests import Request
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build

# Add arc-events to path for email_safety module
sys.path.insert(0, '/Users/michaelgodinez/Projects/arc-projects/arc-events')
import email_safety

# Gmail API scopes
GMAIL_SCOPES = [
    'https://www.googleapis.com/auth/gmail.modify',
    'https://www.googleapis.com/auth/gmail.send',
]

# Paths for arc-events credentials
ARC_EVENTS_DIR = '/Users/michaelgodinez/Projects/arc-projects/arc-events'
CREDENTIALS_FILE = os.path.join(ARC_EVENTS_DIR, 'credentials.json')
TOKEN_FILE = os.path.join(ARC_EVENTS_DIR, 'token_workflow.pickle')


def get_gmail_service():
    """Authenticate and return Gmail service using arc-events credentials"""
    creds = None

    # Load existing credentials
    if os.path.exists(TOKEN_FILE):
        with open(TOKEN_FILE, 'rb') as token:
            creds = pickle.load(token)

    # Refresh or get new credentials
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                CREDENTIALS_FILE, GMAIL_SCOPES)
            creds = flow.run_local_server(port=0)

        # Save credentials
        with open(TOKEN_FILE, 'wb') as token:
            pickle.dump(creds, token)

    return build('gmail', 'v1', credentials=creds)


def main():
    """Send Windows setup package email"""

    # Email details
    to_email = 'irkedangel@gmail.com'
    from_email = 'info@arceventproductions.com'
    subject = 'Windows 11 - Ghostty & Claude Code Setup Package'
    attachment_path = '/Users/michaelgodinez/Projects/windows-claude-ghostty-setup.zip'

    # Email body
    body_text = """Hi,

I've created a complete setup package to duplicate my Ghostty terminal and Claude Code configuration on your Windows 11 machine.

**Package includes:**
- Ghostty terminal config (Catppuccin Mocha theme, JetBrains Mono font)
- Claude Code settings with pre-approved permissions
- 6 custom Claude agents for specialized tasks:
  - session-documenter (end-of-session documentation)
  - gmail-assistant (email management)
  - av-integration-engineer (AV systems & API integration)
  - ghostty-config-specialist (terminal customization)
  - gworkspace-python-dev (Google Workspace APIs)
  - arcninja (project automation)
- Automated PowerShell setup script
- Complete documentation and quick start guide

**To get started:**
1. Extract the zip file
2. Open PowerShell as Administrator
3. Navigate to the extracted folder
4. Run: .\\setup.ps1
5. Follow the instructions in README.md

The setup script will automatically copy all configuration files to the correct locations. You'll then need to install:
- Ghostty Terminal (from GitHub releases)
- JetBrains Mono font
- Node.js
- Claude Code CLI

Everything is documented in detail in the README.md file inside the package.

Let me know if you have any questions or run into any issues during setup!

Best regards,
Michael"""

    # Validate recipient using email_safety module
    print(f"Validating recipient: {to_email}")
    print("Using email_safety whitelist from arc-events project...")
    try:
        email_safety.validate_recipient(to_email)
        print("✓ Recipient validation passed!\n")
    except email_safety.EmailSecurityException as e:
        print(f"✗ Recipient validation failed: {e}")
        sys.exit(1)

    # Check if attachment exists
    if not os.path.exists(attachment_path):
        print(f"Error: Attachment file not found: {attachment_path}")
        sys.exit(1)

    # Authenticate
    print("Authenticating with Gmail API...")
    try:
        service = get_gmail_service()
        print("✓ Authentication successful!\n")
    except Exception as e:
        print(f"✗ Authentication failed: {e}")
        sys.exit(1)

    # Create message with attachment
    print("Creating email message...")
    message = MIMEMultipart()
    message['to'] = to_email
    message['from'] = from_email
    message['subject'] = subject
    message.attach(MIMEText(body_text, 'plain'))

    # Attach zip file
    print(f"Attaching file: {attachment_path}")
    try:
        with open(attachment_path, 'rb') as attachment:
            part = MIMEBase('application', 'zip')
            part.set_payload(attachment.read())
            encoders.encode_base64(part)
            part.add_header('Content-Disposition', 'attachment; filename=windows-claude-ghostty-setup.zip')
            message.attach(part)

        file_size = os.path.getsize(attachment_path)
        file_size_mb = file_size / (1024 * 1024)
        print(f"✓ Attachment added! (Size: {file_size:,} bytes / {file_size_mb:.2f} MB)\n")
    except Exception as e:
        print(f"✗ Error attaching file: {e}")
        sys.exit(1)

    # Send email
    print("Sending email...")
    try:
        raw_message = base64.urlsafe_b64encode(message.as_bytes()).decode('utf-8')
        result = service.users().messages().send(
            userId='me',
            body={'raw': raw_message}
        ).execute()

        print("\n" + "="*70)
        print("✓ EMAIL SENT SUCCESSFULLY!")
        print("="*70)
        print(f"Message ID:  {result['id']}")
        print(f"To:          {to_email}")
        print(f"From:        {from_email}")
        print(f"Subject:     {subject}")
        print(f"Attachment:  windows-claude-ghostty-setup.zip ({file_size_mb:.2f} MB)")
        print("="*70)
        print("\nCheck your Sent folder to verify the email was delivered.")

    except Exception as e:
        print(f"\n✗ Failed to send email: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == '__main__':
    main()
