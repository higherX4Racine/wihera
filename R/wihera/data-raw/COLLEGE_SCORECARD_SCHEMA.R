## code to prepare `COLLEGE_SCORECARD_SCHEMA` dataset goes here

COLLEGE_SCORECARD_SCHEMA <- system.file("extdata",
                                        "college_scorecard_schema.csv",
                                        package = "wihera") |>
    readr::read_csv(
        col_names = TRUE,
        col_types = readr::cols(.default = readr::col_character()),
        na = c("", "NA", "#N/A", "NULL")
    ) |>
    dplyr::mutate(
        Specification = dplyr::case_match(
            stringr::str_to_lower(.data$`API data type`),
            c("float", "double", "numeric") ~  "d",
            "integer" ~ "i",
            c("boolean", "logical") ~ "l",
            c("date", "ymd") ~ "D",
            .default = "c"
        )
    )

usethis::use_data(COLLEGE_SCORECARD_SCHEMA, overwrite = TRUE)
