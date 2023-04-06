ipeds_read_csv <- function(.file,
                           .na_values = c("", "NA", "N/A", "#N/A", ".")) {
    .ipeds <- .file |>
        readr::read_csv(
            col_types = readr::cols(.default = readr::col_character()),
            na = .na_values
        )

    .ipeds <- readr::type_convert(.ipeds,
                                  .ipeds_column_types(.ipeds))

    value_columns <- .ipeds |>
        dplyr::select(-1) |>
        dplyr::select(tidyselect::where(is.numeric)) |>
        names()

    notes_columns <- .ipeds |>
        dplyr::select(-1) |>
        dplyr::select(!tidyselect::where(is.numeric)) |>
        names()

    .ipeds_numbers <- .ipeds |>
        dplyr::select(
            tidyselect::all_of(c("UNITID", value_columns))
        ) |>
        tidyr::pivot_longer(
            cols = !"UNITID",
            names_to = "Variable",
            values_to = "Value"
        )

    .ipeds_imputes <- .ipeds |>
        dplyr::select(
            tidyselect::all_of(c("UNITID",
                                 rlang::set_names(notes_columns,
                                                  value_columns)))
        ) |>
        tidyr::pivot_longer(
            cols = !"UNITID",
            names_to = "Variable",
            values_to = "Imputation"
        )

    dplyr::left_join(.ipeds_numbers,
                     .ipeds_imputes,
                     by = c("UNITID", "Variable"))
}


.ipeds_column_types <- function(.x){
    .x |>
        names() |>
        stringr::str_detect("^X") |>
        dplyr::if_else("c", "i") |>
        paste0(collapse = "")
}
