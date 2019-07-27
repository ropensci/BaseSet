#' @importFrom XML xmlTreeParse
#' @examples
#' fl <- system.file("extdata", "Broad.xml", package="GSEABase")
#' gss <- getXML(fl) # GeneSetCollection of 2 sets
getXML <- function(x, ...) {
    # GSEABAse::getBroadSets -> .fromXML
    res <- XML::xmlTreeParse(x, useInternalNodes = TRUE, ...)
    browser()
}
