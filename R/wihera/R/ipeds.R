#' The file names for IPEDS data from specific years on specific topics
#'
#' @name ipeds_data_file
#' @param .year integer - A four-digit integer value for a year.
#' @param .survey_code character - One of the IPEDS prefixes that designate common topics.
#' @param .table_code character - One of the IPEDS suffixes that specify tables within topics.
#'
#' @description
#' These functions all glue together the inputs and a file extension. They all
#' change the case of the text inputs to match the arbitrary but consistent
#' formatting style of the type of file.
#'
#' @section `ipeds_data_zip()`:
#'
#' Compressed files from the website or saved somewhere by you.
#'
#' @section `ipeds_data_csv`:
#'
#' The contents of a compressed file.
#'
#' @return The file name as a single string.
#' @export
#'
#' @examples
#' ipeds_data_zip(2002L, "ef", "d")
#' ipeds_data_csv(2002L, "ef", "d")
#' ipeds_data_zip(2012, "c", "c_")
#' ipeds_data_csv(2012, "c", "c_")
ipeds_data_zip <- function(.year, .survey_code, .table_code){
    glue::glue(
        "{stringr::str_to_upper(.survey_code)}",
        "{.year}",
        "{stringr::str_to_upper(.table_code)}",
        ".zip"
    )
}

#' @rdname ipeds_data_file
#' @export
ipeds_data_csv <- function(.year, .survey_code, .table_code){
    glue::glue(
        "{stringr::str_to_lower(.survey_code)}",
        "{.year}",
        "{stringr::str_to_lower(.table_code)}",
        ".csv"
    )
}

#' Open an IPEDS csv table from within a zipped file.
#'
#' @inheritParams ipeds_data_file
#' @param .path character - The full path to the folder where the .zip file is located.
#'
#' @return An open connection that can access the zipped data as if they weren't.
#' @seealso
#' [ipeds_data_zip()], [ipeds_data_csv()] Make file names with IPEDS style.
#'
#' [archive::archive_read()] The function that actually opens the archive.
#'
#' @export
ipeds_zipped_csv <- function(.year, .survey_code, .table_code, .path){
    file.path(
        .path,
        ipeds_data_zip(.year, .survey_code, .table_code)
    ) |>
        archive::archive_read(
            file = ipeds_data_csv(.year, .survey_code, .table_code)
        )
}

#' The root path where annual data files can be retrieved from IPEDS
#' @format a URL as a string
#'
#' @source [IPEDS](https://nces.ed.gov/ipeds/datacenter/data/)
IPEDS_DATA_URL <- "https://nces.ed.gov/ipeds/datacenter/data/"


#' Fetch a zipped archive of data from IPEDs.
#'
#' @inheritParams ipeds_data_file
#' @param .path character - The full path to where you want the .zip archive to be saved.
#'
#' @return The path to the downloaded file (invisibly).
#' @seealso
#' [ipeds_data_zip()] correctly creates the file name you need
#'
#' [curl::curl_download()] fetches the file and saves it where you asked.
#'
#' @export
ipeds_download_data <- function(.year, .survey_code, .table_code, .path){
    .zip <- ipeds_data_zip(.year, .survey_code, .table_code)
    curl::curl_download(file.path(IPEDS_DATA_URL, .zip),
                        file.path(.path, .zip))
}
