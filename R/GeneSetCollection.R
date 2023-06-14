#' @include AllClasses.R AllGenerics.R
NULL

#' Convert GSEABase classes to a TidySet
#' @param object A GeneSetCollection or a GeneSet derived object
#' @return A TidySet object.
#' @export
tidy <- function(object) {
    UseMethod("tidy")
}

#' @export
tidy.default <- function(object) {
    tidySet(object)
}

#' @describeIn tidy Converts to a tidySet given a GeneSetCollection
#' @export
#' @method tidy GeneSetCollection
#' @examples
#' # Needs GSEABase pacakge from Bioconductor
#' if (requireNamespace("GSEABase", quietly = TRUE)) {
#'     library("GSEABase")
#'     gs <- GeneSet()
#'     gs
#'     tidy(gs)
#'     fl <- system.file("extdata", "Broad.xml", package="GSEABase")
#'     gs2 <- getBroadSets(fl) # actually, a list of two gene sets
#'     TS <- tidy(gs2)
#'     dim(TS)
#'     sets(TS)
#' }
tidy.GeneSetCollection <- function(object) {
    data <- slot(object, ".Data")
    sets <- lapply(data, tidy)
    TS <- Reduce(merge_tidySets, sets)
    validObject(TS)
    TS
}

#' @describeIn tidy Converts to a tidySet given a GeneSet
#' @export
#' @method tidy GeneSet
tidy.GeneSet <- function(object) {
    if (length(object@geneIds) == 0) {
        elements <- character(length = 1)
    } else {
        elements <- object@geneIds
    }

    if (is.na(object@setName)) {
        sets <- "set1"
    } else {
        sets <- object@setName
    }
    relations <- data.frame(
        elements = elements,
        sets = sets
    )
    TS <- tidySet(relations)
    TS <- filter_element(TS, elements != "")
    new_sets <- c(
        sets = as.character(sets(TS)$sets[1]),
        Identifier = slot(object, "setIdentifier"),
        shortDescripton = slot(object, "shortDescription"),
        longDescription = slot(object, "longDescription"),
        organism = slot(object, "organism"),
        pubMedIds = slot(object, "pubMedIds"),
        urls = slot(object, "urls"),
        contributor = slot(object, "contributor")
    )
    new_sets <- c(new_sets, tidy(object@collectionType))
    sets(TS) <- as.data.frame(t(new_sets))
    validObject(TS)
    TS
}

helper_tidy <- function(object) {
    name <- object@type
    if (name != "Null") {
        c("type" = name)
    }
}

#' @export
#' @method tidy CollectionType
tidy.CollectionType <- function(object) {
    helper_tidy(object)
}
