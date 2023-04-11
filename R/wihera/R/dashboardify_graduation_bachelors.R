#' Convert Higher Expectations' data layout to HERA's dashboard layout
#'
#' @param .x _tibble_ - a data frame produced by [read_graduation_bachelors()].
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
dashboardify_graduation_bachelors <- function(.x) {
    .x |>
        dplyr::mutate(
            `Degree/Certificate` = "Bachelor's Degrees",
            Measure = verbose_completion_time(.data$`Completion Time`),
            Outcome = .data$Count,
            .keep = "unused"
        ) |>
        relocate_for_dashboard()
}
