#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn incidence Incidence of the TidySet
#' @aliases incidence
#' @return A matrix with elements in rows and sets in columns where the values
#' indicate the relationship between the element and the set.
#' @export
#' @examples
#' x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
#' a <- tidySet(x)
#' incidence(a)
setMethod("incidence",
    signature = signature(object = "TidySet"),
    function(object) {
        Incidence <- matrix(0,
            nrow = nElements(object),
            ncol = nSets(object),
            dimnames = list(
                elements(object)$element,
                sets(object)$set
            )
        )
        rel <- unique(relations(object)[, c("sets", "elements", "fuzzy")])
        elements <- as.character(rel$elements)
        sets <- as.character(rel$sets)

        fuzziness <- rel$fuzzy
        for (p in seq_along(rel$fuzzy)) {
            Incidence[elements[p], sets[p]] <- fuzziness[p]
        }
        Incidence
    }
)
