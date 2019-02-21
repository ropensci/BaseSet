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

            if (!is.character(name) & !is.null(name)) {
              stop("name must be a character for the new set", call. = FALSE)
            }

            if (!is.logical(keep)) {
              stop("keep must be a logical value.", call. = FALSE)
            }

            old_relations <- relations(object)
            complement <- old_relations[old_relations$sets %in% sets, ,
                                        drop = FALSE]
            complement$fuzzy <- 1 - complement$fuzzy

            if (is.null(name)) {
              name_set <- paste0(set_symbols["complement"],
                                 "_",
                                 paste(sets, collapse = set_symbols["union"]))
            } else {
              name_set <- name
            }

            complement$sets <- name_set
            complement <- complement[complement$fuzzy != 0, , drop = FALSE]

            object <- replace_interactions(object, complement, keep_relations)
            object <- add_sets(object, name_set)

            if (!keep_sets) {
              object <- drop_sets(object)
            }
            if (!keep_elements) {
              object <- drop_elements(object)
            }
            validObject(object)
            object
          }
)



#' @describeIn complement_element Complement of the elements.
#' @export
setMethod("complement_element",
          signature = signature(object = "TidySet",
                                elements = "characterORfactor",
                                name = "character"),
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

            object <- replace_interactions(object, complement, keep)
            object <- add_sets(object, name)
            validObject(object)
            object
          }
)
