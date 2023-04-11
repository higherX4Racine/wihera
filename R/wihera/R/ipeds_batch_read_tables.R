#' Title
#'
#' @param schema The table that describes how the source data tables are laid out.
#' @param survey_code The IPEDs prefix that designates related tables.
#' @param table_code The IPEDS suffix that designates a specific table.
#' @param start_year The first year to look up.
#' @param finish_year The last year to look up.
#' @param data_path The path to where the data files are stored.
#'
#' @return A (probably huge) tibble with data from many schools. It will include
#' a column "Year" in addition to the columns dictated by `schema`.
#' @seealso
#' [ipeds_zipped_csv()] the function that opens compressed archives.
#'
#' [ipeds_read_with_schema()] the function that parses each file.
#' @export
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
