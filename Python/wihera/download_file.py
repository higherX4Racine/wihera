"""Given a Resource, File ID, and local path, download content from Google Drive.

Cribbed from:
https://github.com/googleworkspace/python-samples/tree/main/drive/snippets/drive-v3/file_snippet

"""

from __future__ import print_function

import io

import googleapiclient.discovery
from googleapiclient.errors import HttpError
from googleapiclient.http import MediaIoBaseDownload


def download_file(service: googleapiclient.discovery.Resource,
                  file_id: str,
                  destination: str):
    """Downloads one identified file using the Google Drive API

    Parameters
    ----------
    service: googleapiclient.discovery.Resource
        An instance for interacting with a Google API.
    file_id: str
        The ID of the file to download.
    destination: str
        The full path to where the file should be saved.

    Returns
    -------
    bool: Whether or not the download succeeded.

    """
    success = False
    try:
        # pylint: disable=maybe-no-member
        request = service.files().get_media(fileId=file_id)
        buffer = io.BytesIO()
        downloader = MediaIoBaseDownload(buffer, request)
        while success is False:
            status, success = downloader.next_chunk()
    except HttpError as error:
        print(F'An error occurred during downloading: {error}')
        buffer = None

    if success:
        success = False
        try:
            with open(destination, 'wb') as ofh:
                ofh.write(buffer.getvalue())
            buffer.close()
            success = True
        except OSError as error:
            print(F'Error writing {destination}: {error.errno} -- {error.strerror}')

    return success