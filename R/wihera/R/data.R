#' A tibble of data from the last sheet of an example spreadsheet from 2023
#'
#' The last sheet in the 2023 template worksheet is an aggregate long table
#' It  has the following fields:
#'
#' * `Source Tab` _character_ Whence the data came.
#' * `Degree/Certificate` _character_ 1y, 2y, 2y-4y, or Bachelor's degree
#' * `Measure` _character_ Y-axis labels when `Outcome` is plotted.
#' * `Enrollment at entry` _character_ Full- or Part-time
#' * `Demographic Group` _character_ Different factors like race or age.
#' * `Detail` _character_ Levels for the different `Demographic Group` factors.
#' * `Cohort` _numeric_ Denominator values for percentage calculations.
#' * `Outcome` _numeric_ Values for reporting or for numerators of percents.
"WIStateUAandM2023"
