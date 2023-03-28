## code to prepare `MOMENTUM_MILESTONES` dataset goes here

MOMENTUM_MILESTONES <- system.file("extdata",
                                   "MOMENTUM_MILESTONES.csv",
                                   package = "wihera") |>
    readr::read_csv(col_types = readr::cols(
        Order = readr::col_integer(),
        .default = readr::col_character()
    ))

usethis::use_data(MOMENTUM_MILESTONES, overwrite = TRUE)
