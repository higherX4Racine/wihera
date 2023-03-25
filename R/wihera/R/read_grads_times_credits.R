#' Import data on graduation times and credits earned across populations.
#'
#' @param .file_name the full path to the spreadsheet with data
#'
#' @importFrom magrittr `%>%`
#' @export
read_grads_times_credits <- function(.file_name) {

    .file_name %>%
        readxl::read_xlsx(
            path = .,
            sheet = "Graduates Time and Credits",
            range = "A6:E149",
            col_names = c("Degree Type",
                          "Population",
                          "Count",
                          "Credits",
                          "Years"),
            col_types = c(rep("text", 2),
                          rep("numeric", 3)),
            na = c("", "NA", "N/A", "DS")
        ) %>%
        dplyr::mutate(
            `Degree Type` = fill_down_when_blank(.data$`Degree Type`)
        ) %>%
        wrangle_population_and_enrollment_status()
}
