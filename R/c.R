# Allow to merge TidySets
#' Combine Values into a Vector or List
#'
#' This method combines TidySets.
#' It only works if the first element is a TidySet.
#' @param x A TidySet object.
#' @param ... Objects to be concatenated. All NULL entries are dropped.
#' @export
#' @examples
#' TS <- tidySet(list(A = letters[1:5], B = letters[6]))
#' TS2 <- c(TS, data.frame(sets = "C", elements = "gg"))
setMethod("c", "TidySet",
          function(x, ...) {
              l <- list(x, ...)
              null <- vapply(l, is.null, FUN.VALUE = logical(1))

              dc <- lapply(l[!null], function(x){
                  as.data.frame(tidySet(x))
              })
              # browser()
              m <- function(x, y) {
                  merge(x, y, all = TRUE, sort = FALSE)
              }
              r <- Reduce(m, dc)

              missing_fuzzy <- is.na(r$fuzzy)
              if (any(missing_fuzzy)) {
                  new_sets <- r$sets[missing_fuzzy]
                  new_elements <- r$elements[missing_fuzzy]
                  if (all(is.na(new_sets)) && all(is.na(new_elements))) {
                      warning("Some data might be lost.")
                  }
                  TS <- tidySet(r[!missing_fuzzy, , drop = FALSE])
                  TS <- add_sets_internal(TS, new_sets)
                  TS <- add_elements_internal(TS, new_elements)
                  validObject(TS)
                  return(TS)
              }
              tidySet(r)
          })
