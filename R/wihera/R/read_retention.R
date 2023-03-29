#' Import data on student retention from their first fall to their second.
#'
#' @param .file_name the full path to the spreadsheet with data
#'
#' @returns A tibble with five fields:
#'
#' * `Enrollment Status` _character_ - Either Full- or Part-time.
#' * `Demographic Group` _character_ - What type of demographic group this row describes.
#' * `Detail` _character_ - The specific demographic group that this row describes.
#' * `Cohort` _integer_ - The number of students in this group in their first fall.
#' * `Count` _integer_ - The number of students in the group who returned the following fall.
#'
#' @export
read_retention <- function(.file_name) {

    .file_name |>
        surly_read_xlsx(
            sheet = "Retention",
            range = "A6:C41",
            col_names = c(
                "Population",
                "Cohort",
                "Count"
            ),
            col_types = c("text", "numeric", "numeric"),
            na = NA_VALUES
        ) |>
        wrangle_population_and_enrollment_status()
}
