surly_read_xlsx <- function(...,
                            call = rlang::caller_env()) {
    rlang::try_fetch(
        readxl::read_xlsx(...),
        warning = function(cnd) {
            rlang::abort("Problem reading spreadsheet",
                         parent = cnd,
                         call = call)
        }
    )
}
