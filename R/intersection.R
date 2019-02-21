#' @include AllClasses.R AllGenerics.R operations.R
NULL

#' @describeIn intersection Applies the standard intersection
#' @export
setMethod("intersection",
          signature = signature(object = "TidySet",
                                sets = "character",
                                name = "character"),
          function(object, sets, name, FUN = "min", keep = FALSE,
                   keep_relations = keep,
                   keep_elements = keep,
                   keep_sets = keep) {
            if (length(name) > 1) {
              stop("The name of the new set must be of length 1", call. = FALSE)
            }

            old_relations <- relations(object)
            relevant_relations <- old_relations$sets %in% sets
            intersection <- old_relations[relevant_relations, , drop = FALSE]
            intersection <- droplevels(intersection)
            intersection$sets <- as.character(intersection$sets)
            logical <- intersection$sets %in% sets
            intersection$sets <- ifelse(logical, name, intersection$sets)

            relations <- paste(intersection$elements, intersection$sets)

            dup_relations <- relations[duplicated(relations)]

            intersection <- intersection[dup_relations %in% relations, ,
                                         drop = FALSE]

            object <- replace_interactions(object, intersection, keep)
            object <- fapply(object, FUN)
            object <- add_sets(object, name)

            if (!keep_elements) {
              drop_elements(object)
            }
            if (!keep_sets) {
              drop_sets(object)
            }
            validObject(object)
            object
          }
)
