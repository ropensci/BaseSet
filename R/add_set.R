#' @include AllClasses.R
NULL

#' @describeIn add_set Adds a set
#' @export
setMethod("add_set",
          signature = signature(object = "TidySet",
                                elements = "character",
                                setName = "character"),
          function(object, elements, setName, fuzzy = 1) {
            if (length(setName) != 1) {
              stop("The new set should have one name")
            }
            if (!is.numeric(fuzzy)) {
              stop("fuzzy should be numeric between 0 and 1")
            }
            object <- add_sets(object, setName)
            object <- add_elements(object, elements)
            object <- add_relations(object,
                                    elements = elements,
                                    sets = setName,
                                    fuzzy = fuzzy)
            validObject(object)
            object
          }
)
