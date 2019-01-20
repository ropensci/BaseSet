#' @include AllGenerics.R
NULL


#' @describeIn rename_set Rename sets
#' @export rename_set
setMethod("rename_set",
          signature = signature(object = "TidySet"),
          function(object, old, new) {
            sets <- sets(object)
            # browser()
            membership <- old %in% sets$set
            if (!all(membership)) {
              stop("All sets should be found on the TidySet")
            }
            levels(sets$set)[levels(sets$set) %in% old] <- new
            object@sets <- sets

            relations <- relations(object)
            levels(relations$sets)[levels(relations$sets) %in% old] <- new
            object@relations <- relations

            validObject(object)
            object
          }
)

#' @describeIn rename_elements Rename elements
#' @export rename_elements
setMethod("rename_elements",
          signature = signature(object = "TidySet"),
          function(object, old, new) {
            element <- elements(object)

            membership <- old %in% elements$elements
            if (!all(membership)) {
              stop("All elements should be found on the TidySet")
            }
            levels(element$elements)[levels(element$elements) %in% old] <- new
            object@elements <- element

            relations <- relations(object)
            levels(relations$elements)[levels(relations$elements) %in% old] <- new
            object@relations <- relations

            validObject(object)
            object
          }
)
