#' For one worksheet layout, compare every school to a template
#'
#' @param .schools a list of worksheets named by the school they come from
#' @param .regions a named list of regions within the template to examine
#' @param .template the template that serves as the standard
#'
#' @return
#' a tibble with the following fields
#'
#' * **School** the label of the school
#' * A count of the number of mismatches for each element of `.regions`
#' * **messages** a list of the mismatches
#'
#' @importFrom magrittr `%>%`
#' @export
check_sheet <- function(.schools, .regions, .template){
    .schools %>%
        purrr::map(
            check_school,
            .regions = .regions,
            .template = .template
        ) %>%
        purrr::list_rbind(
            names_to = "School"
        ) %>%
        dplyr::arrange(
            .data$School
        )
}
