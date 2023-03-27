#' The Population field includes sparse representation of Enrollment Status
#'
#' @param .x a data frame with a multi-valued HERA Population column
#'
#' @returns
#' A data with `Population` removed, and two extra columns:
#'
#' * `Enrollment at entry` _character_ -  whether the students were full- or part-time.
#' * `Demographic Group` _character_ - Which kind of population the next variable denotes
#' * `Detail` _character_ - a specific kind of population, like a race or economic group
#'
#' @importFrom rlang .data
#'
#' @export
wrangle_population_and_enrollment_status <- function(.x){
    .x |>
        dplyr::mutate(
            `Enrollment at entry` =
                .data$Population |>
                detect_enrollment_status_in_population() |>
                dplyr::if_else(.data$Population, NA) |>
                fill_down_when_blank()
        ) |>
        dplyr::relocate(
            "Enrollment at entry",
            .before = "Population"
        ) |>
        dplyr::filter(
            !detect_enrollment_status_in_population(.data$Population)
        ) |>
        tidyr::separate(
            col = "Population",
            into = c("Demographic Group", "Detail"),
            sep = ": ",
            fill = "right"
        )
}
