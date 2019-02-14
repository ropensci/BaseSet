#' @include AllClasses.R AllGenerics.R
NULL


#' @describeIn complement_set Complement of the sets.
#' @export
setMethod("complement_set",
          signature = signature(object = "TidySet",
                                sets = "character"),
          function(object, sets) {
            all_sets <- name_sets(object)
            remove_sets <- all_sets[all_sets %in% sets]
            remove_set(object, remove_sets)
          }
)

#' @describeIn complement_element Complement of the sets.
#' @export
setMethod("complement_element",
          signature = signature(object = "TidySet",
                                elements = "character"),
          function(object, elements) {
            all_elements <- name_elements(object)
            remove_elements <- all_elements[all_elements %in% elements]
            remove_element(object, remove_elements)
          }
)
