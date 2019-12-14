#' Read an XML file
#'
#' Read an XML formatted file
#'
#' @param x A file in XML format
#' @return A TidySet object
#' @family IO functions
#' @export
# oboFile <- system.file(package = "BaseSet", "extdata",
#                                   "go-basic_subset.obo")
# gs <- getOBO(oboFile)
# head(gs)
# x <- "../rare/data/es_product1.xml"
#' @include AllGenerics.R
getXML <- function(x) {
    xml <- xml2::read_xml(x)
    x
}
