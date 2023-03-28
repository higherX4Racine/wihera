#' Convert Higher Expectations' data layout to HERA's dashboard layout
#'
#' @param .x _tibble_ - a data frame produced by `read_graduation_cc_or_tech`.
#'
#' @return a data frame in the HERA dashboard format. It does not include `Degree/Certificate`.
#'
#' * `Measure` _character_ - The indicator that is quantified by `Outcome`.
#' * `Enrollment at entry` _character_ - Whether the students are full- or part-time.
#' * `Demographic Group` _character_ - A type of demographic group, like race or age.
#' * `Detail` _character_ - A specific demographic group, like `Latine` or `18-24`.
#' * `Cohort` _integer_ - If present, the denominator to use to convert `Outcome` to a percentage.
#' * `Outcome` _numeric_ - A quantitative `Measure` of some aspect of the school's performance.
#'
#' @export
dashboardify_retention <- function(.x) {
    .x |>
        dplyr::rename(
            Outcome = .data$Count
        ) |>
        dplyr::mutate(
            Measure = "Enrolled following fall term"
        ) |>
        relocate_for_dashboard()
}
