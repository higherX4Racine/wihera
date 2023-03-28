#' Add extra verbiage to a percentage completion time.
#'
#' @param .completion_time _character_ - a percentage including a "%".
#'
#' @return "Earned degree/certificate within {.completion time} time"
#' @export
#'
#' @examples
#' verbose_completion_time(c("100%", "150%", "999%", NA))
verbose_completion_time <- function(.completion_time){
    glue::glue("Earned degree/certificate within ",
               "{.completion_time} time")
}
