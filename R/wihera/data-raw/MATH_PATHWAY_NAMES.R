## code to prepare `MATH_PATHWAY_NAMES` dataset goes here

MATH_PATHWAY_NAMES <- c(
    "Exempt",
    "College Algebra",
    "Quantitative Reasoning",
    "Statistics",
    "Technical Math",
    "Other",
    "Multiple"
)

usethis::use_data(MATH_PATHWAY_NAMES, overwrite = TRUE)
