#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn incidence Incidence of the TidySet
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
                                dimnames = list(elements(object)$element,
                                                sets(object)$set))

            elements <- as.character(object@relations$elements)
            sets <- as.character(object@relations$sets)

            fuzziness <- object@relations$fuzzy
            for (p in seq_len(nRelations(object))) {
              Incidence[elements[p], sets[p]] <- fuzziness[p]
            }
            Incidence
          })
