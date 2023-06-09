% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_graduation_bachelors.R
\name{read_graduation_bachelors}
\alias{read_graduation_bachelors}
\title{Import data on graduation from programs that grant Bachelor's degrees.}
\usage{
read_graduation_bachelors(.file_name)
}
\arguments{
\item{.file_name}{the full path to the spreadsheet with data}
}
\value{
A tibble with six fields:
\itemize{
\item \verb{Enrollment at entry} \emph{character} - Either Full- or Part-time.
\item \verb{Demographic Group} \emph{character} - What type of demographic group this row describes.
\item \code{Detail} \emph{character} - The specific demographic group that this row describes.
\item \verb{Completion Time} \emph{character} - Either 100\% (4-year rate) or 150\% (6-year rate).
\item \code{Cohort} \emph{integer} - The number of students in this group in their first fall.
\item \code{Count} \emph{integer} - The number of students in the group who graduated with a bachelor's degree.
}
}
\description{
Import data on graduation from programs that grant Bachelor's degrees.
}
