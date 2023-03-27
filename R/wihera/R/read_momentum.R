#' Import data on student progress toward first-year goals.
#'
#' @param .file_name the full path to the spreadsheet with data
#'
#' @returns A tibble with seven fields:
#'
#' * `Enrollment Status` _character_ - Either Full- or Part-time.
#' * `Demographic Group` _character_ - What type of demographic group this row describes.
#' * `Detail` _character_ - The specific demographic group that this row describes.
#' * `Milestone` _character_ - A specific first-year goal, such as completing a minimum number of credits.
#' * `Method` _character_ - Whether the student reached the milestone by completing it or through exemption.
#' * `Cohort` _integer_ - The number of students in this group in their first fall.
#' * `Count` _integer_ - The number of students in the group who achieved the milestone.
#'
#' @export
read_momentum <- function(.file_name) {

    .file_name |>
        readxl::read_xlsx(
            sheet = "Momentum in First Year",
            range = "A6:J41",
            col_names = c("Population",
                          "Cohort",
                          "First Term Credits",
                          "First Year Credits",
                          "Gateway Math,Completed",
                          "Gateway Math,Exempt",
                          "Gateway English,Completed",
                          "Gateway English,Exempt",
                          "Met All Milestones",
                          "Declared Major" ),
            col_types = c("text", rep("numeric", 9)),
            na = c("", "NA", "N/A", "DS")
        ) |>
        wrangle_population_and_enrollment_status() |>
        tidyr::pivot_longer(
            cols = "First Term Credits":tidyselect::last_col(),
            names_to = "Milestone",
            values_to = "Count"
        ) |>
        tidyr::separate(
            col = "Milestone",
            into = c("Milestone", "Method"),
            sep = ",",
            remove = TRUE,
            extra = "merge",
            fill = "right"
        ) |>
        tidyr::replace_na(
            replace = list(Method = "Completed")
        ) |>
        dplyr::relocate(
            "Cohort",
            .before = "Count"
        )
}
