#' Convert Higher Expectations' data layout to HERA's dashboard layout
#'
#' @param .x _tibble_ - a data frame produced by `read_math_pathways`.
#'
#' @return a data frame in the HERA dashboard format.
#'
#' * `Measure` _character_ - The indicator that is quantified by `Outcome`.
#' * `Enrollment at entry` _character_ - Whether the students are full- or part-time.
#' * `Demographic Group` _character_ - A type of demographic group, like race or age.
#' * `Detail` _character_ - A specific demographic group, like `Latine` or `18-24`.
#' * `Cohort` _integer_ - If present, the denominator to use to convert `Outcome` to a percentage.
#' * `Outcome` _numeric_ - A quantitative `Measure` of some aspect of the school's performance.
#'
#' @export
dashboardify_math_pathways <- function(.x) {
    .x |>
        dplyr::select(
            !tidyselect::any_of("Offered")
        ) |>
        dplyr::mutate(
            Measure = dplyr::case_when(
                stringr::str_detect(
                    .data$Pathway,
                    pattern = utils::tail(MATH_PATHWAY_NAMES, 1)
                ) ~
                    "Completed more than one gateway math course within first year",
                stringr::str_detect(
                    .data$Pathway,
                    pattern = utils::head(MATH_PATHWAY_NAMES, 1)
                ) ~
                    "Exempt from gateway Math course",
                TRUE ~ glue::glue(
                    "Completed gateway {.data$Pathway} within first year"
                )
            ),
            Outcome = .data$Count,
            .keep = "unused"
        ) |>
        relocate_for_dashboard()
}
