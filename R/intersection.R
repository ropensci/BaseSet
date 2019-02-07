#' @include AllClasses.R AllGenerics.R operations.R
NULL

#' @describeIn intersection Applies the standard intersection
#' @export
setMethod("intersection",
          signature = signature(object = "TidySet",
                                set1 = "character",
                                set2 = "character",
                                setName = "character"),
          function(object, set1, set2, setName, FUN = "min", keep = FALSE) {
            object <- operation_helper(object, set1, set2, setName, FUN, keep)
            if (!keep) {
            sets <- name_sets(object)
            remove <- sets[!sets %in% setName]
            object <- remove_set(object, remove)
            }
            object
          }
)
