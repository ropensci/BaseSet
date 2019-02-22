#' @include AllClasses.R
NULL

#' @describeIn add_set Adds a set
#' @export
setMethod("add_set",
          signature = signature(object = "TidySet",
                                elements = "characterORfactor",
                                name = "characterORfactor",
                                fuzzy = "numeric"),
          function(object, elements, name, fuzzy = 1) {
            if (length(name) != 1) {
              stop("The new set should have one name", call. = FALSE)
            }
            if (any(fuzzy < 0) || any(fuzzy > 1)) {
              stop("fuzzy should be numeric between 0 and 1", call. = FALSE)
            }
            object <- add_sets(object, name)
            object <- add_elements(object, elements)
            object <- add_relations(object,
                                    elements = elements,
                                    sets = name,
                                    fuzzy = fuzzy)
            validObject(object)
            object
          }
)

#' @describeIn add_set Adds a set
#' @export
setMethod("add_set",
          signature = signature(object = "TidySet",
                                elements = "characterORfactor",
                                name = "characterORfactor",
                                fuzzy = "missing"),
          function(object, elements, name) {
            if (length(name) != 1) {
              stop("The new set should have one name", call. = FALSE)
            }

            object <- add_sets(object, name)
            object <- add_elements(object, elements)
            object <- add_relations(object,
                                    elements = elements,
                                    sets = name,
                                    fuzzy = 1)
            validObject(object)
            object
          }
)
