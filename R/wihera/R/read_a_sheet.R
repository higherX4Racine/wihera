#' Apply an importing function to one sheet from each of several spreadsheets
#'
#' @param .files A vector of file names
#' @param .path A common path (if any) where the files are located
#' @param .schools A vector of school labels, one per file
#' @param .function A sheet-reading function like `read_cc_or_tech_graduation`
#'
#' @return a tibble with outputs from
#'
#' @importFrom rlang .data
#'
#' @export
read_a_sheet <- function(.files, .path, .schools, .function) {
    expand_and_name_files(.files, .path, .schools) |>
        purrr::map(.function) |>
        purrr::list_rbind(names_to = "School") |>
        dplyr::filter(!is.na(.data$Count))
}
