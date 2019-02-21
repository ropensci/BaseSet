#' @include AllClasses.R AllGenerics.R operations.R
NULL

# To avoid conflicts with the dplyr package
#' @export
#' @method union TidySet
union.TidySet <- function(...) {
  # Check if first argument is a TidySet
  if (is(..1, "TidySet")) {
    union(...)
  } else {
    NextMethod()
  }
}

#' @describeIn union Applies the standard union
#' @export
setMethod("union",
          signature = signature(object = "TidySet",
                                sets = "characterORfactor",
                                name = "characterORfactor"),
          function(object, sets, name, FUN = "max", keep = FALSE,
                   keep_relations = keep,
                   keep_elements = keep,
                   keep_sets = keep) {
            if (length(name) != 1) {
              stop("The new union can only have one name", call. = FALSE)
            }

            new_object <- rename_set(object, sets, name)
            if (!keep_relations) {
              old_sets <- name_sets(object)
              remove_sets <- old_sets[!old_sets %in% name]
              new_object <- remove_sets(new_object, remove_sets)
              new_object <- rm_relations_with_sets(new_object, remove_sets)
              new_object <- remove_elements(new_object, object %e-e% new_object)
            } else {
              new_object <- merge_tidySets(object, new_object)
            }
            new_object <- fapply(new_object, FUN)

            if (!keep_sets) {
              new_object <- drop_sets(new_object)
            }
            if (!keep_elements) {
              new_object <- drop_elements(new_object)
            }
            validObject(new_object)
            new_object
          }
)
