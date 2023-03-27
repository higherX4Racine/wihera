#' Read in the raw contents of a template spreadsheet
#'
#' @param path_to_file - string The full path to the template file
#'
#' @return a list of all-character tibbles named from sheet names
#' @export
read_template <- function(path_to_file){
    path_to_file |>
        readxl::excel_sheets() |>
        rlang::set_names() |>
        purrr::map(
            ~ readxl::read_xlsx(path = path_to_file,
                                sheet = .,
                                col_names = FALSE,
                                col_types = "text",
                                .name_repair = "minimal")
        )
}
