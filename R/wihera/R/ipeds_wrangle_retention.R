ipeds_wrangle_retention <- function(.retentions, .schema){
    .base <- .retentions |>
        dplyr::select(
            !"Imputation"
        ) |>
        dplyr::right_join(
            .just_variables(.schema),
            by = "varnumber"
        ) |>
        dplyr::select(
            "UNITID",
            "Year",
            "Enrollment Status",
            "Measure",
            "Value"
        )

    .some <- .base |>
        dplyr::filter(
            .data$Measure == "Student-to-faculty ratio"
        ) |>
        dplyr::select(
            "UNITID",
            "Year",
            "Student-to-faculty ratio" = "Value"
        )

    .rest <- .base |>
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

    dplyr::left_join(
        .rest,
        .some,
        by = c("UNITID", "Year")
    )

}

.just_variables <- function(.schema){
    .schema |>
        dplyr::filter(
            !is.na(.data$Measure)
            ) |>
        dplyr::select(
            "varnumber",
            "Enrollment Status",
            "Measure"
        )
}
