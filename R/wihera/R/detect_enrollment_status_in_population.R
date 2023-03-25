#' Predicate for finding rows that contain full- or part-time status
#'
#' @param .v A vector of population names
#'
#' @return a logical vector that is true where the word "time" appears in `.v`
#' @export
#'
#' @examples
#' detect_enrollment_status_in_population(c("time", "nope", "Time", "full-time"))
detect_enrollment_status_in_population <- function(.v) {
    stringr::str_detect(stringr::str_to_lower(.v), "time")
}
