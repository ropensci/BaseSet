% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/obo.R
\name{getGAF}
\alias{getGAF}
\title{Read a GAF file}
\usage{
getGAF(x)
}
\arguments{
\item{x}{A file in GAF format}
}
\value{
A TidySet object
}
\description{
Read a GO Annotation File (GAF) formatted file
}
\examples{
gafFile <- system.file(
    package = "BaseSet", "extdata",
    "go_human_rna_valid_subset.gaf"
)
gs <- getGAF(gafFile)
head(gs)
}
\references{
The format is defined \href{https://geneontology.org/docs/go-annotation-file-gaf-format-2.1/}{here}.
}
\seealso{
Other IO functions: 
\code{\link{getGMT}()},
\code{\link{getOBO}()}
}
\concept{IO functions}
