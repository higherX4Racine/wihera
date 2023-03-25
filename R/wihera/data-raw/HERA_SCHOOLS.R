## code to prepare `HERA_SCHOOLS` dataset goes here

HERA_SCHOOLS <- system.file("extdata",
                            "HERA SCHOOLS.csv",
                            package = "wihera") |>
    readr::read_csv(
        show_col_types = FALSE
    )

usethis::use_data(HERA_SCHOOLS, overwrite = TRUE)
