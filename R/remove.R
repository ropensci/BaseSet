#' @include AllGenerics.R
NULL

#' @describeIn remove_relation Removes a relation between elements and sets.
#' @export
setMethod("remove_relation",
    signature = signature(
        object = "TidySet",
        elements = "characterORfactor",
        sets = "characterORfactor"
    ),
    function(object, elements, sets) {
        new_object <- remove_relations(object, elements, sets)
        new_object <- remove_sets(new_object, object %s-s% new_object)
        new_object <- remove_elements(new_object, object %e-e% new_object)
        validObject(new_object)
        new_object
    }
)

#' @describeIn remove_element Removes everything related to an element
#' @export
setMethod("remove_element",
    signature = signature(
        object = "TidySet",
        elements = "characterORfactor"
    ),
    function(object, elements) {
        new_object <- remove_elements(object, elements)
        new_object <- rm_relations_with_elements(new_object, elements)
        new_object <- remove_sets(new_object, object %s-s% new_object)
        validObject(new_object)
        new_object
    }
)

#' @describeIn remove_set Removes everything related to a set
#' @export
setMethod("remove_set",
    signature = signature(
        object = "TidySet",
        sets = "characterORfactor"
    ),
    function(object, sets) {
        new_object <- rm_relations_with_sets(object, sets)
        new_object <- remove_elements(new_object, object %e-e% new_object)
        new_object <- remove_sets(new_object, sets)
        validObject(new_object)
        new_object
    }
)
