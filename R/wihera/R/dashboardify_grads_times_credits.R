#' Convert Higher Expectations' data layout to HERA's dashboard layout
#'
#' @param .x _tibble_ - a data frame produced by `read_grads_times_credits`.
#'
#' @return a data frame in the HERA dashboard format.
#'
#' @export
dashboardify_grads_times_credits <- function(.x) {
    .x |>
        dplyr::select(
            "Degree/Certificate",
            "Enrollment at entry",
            "Demographic Group",
            "Detail",
            "Average time to degree",
            "Average credits to degree"
        ) |>
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
