#' Read in every sheet from a spreadsheet
#'
#' @param .file_path the full path to the excel workbook
#'
#' @returns a list of data frames, one for each sheet in the workbook
#' @export
read_glossary <- function(.file_path) {
    .file_path |>
        readxl::excel_sheets() |>
        rlang::set_names() |>
        purrr::map(
            \(.sheet) readxl::read_excel(.file_path,
                                         sheet = .sheet)
        ) |>
        purrr::imap(
            \(.frame, .name){
                if ("Key" %in% names(.frame))
                    return(dplyr::rename(.frame, "pk {.name}" := "Key"))
                return(.frame)
            }
        )
}
