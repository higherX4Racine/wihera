% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_math_pathways.R
\name{read_math_pathways}
\alias{read_math_pathways}
\title{Import data on how first-year students fared on their mathematics coursework.}
\usage{
read_math_pathways(.file_name)
}
\arguments{
\item{.file_name}{the full path to the spreadsheet with data}
}
\value{
A tibble with seven fields:
\itemize{
\item \verb{Enrollment Status} \emph{character} - Either Full- or Part-time.
\item \verb{Demographic Group} \emph{character} - What type of demographic group this row describes.
\item \code{Detail} \emph{character} - The specific demographic group that this row describes.
\item \code{Pathway} \emph{character} - The specific mathematics coursework that the students did.
\item \code{Cohort} \emph{integer} - The number of students in this group in their first fall.
\item \code{Count} \emph{integer} - The number of students in the group who earned a credential.
\item \code{Offered} \emph{character} - Whether or not that pathway was available for students.
}
}
\description{
Import data on how first-year students fared on their mathematics coursework.
}
