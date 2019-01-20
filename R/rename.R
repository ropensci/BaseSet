#' @include AllGenerics.R
NULL


#' @describeIn rename_set Rename sets
#' @export rename_set
setMethod("rename_set",
          signature = signature(object = "TidySet"),
          function(object, old, new) {
            sets <- sets(object)
            # browser()
            membership <- old %in% levels(sets$set)
            if (!all(membership)) {
              stop("All sets should be found on the TidySet")
            }
            name_sets(object)[membership] <- new
            object
          }
)

#' @describeIn rename_elements Rename elements
#' @export rename_elements
setMethod("rename_elements",
          signature = signature(object = "TidySet"),
          function(object, old, new) {
            element <- elements(object)

            membership <- old %in% levels(elements$elements)
            if (!all(membership)) {
              stop("All elements should be found on the TidySet")
            }
            name_elements(object)[membership] <- new
            object
          }
)
