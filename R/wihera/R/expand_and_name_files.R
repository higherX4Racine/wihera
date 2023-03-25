#' Zip together file names and factor labels, optionally rooted at a common path
#'
#' @param .files a vector of file names
#' @param .path optional, a path to prepend to the file names
#' @param .labels optional, names for each file
#'
#' @returns A named character vector of full paths
#'
#' @export
expand_and_name_files <- function(.files, .path = NULL, .labels = NULL) {

    if (is.null(.labels)) {
        if (length(names(.files)) == 0) {
            .labels <- basename(.files)
        } else {
            .labels <- names(.files)
        }
    }

    if (!is.null(.path)) {
        .files <- file.path(.path, .files)
    }

    rlang::set_names(.files, .labels)
}
