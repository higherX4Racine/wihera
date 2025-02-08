#' Search a vector of file names for a pattern
#'
#' @param .pattern string - A regular expression to search for
#' @param .files string - A vector of file names
#'
#' @return a single match, `NA`, or an error
#' @export
#'
#' @examples
#' find_matching_files("f", c("foo", "bar", "baz", "~$foo"))
find_matching_files <- function(.pattern, .files){
    detection <- stringr::str_subset(.files,
                                     stringr::regex(
                                         paste0("^(?!~).*", .pattern),
                                         ignore_case = TRUE)
    )
    if (length(detection) == 0) {
        return(NA)
    } else if (length(detection) > 1) {
        cli::cli_abort(c(
            "'{ .pattern }' matched multiple files:",
            detection
        ))
    }
    return(detection)
}
