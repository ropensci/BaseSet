#' @include AllClasses.R AllGenerics.R
NULL


#' @describeIn complement_set Complement of the sets.
#' @export
setMethod("complement_set",
          signature = signature(object = "TidySet",
                                sets = "characterORfactor"),
          function(object, sets, name = NULL, keep = TRUE,
                   keep_relations = keep,
                   keep_elements = keep,
                   keep_sets = keep) {

            if (!is.logical(keep)) {
              stop("keep must be a logical value.", call. = FALSE)
            }

            old_relations <- relations(object)
            involved_relations <- old_relations$sets %in% sets
            # Elements present on sets
            complement <- old_relations[involved_relations, , drop = FALSE]
            complement$fuzzy <- 1 - complement$fuzzy

            if (is.null(name)) {
              name <- naming("complement", sets)
            }

            object <- add_sets(object, name)
            complement$sets <- name

            object <- replace_interactions(object, complement, keep_relations)

            object <- droplevels(object, !keep_elements, !keep_sets)
            validObject(object)
            object
          }
)



#' @describeIn complement_element Complement of the elements.
#' @export
setMethod("complement_element",
          signature = signature(object = "TidySet",
                                elements = "characterORfactor"),
          function(object, elements, name, keep = TRUE,
                   keep_relations = keep,
                   keep_elements = keep,
                   keep_sets = keep) {

            if (!is.logical(keep)) {
              stop("keep must be a logical value.", call. = FALSE)
            }
            old_relations <- relations(object)
            complement <- old_relations[old_relations$elements %in% elements, ,
                                        drop = FALSE]
            complement$fuzzy <- 1 - complement$fuzzy


            complement$sets <- name
            complement <- complement[complement$fuzzy != 0, , drop = FALSE]

            object <- replace_interactions(object, complement, keep_relations)
            object <- add_sets(object, name)
            object <- droplevels(object, !keep_elements, !keep_sets)
            validObject(object)
            object
          }
)
