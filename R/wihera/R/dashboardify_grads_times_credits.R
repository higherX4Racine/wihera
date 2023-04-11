#' Convert Higher Expectations' data layout to HERA's dashboard layout
#'
#' @param .x _tibble_ - a data frame produced by [read_grads_times_credits()].
#'
#' @return a data frame in the HERA dashboard format. It does not have the `Cohort` field.
#'
#' * `Degree/Certificate` _character_ - The pertinent credential track for the `Measure`.
#' * `Measure` _character_ - The indicator that is quantified by `Outcome`.
#' * `Enrollment at entry` _character_ - Whether the students are full- or part-time.
#' * `Demographic Group` _character_ - A type of demographic group, like race or age.
#' * `Detail` _character_ - A specific demographic group, like `Latine` or `18-24`.
#' * `Cohort` _integer_ - The number of students that belong to this group.
#' * `Outcome` _numeric_ - A quantitative `Measure` of some aspect of the school's performance.
#'
#' @export
dashboardify_grads_times_credits <- function(.x) {
    .x |>
        tidyr::pivot_longer(
            cols = tidyselect::all_of(c(
                "Average time to degree",
                "Average credits to degree"
            )),
            names_to = "Measure",
            values_to = "Outcome"
        ) |>
        relocate_for_dashboard()
}
