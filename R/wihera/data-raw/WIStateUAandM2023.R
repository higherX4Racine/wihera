## code to prepare `WIStateUAandM2023` dataset goes here

WIStateUAandM2023 <- readxl::read_xlsx(
    path = system.file("extdata",
                       "2023_Example_HERA_Data_Submission_form.xlsx",
                       package = "wihera"),
    sheet = "Data Cleaning (DO NOT USE)",
    col_names = TRUE,
    col_types = rep(c("text", "numeric"),
                    c(6, 2)),
    na = c("", "NA", "N/A", "U", "DS"),
    trim_ws = TRUE
)

usethis::use_data(WIStateUAandM2023, overwrite = TRUE)
