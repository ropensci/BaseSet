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
