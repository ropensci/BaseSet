#' @include AllGenerics.R
NULL

#' @describeIn remove_relation Removes a relation between elements and sets.
#' @export
setMethod("remove_relation",
          signature = signature(object = "TidySet",
                                elements = "character",
                                sets = "character"),
          function(object, elements, sets) {
            object <- remove_relations(object, elements, sets)
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
            validObject(object)
            object
          }
)
