#' Import data on student progress toward first-year goals.
#'
#' @param .file_name the full path to the spreadsheet with data
#'
#' @returns A tibble with seven fields:
#'
#' * `Enrollment at entry` _character_ - Either Full- or Part-time.
#' * `Demographic Group` _character_ - What type of demographic group this row describes.
#' * `Detail` _character_ - The specific demographic group that this row describes.
#' * `Milestone` _character_ - A specific first-year goal, such as completing a minimum number of credits.
#' * `Status` _character_ - Whether the student reached the milestone by completing it or through exemption.
#' * `Cohort` _integer_ - The number of students in this group in their first fall.
#' * `Count` _integer_ - The number of students in the group who achieved the milestone.
#'
#' @export
read_momentum <- function(.file_name) {

    .file_name |>
        surly_read_xlsx(
            sheet = "Momentum in First Year",
            range = "A6:J41",
            col_names = c(
                "Population",
                "Cohort",
                MOMENTUM_MILESTONES$Order
            ),
            col_types = c("text", rep("numeric", 9)),
            na = NA_VALUES
        ) |>
        wrangle_population_and_enrollment_status() |>
        tidyr::pivot_longer(
            cols = as.character(MOMENTUM_MILESTONES$Order),
            names_to = "Order",
            names_transform = as.integer,
            values_to = "Count"
        ) |>
        dplyr::left_join(
            dplyr::select(MOMENTUM_MILESTONES, "Order":"Status"),
            by = "Order"
        ) |>
        dplyr::select(
            !tidyselect::any_of("Order")
        ) |>
        dplyr::relocate(
            "Milestone",
            "Status",
            "Cohort",
            .before = "Count"
        )
}
