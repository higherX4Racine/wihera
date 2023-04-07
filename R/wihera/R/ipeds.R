IPEDS_DATA_URL <- "https://nces.ed.gov/ipeds/datacenter/data/"

ipeds_data_zip <- function(.year, .survey_code, .table_code){
    glue::glue(
        "{stringr::str_to_upper(.survey_code)}",
        "{.year}",
        "{stringr::str_to_upper(.table_code)}",
        ".zip"
    )
}

ipeds_data_csv <- function(.year, .survey_code, .table_code){
    glue::glue(
        "{stringr::str_to_lower(.survey_code)}",
        "{.year}",
        "{stringr::str_to_lower(.table_code)}",
        ".csv"
    )
}

ipeds_zipped_csv <- function(.year, .survey_code, .table_code, .path){
    file.path(
        .path,
        ipeds_data_zip(.year, .survey_code, .table_code)
    ) |>
        archive::archive_read(
            file = ipeds_data_csv(.year, .survey_code, .table_code)
        )
}

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
