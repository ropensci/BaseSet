#' @include AllGenerics.R
NULL


#' @describeIn rename_set Rename sets
#' @export rename_set
setMethod("rename_set",
          signature = signature(object = "TidySet"),
          function(object, old, new) {
            membership <- name_sets(object) %in% old
            if (!any(membership)) {
              stop("All sets should be found on the TidySet")
            }
            name_sets(object)[membership] <- new
            validObject(object)
            object
          }
)

#' @describeIn rename_elements Rename elements
#' @export rename_elements
setMethod("rename_elements",
          signature = signature(object = "TidySet"),
          function(object, old, new) {
            membership <- name_elements(object) %in% old
            if (!any(membership)) {
              stop("All elements should be found on the TidySet")
            }
            name_elements(object)[membership] <- new
            validObject(object)
            object
          }
)
