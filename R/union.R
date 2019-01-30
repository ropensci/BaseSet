#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn union Merge two sets
#' @export
setMethod("union",
          signature = signature(object = "TidySet",
                                set1 = "character",
                                set2 = "character",
                                setName = "character"),
          function(object, set1, set2, setName, ...) {

            sets <- name_sets(object)
            levels(object@sets$set)[sets %in% set1] <- setName
            levels(object@sets$set)[sets %in% set2] <- setName
            object@sets <- unique(object@sets)

            sets2 <- levels(object@relations$sets)
            levels(object@relations$sets)[sets2 %in% set1] <- setName
            levels(object@relations$sets)[sets2 %in% set2] <- setName

            validObject(object)
            object
          }
)
