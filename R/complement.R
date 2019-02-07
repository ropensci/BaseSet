#' @include AllClasses.R AllGenerics.R
NULL


#' @describeIn complement_set Complement of the sets.
#' @export
setMethod("complement_set",
          signature = signature(object = "TidySet",
                                sets = "character"),
          function(object, sets) {
            old_object <- object
            new_object <- complement_sets(old_object, sets)
            old_sets <- name_sets(old_object)
            remove_sets <- old_sets[!old_sets %in% name_sets(new_object)]
            remove_set(object, remove_sets)
          }
)
