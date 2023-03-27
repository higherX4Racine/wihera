#' Compare a region of a submitted worksheet to its template
#'
#' @param .dims A list with elements `rows` and `cols`
#' @param .template A tibble of text-valued cells
#' @param .submission A tibble of text-value cells to compare to `.template`
#'
#' @return A `waldo::waldo_compare` that describes each mismatch between inputs.
#' @export
check_template <- function(.dims, .template, .submission) {
    waldo::compare(.template[.dims$rows, .dims$cols],
                   .submission[.dims$rows, .dims$cols],
                   x_arg = "template",
                   y_arg = "submission")
}
