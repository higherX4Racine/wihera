#' Set the order of a tibble to match what the HERA template expects.
#'
#' @param .x a tibble of data from one of the `wihera::read_*` functions.
#'
#' @return A tibble with at least 8 fields:
#'
#' * `Source Tab` _character_ - The name of the sheet that the data came from.
#' * `Degree/Certificate` _character_ - The pertinent credential track for the `Measure`.
#' * `Measure` _character_ - The indicator that is quantified by `Outcome`.
#' * `Enrollment at entry` _character_ - Whether the students are full- or part-time.
#' * `Demographic Group` _character_ - A type of demographic group, like race or age.
#' * `Detail` _character_ - A specific demographic group, like `Latine` or `18-24`.
#' * `Cohort` _integer_ - If present, the denominator to use to convert `Outcome` to a percentage.
#' * `Outcome` _numeric_ - A quantitative `Measure` of some aspect of the school's performance.
#'
#' @export
relocate_for_dashboard <- function(.x){
    dplyr::relocate(.x,
                    tidyselect::any_of(c(
                        "Source Tab",
                        "Degree/Certificate",
                        "Measure",
                        "Enrollment at entry",
                        "Demographic Group",
                        "Detail",
                        "Cohort",
                        "Outcome"
                    )))
}
