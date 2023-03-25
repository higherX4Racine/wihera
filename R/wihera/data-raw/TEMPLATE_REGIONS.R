## code to prepare `TEMPLATE_REGIONS` dataset goes here

TEMPLATE_REGIONS <- list(
    `Retention` = list(
        fields = list(rows = 1:5, cols = 1:3),
        labels = list(rows = 6:41, cols = 1)
    ),
    `Momentum in First Year` = list(
        fields = list(rows = 1:5, cols = 1:10),
        labels = list(rows = 6:41, cols = 1)
    ),
    `Math Pathways` = list(
        fields = list(rows = 1:6, cols = 1:9),
        labels = list(rows = 7:11, cols = 1)
    ),
    `Graduation - Programs < 4 years` = list(
        fields = list(rows = 1:7, cols = 1:7),
        labels = list(rows = 8:43, cols = 1:2)
    ),
    `Graduation - Bachelors degrees` = list(
        fields = list(rows = 1:5, cols = 2:5),
        labels = list(rows = 6:41, cols = 2)
    ),
    `Graduates Time and Credits` = list(
        fields = list(rows = 1:5, cols = 1:5),
        labels = list(rows = 6:149, cols = 1:2)
    )
)

usethis::use_data(TEMPLATE_REGIONS, overwrite = TRUE)
