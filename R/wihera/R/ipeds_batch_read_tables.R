ipeds_batch_read_tables <- function(schema,
                                    survey_code,
                                    table_code,
                                    start_year,
                                    finish_year = NULL,
                                    data_path = "."){

    if (is.null(finish_year)) {
        finish_year <- lubridate::year(lubridate::today()) - 2L
    }

    start_year |>
        seq(
            finish_year
        ) |>
        rlang::set_names() |>
        purrr::map(
            ipeds_zipped_csv,
            .survey_code = survey_code,
            .table_code = table_code,
            .path = data_path
        ) |>
        purrr::map(
            ipeds_read_with_schema,
            .schema = schema
        ) |>
        purrr::list_rbind(
            names_to = "Year"
        ) |>
        dplyr::mutate(
            Year = strtoi(.data$Year)
        )
}
