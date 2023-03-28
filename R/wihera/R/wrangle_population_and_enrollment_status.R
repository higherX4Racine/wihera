#' The Population field includes sparse representation of Enrollment Status
#'
#' @param .x a data frame with a multi-valued HERA Population column
#'
#' @returns
#' A data with `Population` removed, and two extra columns:
#'
#' * `Enrollment at entry` _character_ -  whether the students were full- or part-time.
#' * `Demographic Group` _character_ - Which kind of population the next variable denotes
#' * `Detail` _character_ - a specific kind of population, like a race or economic group
#'
#' @importFrom rlang .data
#'
#' @export
wrangle_population_and_enrollment_status <- function(.x){
    .x |>
        dplyr::mutate(
            `Enrollment at entry` =
                .data$Population |>
                detect_enrollment_status_in_population() |>
                dplyr::if_else(.data$Population, NA) |>
                fill_down_when_blank() |>
                stringr::str_to_lower(),
            `Enrollment at entry` = dplyr::case_when(
                stringr::str_detect(.data$`Enrollment at entry`,
                                    "full") ~
                    "Full Time",
                stringr::str_detect(.data$`Enrollment at entry`,
                                    "part") ~
                    "Part Time",
                TRUE ~ NA
            )
        ) |>
        dplyr::relocate(
            "Enrollment at entry",
            .before = "Population"
        ) |>
        dplyr::filter(
            !detect_enrollment_status_in_population(.data$Population)
        ) |>
        tidyr::separate(
            col = "Population",
            into = c("Demographic Group", "Detail"),
            sep = ": ",
            fill = "right"
        ) |>
        dplyr::mutate(
            `Demographic Group` = dplyr::case_match(
                .data$`Demographic Group`,
                "TOTAL Students" ~ "Total",
                "Race" ~ "Race/Ethnicity",
                .default = .data$`Demographic Group`
            ),
            Detail = dplyr::case_match(
                .data$Detail |>
                    stringr::str_extract("^(\\w+)") |>
                    stringr::str_to_lower(),
                NA ~ "All Students",
                "hispanic" ~ "Hispanic/Latinx",
                "black" ~ "Black, non-Hispanic",
                "white" ~ "White, non-Hispanic",
                "asian" ~ "Asian",
                "native" ~ "Native Hawaiian or other Pacific Islander",
                "american" ~ "American Indian/Alaska Native",
                "two" ~ "Two or More Races",
                "unknown" ~ "Unknown",
                "non" ~ "Non-resident Alien",
                "male" ~ "Male",
                "female" ~ "Female",
                "17" ~ "17-19 years old",
                "20" ~ "20-24 years old",
                "age" ~ "Age 25 and over",
                "received" ~ "Received Pell Grant"
            )
        )
}
