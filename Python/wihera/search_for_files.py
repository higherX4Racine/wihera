r"""Search using Google's Drive API file query sub-language

cribbed from:
https://github.com/googleworkspace/python-samples/blob/main/drive/snippets/drive-v3/file_snippet/search_file.py

"""

from __future__ import print_function

from googleapiclient.errors import HttpError

def search_for_files(service, search_tokens, file_fields):
    r"""Using a Google Drive API object, search for files

    Detailed instructions on how to write queries can be found here:
    https://developers.google.com/drive/api/v3/reference/files

    Parameters
    ----------
    service: googleapiclient.discovery.Resource
        An instance for interacting with a Google API.
    search_tokens: Iterable[str]
        One or more search conditions that will be joined with commas in the API call.
        https://developers.google.com/drive/api/guides/ref-search-terms
    file_fields: Iterable[str]
        One or more choices from among the many possible metadata fields for each file.
        see https://developers.google.com/drive/api/guides/fields-parameter

    Returns
    -------
    List[googleapiclient.drive.File]: zero or more File objects that matched the search criteria

    """
    try:
        files = []
        page_token = None

        while True:
            # pylint: disable=maybe-no-member
            response = service.files().list(
                q=','.join(search_tokens),
                spaces='drive',
                fields=f'nextPageToken,files({",".join(file_fields)})',
                pageToken=page_token
            ).execute()

            files.extend(response.get('files', []))
            page_token = response.get('nextPageToken', None)

            if page_token is None:
                break

    except HttpError as error:
        print(F'An error occurred: {error}')
        files = None

    return files