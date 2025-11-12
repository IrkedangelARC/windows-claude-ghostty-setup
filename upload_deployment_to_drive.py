#!/usr/bin/env python3
"""
Upload Windows Claude Code Deployment Package to Google Drive

Creates a folder structure:
  My Drive/
    deployments/
      windows-claude-setup/
        (all files)

Uses info@arceventproductions.com Google Drive account
"""

import os
import sys
from pathlib import Path
import zipfile
import pickle
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload
from googleapiclient.errors import HttpError

# Arc-events path for token
arc_events_path = '/Users/michaelgodinez/Projects/arc-projects/arc-events'


def create_folder(drive_service, folder_name, parent_id=None):
    """Create a folder in Google Drive."""
    file_metadata = {
        'name': folder_name,
        'mimeType': 'application/vnd.google-apps.folder'
    }

    if parent_id:
        file_metadata['parents'] = [parent_id]

    try:
        folder = drive_service.files().create(
            body=file_metadata,
            fields='id, name, webViewLink'
        ).execute()

        print(f"✓ Created folder: {folder.get('name')}")
        return folder.get('id'), folder.get('webViewLink')
    except HttpError as e:
        print(f"✗ Error creating folder: {e}")
        raise


def find_folder(drive_service, folder_name, parent_id=None):
    """Find an existing folder in Google Drive."""
    try:
        query = f"name='{folder_name}' and mimeType='application/vnd.google-apps.folder' and trashed=false"

        if parent_id:
            query += f" and '{parent_id}' in parents"

        results = drive_service.files().list(
            q=query,
            spaces='drive',
            fields='files(id, name, webViewLink)'
        ).execute()

        folders = results.get('files', [])

        if folders:
            folder = folders[0]
            print(f"✓ Found existing folder: {folder.get('name')}")
            return folder.get('id'), folder.get('webViewLink')

        return None, None
    except HttpError as e:
        print(f"✗ Error finding folder: {e}")
        raise


def find_or_create_folder(drive_service, folder_name, parent_id=None):
    """Find existing folder or create new one."""
    folder_id, folder_url = find_folder(drive_service, folder_name, parent_id)

    if folder_id:
        return folder_id, folder_url

    return create_folder(drive_service, folder_name, parent_id)


def upload_file(drive_service, file_path, folder_id, mime_type=None):
    """Upload a file to Google Drive."""
    file_path = Path(file_path)

    if not file_path.exists():
        raise FileNotFoundError(f"File not found: {file_path}")

    file_metadata = {
        'name': file_path.name,
        'parents': [folder_id]
    }

    # Determine MIME type
    if mime_type is None:
        ext = file_path.suffix.lower()
        mime_types = {
            '.md': 'text/markdown',
            '.json': 'application/json',
            '.ps1': 'text/plain',
            '.txt': 'text/plain',
            '.sh': 'text/plain',
            '.py': 'text/x-python',
            '.zip': 'application/zip'
        }
        mime_type = mime_types.get(ext, 'application/octet-stream')

    try:
        media = MediaFileUpload(str(file_path), mimetype=mime_type, resumable=True)

        file = drive_service.files().create(
            body=file_metadata,
            media_body=media,
            fields='id, name, webViewLink, size'
        ).execute()

        size_kb = int(file.get('size', 0)) / 1024
        print(f"  ✓ {file.get('name')} ({size_kb:.1f} KB)")

        return file
    except HttpError as e:
        print(f"  ✗ Error uploading {file_path.name}: {e}")
        raise


def create_zip_archive(source_dir, output_path):
    """Create a ZIP archive of the deployment package."""
    print("📦 Creating ZIP archive...")

    source_dir = Path(source_dir)
    output_path = Path(output_path)

    with zipfile.ZipFile(output_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for file_path in source_dir.rglob('*'):
            if file_path.is_file():
                # Skip git files and Python cache
                if '.git' in file_path.parts or '__pycache__' in file_path.parts:
                    continue

                arc_name = file_path.relative_to(source_dir.parent)
                zipf.write(file_path, arc_name)

    size_mb = output_path.stat().st_size / (1024 * 1024)
    print(f"✓ Created ZIP: {output_path.name} ({size_mb:.2f} MB)")

    return output_path


def main():
    """Main execution function."""
    print("")
    print("=" * 80)
    print("📤 UPLOADING WINDOWS CLAUDE CODE DEPLOYMENT TO GOOGLE DRIVE")
    print("=" * 80)
    print("")

    # Get project directory
    project_dir = Path(__file__).parent.absolute()
    project_name = project_dir.name

    print(f"📁 Project: {project_name}")
    print(f"📁 Location: {project_dir}")
    print("")

    # Authenticate
    print("🔐 Authenticating with Google Drive...")
    print("-" * 80)

    original_dir = os.getcwd()

    try:
        # Try to load token from arc-events
        token_path = os.path.join(arc_events_path, 'token_workflow.pickle')

        if not os.path.exists(token_path):
            print("✗ No authentication token found")
            print(f"✗ Expected token at: {token_path}")
            print("")
            print("Please run this from arc-events to authenticate first:")
            print("  cd /Users/michaelgodinez/Projects/arc-projects/arc-events")
            print("  python3 upload_agents_to_drive.py")
            return 1

        with open(token_path, 'rb') as token:
            creds = pickle.load(token)

        if not creds or not creds.valid:
            if creds and creds.expired and creds.refresh_token:
                creds.refresh(Request())
                with open(token_path, 'wb') as token:
                    pickle.dump(creds, token)
            else:
                print("✗ Invalid credentials")
                return 1

        drive_service = build('drive', 'v3', credentials=creds)

        print("✓ Authentication successful")
        print("")

        # Create folder structure: deployments/windows-claude-setup
        print("📂 Creating folder structure...")
        print("-" * 80)

        # Find or create 'deployments' folder
        deployments_id, deployments_url = find_or_create_folder(
            drive_service, 'deployments'
        )

        # Find or create 'windows-claude-setup' folder inside deployments
        setup_id, setup_url = find_or_create_folder(
            drive_service, 'windows-claude-setup', deployments_id
        )

        print("")

        # Create ZIP archive
        print("📦 Preparing deployment package...")
        print("-" * 80)

        zip_path = project_dir.parent / f"{project_name}.zip"
        create_zip_archive(project_dir, zip_path)

        print("")

        # Upload ZIP file
        print("📤 Uploading to Google Drive...")
        print("-" * 80)

        upload_file(drive_service, zip_path, setup_id, 'application/zip')

        print("")

        # Upload individual important files
        print("📤 Uploading key files...")
        print("-" * 80)

        key_files = [
            project_dir / 'MEGA-INSTALLER.ps1',
            project_dir / 'README.md',
            project_dir / 'QUICK_START.md',
            project_dir / 'START_HERE.md',
        ]

        for file_path in key_files:
            if file_path.exists():
                upload_file(drive_service, file_path, setup_id)

        print("")

        # Summary
        print("=" * 80)
        print("✅ UPLOAD COMPLETE!")
        print("=" * 80)
        print("")
        print(f"📁 Google Drive Folder: {setup_url}")
        print("")
        print("📋 What was uploaded:")
        print(f"  • {project_name}.zip (complete package)")
        print("  • MEGA-INSTALLER.ps1 (one-command setup)")
        print("  • README.md")
        print("  • QUICK_START.md")
        print("  • START_HERE.md")
        print("")
        print("🔗 Share this link with anyone who needs the setup:")
        print(f"   {setup_url}")
        print("")
        print("📝 To download on Windows:")
        print("   1. Open the link above")
        print("   2. Download MEGA-INSTALLER.ps1")
        print("   3. Right-click → Run with PowerShell (as Administrator)")
        print("   4. Follow the prompts")
        print("")

        # Clean up ZIP
        if zip_path.exists():
            zip_path.unlink()
            print("🧹 Cleaned up temporary ZIP file")
            print("")

        return 0

    except Exception as e:
        print(f"✗ Error: {e}")
        import traceback
        traceback.print_exc()
        return 1
    finally:
        os.chdir(original_dir)


if __name__ == '__main__':
    sys.exit(main())
