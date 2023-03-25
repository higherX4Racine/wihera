#' Import data on graduation from programs that grant Bachelor's degrees.
#'
#' @param .file_name the full path to the spreadsheet with data
#'
#' @importFrom magrittr `%>%`
#' @export
read_bachelors_graduation <- function(.file_name) {

    .file_name %>%
        readxl::read_xlsx(
            path = .,
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
        ) %>%
        wrangle_population_and_enrollment_status() %>%
        tidyr::pivot_longer(
            cols = !(1:3),
            names_to = c("Completion Time"),
            values_to = "Count"
        )
}
