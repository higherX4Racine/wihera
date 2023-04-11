#' Convert Higher Expectations' data layout to HERA's dashboard layout
#'
#' @param .x _tibble_ - a data frame produced by [read_graduation_cc_or_tech()].
#'
#' @return a data frame in the HERA dashboard format.
#'
#' * `Degree/Certificate` _character_ - The pertinent credential track for the `Measure`.
#' * `Measure` _character_ - The indicator that is quantified by `Outcome`.
#' * `Enrollment at entry` _character_ - Whether the students are full- or part-time.
#' * `Demographic Group` _character_ - A type of demographic group, like race or age.
#' * `Detail` _character_ - A specific demographic group, like `Latine` or `18-24`.
#' * `Cohort` _integer_ - If present, the denominator to use to convert `Outcome` to a percentage.
#' * `Outcome` _numeric_ - A quantitative `Measure` of some aspect of the school's performance.
#'
#' @export
dashboardify_graduation_cc_or_tech <- function(.x) {
    .x |>
        dplyr::group_by(
            .data$`Enrollment at entry`,
            .data$`Demographic Group`,
            .data$Detail,
            .data$`Completion Time`
        ) |>
        dplyr::summarize(
            Cohort = max(.data$Cohort, na.rm = TRUE),
            Outcome = sum(.data$Count, na.rm = TRUE),
            .groups = "keep"
        ) |>
        dplyr::ungroup() |>
        dplyr::mutate(
            `Degree/Certificate` = "Degree/certificate program of less than 4 years (aggregate for Tableau)",
            Measure = verbose_completion_time(.data$`Completion Time`),
            .keep = "unused"
        ) |>
        relocate_for_dashboard()
}
