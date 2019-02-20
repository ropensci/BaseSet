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
                                set1 = "characterORfactor",
                                set2 = "characterORfactor",
                                setName = "characterORfactor"),
          function(object, set1, set2, setName, FUN = "max", keep = FALSE) {
            sets <- c(set1, set2)
            if (length(set1) != length(setName)) {
              stop("New names must be of the same length as the pairs of ",
                   "set to unite", call. = FALSE)
            }
            new_object <- rename_set(object, sets, setName)
            if (!keep) {
              old_sets <- name_sets(object)
              remove_sets <- old_sets[!old_sets %in% setName]
              new_object <- remove_sets(new_object, remove_sets)
              new_object <- rm_relations_with_sets(new_object, remove_sets)
              new_object <- remove_elements(new_object, object %e-e% new_object)
            } else {
              new_object <- merge_tidySets(object, new_object)
            }
            new_object <- fapply(new_object, FUN)
            new_object
          }
)
