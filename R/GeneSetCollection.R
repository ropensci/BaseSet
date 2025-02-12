#' @include AllClasses.R AllGenerics.R
NULL


#' @describeIn tidySet Converts to a tidySet given a GeneSetCollection
#' @export
#' @examples
#' # Needs GSEABase package from Bioconductor
#' if (requireNamespace("GSEABase", quietly = TRUE)) {
#'     library("GSEABase")
#'     gs <- GeneSet()
#'     gs
#'     tidySet(gs)
#'     fl <- system.file("extdata", "Broad.xml", package="GSEABase")
#'     gs2 <- getBroadSets(fl) # actually, a list of two gene sets
#'     TS <- tidySet(gs2)
#'     dim(TS)
#'     sets(TS)
#' }
tidySet.GeneSetCollection <- function(relations) {
    data <- slot(relations, ".Data")
    sets <- lapply(data, tidySet)
    TS <- Reduce(merge_tidySets, sets)
    validObject(TS)
    TS
}


#' @describeIn tidySet Converts to a tidySet given a GeneColorSet
#' @export
tidySet.GeneColorSet <- function(relations) {
    data <- slot(relations, "geneIds")
    if (is.list(data)) {
        sets <- lapply(data, tidySet)
        TS <- Reduce(merge_tidySets, sets)
    } else {
        sets <- slot(relations, "setName")
        lTS <- list(data)
        names(lTS) <- sets
        TS <- tidySet(lTS)
    }
    validObject(TS)
    TS
}

#' @describeIn tidySet Converts to a tidySet given a GeneSet
#' @export
tidySet.GeneSet <- function(relations) {
    object <- relations

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
    new_sets <- c(new_sets, tidySet(object@collectionType))
    sets(TS) <- as.data.frame(t(new_sets))
    validObject(TS)
    TS
}

helper_tidy <- function(relations) {
    object <- relations
    name <- object@type
    if (name != "Null") {
        c("type" = name)
    }
}

#' @export
tidySet.CollectionType <- function(relations) {
    helper_tidy(relations)
}
