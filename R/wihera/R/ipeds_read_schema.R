#' Read one schema that describes a layout of IPEDS data.
#'
#' @param .file character/connection - The spreadsheet with the schemas.
#' @param .sheet character - The specific sheet within the spreadsheet file.
#'
#' @return a tibble that describes how factor levels are coded
#' @export
ipeds_read_schema <- function(.file, .sheet){
    .file |>
        readxl::read_xlsx(
            sheet = .sheet,
            col_types = "text"
        ) |>
        readr::type_convert(
            col_types = readr::cols(
                varnumber = readr::col_integer(),
                Fieldwidth = readr::col_integer(),
                .default = readr::col_character()
            )
        ) |>
        dplyr::mutate(
            varspec = .datatype_to_cols(.data$DataType),
            imputationspec = .data$imputationvar |>
                is.na() |>
                dplyr::if_else(.data$DataType, "A") |>
                .datatype_to_cols()
        )
}

#' Use a schema to parse a data table from IPEDS
#'
#' @param .file character/connection - The spreadsheet with the schemas.
#' @param .schema tibble - a tibble that describes how factor levels are coded.
#' @param .nas character - a vector of values to treat as missing.
#'
#' @return a tibble with tidy settings created with reference to `schema`
#' @export
ipeds_read_with_schema <- function(.file, .schema, .nas = c("", "NA", ".")){

    .raw <- .file |>
        readr::read_csv(
            col_types = readr::cols(.default = readr::col_character())
        ) |>
        dplyr::rename_with(
            stringr::str_to_upper
        )

    .id_columns <- .label_columns(.schema)

    .data_part <- .raw |>
        readr::type_convert(
            col_types = .data_spec(.schema),
            na = .nas
        ) |>
        tidyr::pivot_longer(
            cols = !tidyselect::any_of(.id_columns),
            names_to = "varname",
            values_to = "Value"
        ) |>
        dplyr::left_join(
            dplyr::select(.schema,
                          "varnumber",
                          "varname"),
            by = "varname"
        )

    .imputation_part <- .raw |>
        readr::type_convert(
            col_types = .imputation_spec(.schema)
        ) |>
        tidyr::pivot_longer(
            cols = !tidyselect::any_of(.id_columns),
            names_to = "imputationvar",
            values_to = "Imputation"
        ) |>
        dplyr::left_join(
            dplyr::select(.coalesce_imputation(.schema),
                          "varnumber",
                          "imputationvar"),
            by = "imputationvar"
        )

    .data_part |>
        dplyr::left_join(
            .imputation_part,
            by = intersect(names(.data_part),
                           names(.imputation_part))
        ) |>
        dplyr::select(
            tidyselect::any_of(c(
                .id_columns,
                "varnumber",
                "Value",
                "Imputation"
            ))
        )
}

.datatype_to_cols <- function(.datatype) {
    dplyr::case_match(
        .datatype,
        "A" ~ list(readr::col_character()),
        "N" ~ list(readr::col_integer())
    )
}

.coalesce_imputation <- function(.schema) {
    .schema |>
        dplyr::mutate(
            imputationvar = dplyr::coalesce(.data$imputationvar,
                                            .data$varname)
        )
}

.data_spec <- function(.schema) {
    do.call(readr::cols_only,
            dplyr::pull(.schema,
                        var = "varspec",
                        name = "varname"))
}

.imputation_spec <- function(.schema) {
    do.call(readr::cols_only,
            dplyr::pull(.coalesce_imputation(.schema),
                        var = "imputationspec",
                        name = "imputationvar")
    )
}

.label_columns <- function(.schema){
    .schema |>
        dplyr::filter(is.na(.data$imputationvar)) |>
        dplyr::pull("varname")
}
