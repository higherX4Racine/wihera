#' Identifying information for finding HERA schools in the College Scorecard
#'
#' The U.S. Department of Education maintains a database of demographic and
#' performance measures for participating institutions of higher education.
#' Southeastern Wisconsin has a confederation of such schools, the Higher
#' Education Regional Alliance.
#' @format A tibble with 4 columns:
#'
#' * `UNITID` _integer_ - College Scorecard code for one specific campus/location.
#' * `OPEID6` _integer_ - A code for one IHD, which may have multiple campuses.
#' * `Name` _string_ - The name of the Institution of Higher Education.
#' * `Campus` _string_ - The name for the campus, optional
#' * `Search` _string_ - A search term for finding files relevant to the school.
#'
#' @source [College Scorecard](https://collegescorecard.ed.gov/data/)
"HERA_SCHOOLS"

#' A tibble of data from the last sheet of an example spreadsheet from 2023
#'
#' The last sheet in the 2023 template worksheet is an aggregate long table
#' @format a tibble with 8 fields:
#'
#' * `Source Tab` _character_ - Whence the data came.
#' * `Degree/Certificate` _character_ - 1y, 2y, 2y-4y, or Bachelor's degree
#' * `Measure` _character_ - Y-axis labels when `Outcome` is plotted.
#' * `Enrollment at entry` _character_ - Full- or Part-time
#' * `Demographic Group` _character_ - Different factors like race or age.
#' * `Detail` _character_ - Levels for the different `Demographic Group` factors.
#' * `Cohort` _numeric_ - Denominator values for percentage calculations.
#' * `Outcome` _numeric_ - Values for reporting or for numerators of percents.
#'
#' @source [The Higher Education Regional Alliance](https://www.herawisconsin.org/)
"WIStateUAandM2023"
