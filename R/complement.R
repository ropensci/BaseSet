#' @include AllClasses.R AllGenerics.R
NULL


#' @describeIn complement_set Complement of the sets.
#' @export
setMethod("complement_set",
          signature = signature(object = "TidySet",
                                sets = "characterORfactor"),
          function(object, sets) {
            remove_elements <- elements_in_set(object, sets)
            new_object <- rm_relations_with_sets(object, sets)
            new_object <- rm_relations_with_elements(object, remove_elements)
            new_object <- remove_elements(new_object, remove_elements)
            new_object <- remove_sets(new_object, sets)
            validObject(new_object)
            new_object
          }
)

#' @describeIn complement_element Complement of the elements.
#' @export
setMethod("complement_element",
          signature = signature(object = "TidySet",
                                elements = "characterORfactor"),
          function(object, elements) {
            all_elements <- name_elements(object)
            remove_sets <- sets_for_elements(object, elements)
            remove_elements <- all_elements[all_elements %in% elements]
            new_object <- remove_elements(object, remove_elements)
            new_object <- rm_relations_with_elements(new_object, elements)
            new_object <- rm_relations_with_sets(new_object, remove_sets)
            new_object <- remove_sets(new_object, object %s-s% new_object)
            validObject(new_object)
            new_object
          }
)
