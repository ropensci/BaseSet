#' @include AllGenerics.R
NULL

#' @describeIn remove_set Removes a set
#' @export
setMethod("remove_set",
          signature = signature(object = "TidySet",
                                elements = "character",
                                sets = "character"),
          function(object, elements, sets) {
            old_elements <- name_elements(object)
            old_sets <- name_sets(object)
            object <- remove_relations(object, elements, sets)

            removing_elements <- setdiff(object@relations$elements, old_elements)
            removing_sets <- setdiff(object@relations$sets, old_sets)

            object <- remove_elements(object, removing_elements)
            object <- remove_sets(object, removing_sets)
            validObject(object)
            object
          }
)
