#' Wrangle imported IPEDS data about graduation into dashboardable long format
#'
#' @param .demographic which demographic to wrangle
#' @param .completions the source tibble with lots of different demographics
#' @param .schema a tibble that describes how the demographic groups nest.
#'
#' @return a tibble of tidy graduation data
#' @export
ipeds_wrangle_completions <- function(.demographic, .completions, .schema){
    .completions |>
        dplyr::right_join(
            .demographic_schema(.schema,
                                .demographic),
            by = c("varnumber")
        ) |>
        dplyr::mutate(
            Credential = .award_levels_as_factor(.data$AWLEVELC)
        ) |>
        dplyr::select(
            "UNITID",
            "Year",
            .demographic,
            "Credential",
            Graduates = "Value",
            "Imputation"
        )
}

.award_levels_as_factor <- function(.award_codes) {
    f <- .award_codes > 10L
    .award_codes[f] <- .award_codes[f] - 10L
    factor(.award_codes,
           levels = c(1L, 2L, 3L, 5L, 7L, 9L, 10L),
           labels = c("Postsecondary certificate, < 1 year",
                      "Postsecondary certificate, > 1 year",
                      "Associate's degree",
                      "Bachelor's degree",
                      "Master's degree",
                      "Doctor's degree",
                      "Postbaccalaureate certificate")
    )
}

.demographic_schema <- function(.schema, .factor){
    .schema |>
        dplyr::select(
            "varnumber",
            .factor
        ) |>
        dplyr::filter(
            !dplyr::if_any(.factor, is.na)
        ) |>
        dplyr::mutate(
            dplyr::across(.factor,
                          forcats::fct_inorder)
        )
}
