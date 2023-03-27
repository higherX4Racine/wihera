#' Import data on how first-year students fared on their mathematics coursework.
#'
#' @param .file_name the full path to the spreadsheet with data
#'
#' @returns A tibble with seven fields:
#'
#' * `Enrollment Status` _character_ - Either Full- or Part-time.
#' * `Factor` _character_ - What type of demographic group this row describes.
#' * `Level` _character_ - The specific demographic group that this row describes.
#' * `Pathway` _character_ - The specific mathematics coursework that the students did.
#' * `First-time cohort` _integer_ - The number of students in this group in their first fall.
#' * `Count` _integer_ - The number of students in the group who earned a credential.
#' * `Offered` _character_ - Whether or not that pathway was available for students.
#' @export
read_math_pathways <- function(.file_name) {

    .file_name |>
        readxl::read_xlsx(
            sheet = "Math Pathways",
            range = "A8:I11",
            col_names = c("Population",
                          "First-time cohort",
                          "Exempt",
                          "College Algebra",
                          "Quantitative Reasoning",
                          "Statistics",
                          "Technical Math",
                          "Other Course (total)",
                          "More than one gateway math course"
            ),
            col_types = c("text", rep("numeric", 8)),
            na = c("", "NA", "N/A", "DS")
        ) |>
        wrangle_population_and_enrollment_status() |>
        tidyr::pivot_longer(
            cols = !(1:4),
            names_to = "Pathway",
            values_to = "Count"
        ) |>
        dplyr::relocate(
            "First-time cohort",
            .before = "Count"
        ) |>
        dplyr::left_join(
            .file_name |>
                readxl::read_xlsx(
                    sheet = "Math Pathways",
                    range = "C7:I7",
                    col_names = c("Exempt",
                                  "College Algebra",
                                  "Quantitative Reasoning",
                                  "Statistics",
                                  "Technical Math",
                                  "Other Course (total)",
                                  "More than one gateway math course"
                    ),
                    col_types = "text",
                    na = c("", "NA", "N/A", "DS")
                ) |>
                t() |>
                tibble::as_tibble(
                    rownames = "Pathway",
                    .name_repair = ~ "Offered"
                ),
            by = "Pathway"
        )
}
