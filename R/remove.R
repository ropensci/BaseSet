#' @include AllGenerics.R
NULL

#' @describeIn remove_relation Removes a relation between elements and sets.
#' @export
setMethod("remove_relation",
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


#' @describeIn remove_element Removes everything related to an element
#' @export
setMethod("remove_element",
          signature = signature(object = "TidySet",
                                elements = "character"),
          function(object, elements) {
            object <- remove_elements(object, elements)
            old_relation <- relations(object)
            keep <- old_relation$elements %in% name_elements(object)
            object@relations <- droplevels(old_relation[keep, , drop = FALSE])
            validObject(object)
            object
          }
)


#' @describeIn remove_set Removes everything related to a set
#' @export
setMethod("remove_set",
          signature = signature(object = "TidySet",
                                sets = "character"),
          function(object, sets) {
            object <- remove_sets(object, sets)
            old_relation <- relations(object)
            keep <- old_relation$sets %in% name_sets(object)
            object@relations <- droplevels(old_relation[keep, , drop = FALSE])
            validObject(object)
            object
          }
)
