#' Wrangle imported IPEDS data about retention into dashboardable long format
#'
#' @param .retentions a source tibble with lots of different demographics
#' @param .schema a tibble that describes how the demographic groups nest.
#'
#' @return a tibble of tidy retention data
#' @export
ipeds_wrangle_retention <- function(.retentions, .schema){
    .retentions |>
        dplyr::select(
            !"Imputation"
        ) |>
        dplyr::right_join(
            .schema |>
                dplyr::filter(
                    !is.na(.data$Measure)
                ) |>
                dplyr::select(
                    "varnumber",
                    "Enrollment Status",
                    "Measure"
                ),
            by = "varnumber"
        ) |>
        dplyr::select(
            "UNITID",
            "Year",
            "Enrollment Status",
            "Measure",
            "Value"
        ) |>
        dplyr::filter(
            .data$Measure != "Student-to-faculty ratio"
        ) |>
        tidyr::pivot_wider(
            names_from = "Measure",
            values_from = "Value"
        ) |>
        dplyr::mutate(
            "Retention Rate" = .data$Returning / .data$`Previous Fall`
        )
}
