ipeds_read_schema <- function(.file, .sheet){
    .schema <- .file |>
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
