#' Import data on graduation from programs designed to take less than 4 years.
#'
#' @param .file_name the full path to the spreadsheet with data
#'
#' @importFrom magrittr `%>%`
#' @export
read_cc_or_tech_graduation <- function(.file_name) {

    .file_name %>%
        readxl::read_xlsx(
            path = .,
            sheet = "Graduation - Programs < 4 years",
            range = "A8:G43",
            col_names = c(
                "Enrollment Status",
                "Population",
                "First-time cohort",
                t(outer(
                    glue::glue("{c(10,15)}0%"),
                    glue::glue("{c('0y-2y', '2y-4y')}"),
                    paste, sep = "\n"))
            ),
            col_types = c(rep("text", 2),
                          rep("numeric", 5)),
            na = c("", "NA", "N/A", "DS")
        ) %>%
        dplyr::mutate(
            `Enrollment Status` =
                fill_down_when_blank(.data$`Enrollment Status`)
        ) %>%
        tidyr::separate(
            col = "Population",
            into = c("Factor", "Level"),
            sep = ": ",
            fill = "right"
        ) %>%
        tidyr::pivot_longer(
            cols = !(1:6),
            names_to = c("Completion Time",
                         "Program Length"),
            names_sep = "\n",
            values_to = "Count"
        )
}
