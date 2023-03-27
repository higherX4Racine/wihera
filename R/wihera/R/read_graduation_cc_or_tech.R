#' Import data on graduation from programs designed to take less than 4 years.
#'
#' @param .file_name the full path to the spreadsheet with data
#'
#' @returns A tibble with seven fields:
#'
#' * `Enrollment at entry` _character_ - Either Full- or Part-time.
#' * `Demographic Group` _character_ - What type of demographic group this row describes.
#' * `Detail` _character_ - The specific demographic group that this row describes.
#' * `Completion Time` _character_ - Either 100% or 150%, which is relative to `Program Length`.
#' * `Program Length` _character_ - Either "0y-2y" or "2y-4y".
#' * `Cohort` _integer_ - The number of students in this group in their first fall.
#' * `Count` _integer_ - The number of students in the group who earned a credential.
#'
#' @export
read_graduation_cc_or_tech <- function(.file_name) {

    .file_name |>
        readxl::read_xlsx(
            sheet = "Graduation - Programs < 4 years",
            range = "B8:G43",
            col_names = c(
                "Population",
                "Cohort",
                t(outer(
                    glue::glue("{c(10,15)}0%"),
                    glue::glue("{c('0y-2y', '2y-4y')}"),
                    paste, sep = "\n"))
            ),
            col_types = c("text",
                          rep("numeric", 5)),
            na = c("", "NA", "N/A", "DS")
        ) |>
        wrangle_population_and_enrollment_status() |>
        tidyr::pivot_longer(
            cols = !(1:4),
            names_to = c("Completion Time",
                         "Program Length"),
            names_sep = "\n",
            values_to = "Count"
        ) |>
        dplyr::relocate(
            "Cohort",
            .before = "Count"
        )
}
