#' Create a column of enrollment statuses from the population column
#'
#' @param .v a character vector of grouped population characteristics
#'
#' @return a character vector of enrollment statuses
#' @export
#'
#' @examples
#' enrollment_status_from_population(
#'  c("Full-Time (at entry)","TOTAL Students", "Race", "Gender", "Age")
#' )
enrollment_status_from_population <- function(.v) {
    fill_down_when_blank(
        dplyr::if_else(
            detect_enrollment_status_in_population(.v),
            .v,
            NA
        )
    )
}
