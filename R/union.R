#' @include AllClasses.R AllGenerics.R operations.R
NULL

#' @describeIn union Applies the standard union
#' @export
setMethod("union",
          signature = signature(object = "TidySet",
                                set1 = "character",
                                set2 = "character",
                                setName = "character"),
          function(object, set1, set2, setName, FUN = "max", keep = FALSE) {
            operation_helper(object, set1, set2, setName, FUN, keep)
          }
)
