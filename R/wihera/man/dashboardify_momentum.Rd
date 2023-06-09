% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dashboardify_momentum.R
\name{dashboardify_momentum}
\alias{dashboardify_momentum}
\title{Convert Higher Expectations' data layout to HERA's dashboard layout}
\usage{
dashboardify_momentum(.x)
}
\arguments{
\item{.x}{\emph{tibble} - a data frame produced by \code{read_graduation_cc_or_tech}.}
}
\value{
a data frame in the HERA dashboard format. It does not include \code{Degree/Certificate}.
\itemize{
\item \code{Measure} \emph{character} - The indicator that is quantified by \code{Outcome}.
\item \verb{Enrollment at entry} \emph{character} - Whether the students are full- or part-time.
\item \verb{Demographic Group} \emph{character} - A type of demographic group, like race or age.
\item \code{Detail} \emph{character} - A specific demographic group, like \code{Latine} or \code{18-24}.
\item \code{Cohort} \emph{integer} - If present, the denominator to use to convert \code{Outcome} to a percentage.
\item \code{Outcome} \emph{numeric} - A quantitative \code{Measure} of some aspect of the school's performance.
}
}
\description{
Convert Higher Expectations' data layout to HERA's dashboard layout
}
