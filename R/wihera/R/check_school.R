#' Summarize the match between a school spreadsheet and a template
#'
#' @param .school the spreadsheet that represents a school
#' @param .regions a list of regions of the spreadsheets that should be compared
#' @param .template the canonical layout that the school should have followed
#'
#' @returns
#' a list with two kinds of elements:
#'
#' * For each name in `.regions`, a count of the number of mismatches.
#' * **messages** a named character vector of mismatch details
#'
#' @export
check_school <- function(.school, .regions, .template){
    comparisons <- .regions |>
        purrr::map(check_template, .template, .school)
    result <- lapply(comparisons, length)
    result$messages <- list(comparisons)
    tibble::as_tibble_row(result)
}
