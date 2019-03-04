#' @include AllClasses.R AllGenerics.R
NULL

#' @rdname tidySet
#' @export
tidy <- function(object) {
  UseMethod("tidy")
}

#' @describeIn tidySet Converts to a tidySet given a GeneSetCollection
#' @export
#' @method tidy GeneSetCollection
tidy.GeneSetCollection <- function(object) {
  # browser()
  data <- slot(object, ".Data")
  sets <- lapply(data, tidySet)
  TS <- Reduce(merge_tidySets, sets)
  validObject(TS)
  TS
}


#' @describeIn tidySet Converts to a tidySet given a GeneSet
#' @export
#' @method tidy GeneSet
tidy.GeneSet <- function(object) {
  # browser()
  relations <- data.frame(elements = object@geneIds,
                          sets = object@setName)
  TS <- tidySet(relations)
  new_sets <- c(sets = as.character(sets(TS)$sets[1]),
                Identifier = slot(object, "setIdentifier"),
                shortDescripton = slot(object, "shortDescription"),
                longDescription = slot(object, "longDescription"),
                organism = slot(object, "organism"),
                pubMedIds = slot(object, "pubMedIds"),
                urls = slot(object, "urls"),
                contributor = slot(object, "contributor"))
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


#' @export
#' @method tidy GOCollection
tidy.GOCollection <- function(object) {
  out <- NextMethod()
  if (length(object@ontology) > 1)  {
    out["ontology"] <- NA
  } else {
    out["ontology"] <- object@ontology
  }
  out
}

#' @export
#' @method tidy BroadCollection
tidy.BroadCollection <- function(object) {
  out <- NextMethod()
  out["category"] <- object@category
  out["subCategory"] <- object@subCategory
  out
}

#' @export
#' @method tidy GeneIdentifierType
tidy.GeneIdentifierType <- function(object) {
  helper_tidy(object)
}
