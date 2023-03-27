#' Import data on graduation from programs that grant Bachelor's degrees.
#'
#' @param .file_name the full path to the spreadsheet with data
#'
#' @returns A tibble with six fields:
#'
#' * `Enrollment Status` _character_ - Either Full- or Part-time.
#' * `Factor` _character_ - What type of demographic group this row describes.
#' * `Level` _character_ - The specific demographic group that this row describes.
#' * `Completion Time` _character_ - Either 100% (4-year rate) or 150% (6-year rate).
#' * `First-time cohort` _integer_ - The number of students in this group in their first fall.
#' * `Count` _integer_ - The number of students in the group who graduated with a bachelor's degree.
#'
#' @export
read_graduation_bachelors <- function(.file_name) {

    .file_name |>
        readxl::read_xlsx(
            sheet = "Graduation - Bachelors degrees",
            range = "B6:E41",
            col_names = c("Population",
                          "First-time cohort",
                          glue::glue(
                              "{c(10,15)}0%"
                          )),
            col_types = c("text", rep("numeric", 3)),
            na = c("", "NA", "N/A", "DS"),
            .name_repair = "minimal"
        ) |>
        wrangle_population_and_enrollment_status() |>
        tidyr::pivot_longer(
            cols = !tidyselect::any_of(c("Enrollment Status",
                                         "Factor",
                                         "Level",
                                         "First-time cohort")),
            names_to = c("Completion Time"),
            values_to = "Count"
        ) |>
        dplyr::relocate(
            "First-time cohort",
            .before = "Count"
        )
}
