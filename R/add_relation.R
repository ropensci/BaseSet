#' @include AllClasses.R
NULL

#' @describeIn add_relation Adds relations
#' @export
setMethod("add_relation",
          signature = signature(object = "TidySet",
                                relations = "data.frame"),
          function(object, relations) {

            fuzzyness <- "fuzzy" %in% colnames(relations)
            object <- add_sets(object, relations$sets)
            object <- add_elements(object, relations$elements)
            object <- add_relations(object,
                                    elements = relations$elements,
                                    sets = relations$sets,
                                    fuzzy = ifelse(fuzzyness,
                                                   relations$fuzzy, 1))

            validObject(object)
            object
          }
)

