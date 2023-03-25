#' Turn human-readable blank-riddled columns into actual data
#'
#' @param .v a column of data with `NA`'s in empty cells
#'
#' @return a column of data with `NA`s replaced by values above them.
#' @export
#'
#' @examples
#' v <- rep(x = c("A", NA, "B", NA, "C", NA),
#'          times = c(1, 3, 1, 4, 1, 2))
#' fill_down_when_blank(v)
fill_down_when_blank <- function(.v){
    purrr::accumulate(.v,
                      ~ ifelse(is.na(.y),
                               .x,
                               .y))
}
