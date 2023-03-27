#' Print a `waldo_compare` report for inclusion in a Markdown document.
#'
#' @param .waldo_compare - output from calling waldo::compare
#' @param .label - a text label for the comparison
#' @param .heading - the heading prefix for the Markdown output
#'
#' @return nothing
#' @export
mismatch_as_markdown <- function(.waldo_compare, .label, .heading){
    if (length(.waldo_compare)) {
        .e <- paste0(tail(.waldo_compare, -1), "\n")
        cat(
            glue::glue(
                "\n\n{.heading} {.label}: {length(.e)} mismatch",
                "{ifelse(length(.e) != 1, 'es', '')}\n\n"
            )
        )
        cat("```r\n")
        purrr::walk(.e, cat, "\n")
        cat("\n```\n")
    }
}
