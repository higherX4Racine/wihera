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
#' * `Name` _character_ - The name of the Institution of Higher Education.
#' * `Campus` _character_ - The name for the campus, optional
#' * `Search` _character_ - A search term for finding files relevant to the school.
#'
#' @source [College Scorecard](https://collegescorecard.ed.gov/data/)
"HERA_SCHOOLS"

#' Standard labels for the different possible Math Pathways
#'
#' @format a character vector
"MATH_PATHWAY_NAMES"

#' Map from short names for momentum milestone statuses to their prolix HERA labels.
#' @format a tibble with four columns:
#'
#' * `Order` _integer_ The order that the milestone status appears in the template sheet.
#' * `Short Name` _character_ - A terse description of the milestone status
#' * `Status` _character_ - Either "Completed" or "Exempt".
#' * `Long Name` _character_ - The full name of the measure from the template sheet.
"MOMENTUM_MILESTONES"

#' Layout information for the data-entry template of 2023
#'
#' @format This list has the following layout: Sheet(Region(Rows, Columns)),
#' and the following values:
#'
#' |Sheet                          |Region| Rows|Columns|
#' |:------------------------------|:-----|----:|------:|
#' |Retention                      |fields|  1:5|    1:3|
#' |                               |labels| 6:41|    1:1|
#' |Momentum in First Year         |fields| 1:5|    1:10|
#' |                               |labels| 6:41|    1:1|
#' |Math Pathways                  |fields|  1:6|    1:9|
#' |                               |labels| 7:11|    1:1|
#' |Graduation - Programs < 4 years|fields|  1:7|    1:7|
#' |                               |labels| 8:43|    1:2|
#' |Graduation - Bachelors degrees |fields|  1:5|    2:5|
#' |                               |labels| 6:41|    2:2|
#' |Graduates Time and Credits     |fields|  1:5|    1:5|
#' |                               |labels|6:149|    1:2|
"TEMPLATE_REGIONS_2023"

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
