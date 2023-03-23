from __future__ import print_function

import os.path

from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

from wihera import (
    authenticate_with_oauth2,
    download_file,
    search_for_files,
)

SCOPES = [
    'https://www.googleapis.com/auth/drive.metadata.readonly'
]

TOKEN_FILE = os.path.expanduser("~/.oath_token_for_hera.json")
CREDENTIALS_FILE = os.path.expanduser("~/.oath_credentials_for_hera.json")


def main():
    """Shows the basic usage of the Drive v3 API.

    Prints the names and ids of the first 10 files the user has access to.

    """

    creds = authenticate_with_oauth2(CREDENTIALS_FILE,
                                     TOKEN_FILE)

    try:
        service = build('drive', 'v3', credentials=creds)

        file_list = search_for_files(service,
                                     ['"1lGEa76keASURLmHsck48xJokY_In4lwn" in parents'],
                                     ['id', 'name'])

        for file in file_list:
            file_name = file.get('name')
            file_id = file.get('id')
            print(F'Found file: {file_name}, {file_id}')
            download_file(service, file_id, file_name)

    except HttpError as error:
        print(f'An error occurred: {error}')


if __name__ == '__main__':
    main()
