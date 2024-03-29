% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/c.R
\name{c,TidySet-method}
\alias{c,TidySet-method}
\title{Combine Values into a Vector or List}
\usage{
\S4method{c}{TidySet}(x, ...)
}
\arguments{
\item{x}{A TidySet object.}

\item{...}{Objects to be concatenated. All NULL entries are dropped.}
}
\description{
This method combines TidySets.
It only works if the first element is a TidySet.
}
\examples{
TS <- tidySet(list(A = letters[1:5], B = letters[6]))
TS2 <- c(TS, data.frame(sets = "C", elements = "gg"))
}
