#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn union Applies the standard union
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

            # Handle the duplicate cases
            basic <- paste(object@relations$sets, object@relations$elements)
            indices <- split(seq_along(basic), basic)
            # Helper function probably useful for intersection too
            iterate <- function(i, fuzzy, fun) {
              fun(fuzzy[i])
            }
            # It could be possible to apply some other function to the relations
            # that are the same
            fuzzy <- vapply(indices, iterate, fuzzy = object@relations$fuzzy,
                            fun = max, numeric(1L))
            relations2 <- unique(object@relations[, c("sets", "elements")])
            relations2 <- cbind.data.frame(relations2, fuzzy = fuzzy)
            object@relations <- relations2
            validObject(object)
            object
          }
)
