#' Print a list of template regions as a Markdown pipe table
#'
#' @param .regions A list of lists of regions, named by worksheet
#'
#' @return Nothing, prints out the pipe table for pasting into documentation.
#'
#' @export
pretty_print_regions <- function(.regions){
    cat("|Sheet|Region|Rows|Columns|\n")
    cat("|:----|:-----|---:|------:|\n")
    .regions |>
        purrr::iwalk(
            ~ cat(glue::glue("|{.y}|{purrr::imap_chr(.x, .rowify)}|\n"),
                  sep = "\n")
    )
}

.rangify <- function(.x){
    paste0(range(.x), collapse = ":")
}

.rowify <- function(.list, .name){
    glue::glue("{.name}|{paste0(purrr::map_chr(.list, .rangify), collapse = '|')}")
}

