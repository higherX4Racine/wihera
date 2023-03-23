r"""Authorize an app with Google Drive's API.

cribbed from:
https://developers.google.com/drive/api/quickstart/python

"""
import os.path

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow

SCOPES = [
    'https://www.googleapis.com/auth/drive.metadata.readonly'
]

def authenticate_with_oauth2(credentials_file, token_file):
    r"""Update file-based credentials for authenticating with OAuth2

    Parameters
    ----------
    credentials_file: str
        The path to a JSON-formatted credentials file created with Google Cloud Console.
    token_file: str
        The path where credential tokens will be saved or updated.

    Returns
    -------
    google.oauth2.credentials.Credentials: The OAuth 2.0 credentials for the user.

    """
    creds = None

    if os.path.exists(token_file):
        creds = Credentials.from_authorized_user_file(token_file)

    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(credentials_file,
                                                             SCOPES)
            creds = flow.run_local_server(port=0)

        with open(token_file, 'w') as token:
            token.write(creds.to_json())

    return creds