#' @include AllClasses.R AllGenerics.R operations.R
NULL

#' @describeIn intersection Applies the standard intersection
#' @export
setMethod("intersection",
          signature = signature(object = "TidySet",
                                set1 = "character",
                                set2 = "character",
                                setName = "character"),
          function(object, set1, set2, setName, FUN = "min", keep = FALSE) {

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

              remove_elements <- object %e-e% new_object
              new_elements <- as.character(new_object@relations$elements)
              duplicated <- new_elements[duplicated(new_elements)]
              remove_too <- setdiff(new_elements, duplicated)
              remove_elements <- c(remove_elements, remove_too)

              new_object <- remove_elements(new_object, remove_elements)
              new_object <- rm_relations_with_elements(new_object,
                                                       remove_elements)
            } else {
              new_object <- merge_tidySets(object, new_object)
            }

            new_object <- fapply(new_object, FUN)
            new_object
          }
)
