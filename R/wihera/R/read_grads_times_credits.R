#' Import data on graduation times and credits earned across populations.
#'
#' @param .file_name the full path to the spreadsheet with data
#'
#' @returns A tibble with seven fields:
#'
#' * `Degree/Certificate` _character_ - e.g., Certificate, Associate's, or Bachelor's.
#' * `Enrollment at entry` _character_ - Either Full- or Part-time.
#' * `Demographic Group` _character_ - What type of demographic group this row describes.
#' * `Detail` _character_ - The specific demographic group that this row describes.
#' * `Count` _integer_ - The number of students who were in the group.
#' * `Average credits to degree` _numeric_ - The average number of credits earned by students in the group.
#' * `Average time to degree` _numeric_ - The average number of years that students in this group took to graduate.
#'
#' @importFrom rlang .data
#'
#' @export
read_grads_times_credits <- function(.file_name) {

    .file_name |>
        readxl::read_xlsx(
            sheet = "Graduates Time and Credits",
            range = "A6:E149",
            col_names = c("Degree/Certificate",
                          "Population",
                          "Cohort",
                          "Average credits to degree",
                          "Average time to degree"),
            col_types = c(rep("text", 2),
                          rep("numeric", 3)),
            na = c("", "NA", "N/A", "DS")
        ) |>
        dplyr::mutate(
            `Degree/Certificate` = .data$`Degree/Certificate` |>
                fill_down_when_blank() |>
                stringr::str_trim()
        ) |>
        wrangle_population_and_enrollment_status()
}
