#' @include AllClasses.R AllGenerics.R operations.R
NULL

#' @describeIn intersection Applies the standard intersection
#' @param FUN A function to be applied when performing the union.
#' The standard intersection is the "min" function, but you can provide any other
#' function that given a numeric vector returns a single number.
#' @param keep A logical value if you want to keep originals sets.
#' @export
setMethod("intersection",
          signature = signature(object = "TidySet",
                                set1 = "character",
                                set2 = "character",
                                setName = "character"),
          function(object, set1, set2, setName, FUN = "min", keep = FALSE) {
            operation_helper(object, set1, set2, setName, FUN, keep)
          }
)
