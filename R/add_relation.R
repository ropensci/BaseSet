#' @include AllClasses.R
NULL

#' @describeIn add_relation Adds relations
#' @export
setMethod("add_relation",
    signature = signature(
        object = "TidySet",
        relations = "data.frame"
    ),
    function(object, relations) {
        relations_columns <- colnames(relations)
        non_fuzzyness <- check_colnames(relations_columns, "fuzzy")
        if (non_fuzzyness) {
            relations <- cbind(relations, fuzzy = 1)
        }
        valid <- check_colnames(
            colnames(relations),
            c("elements", "sets")
        )
        if (valid) {
            stop("Relations must have elements and sets columns.")
        }

        object <- add_sets(object, as.character(relations$sets))
        object <- add_elements(object, as.character(relations$elements))
        new_r <- merge(object@relations, relations,
            all = TRUE, sort = FALSE,
            suffixes = c(".old", ".new")
        )
        object@relations <- new_r
        validObject(object)
        object
    }
)
