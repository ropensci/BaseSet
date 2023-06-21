# Allow to merge TidySets
#' @export
setMethod("c", "TidySet",
          function(x, ...) {
            dc <- lapply(list(x, ...), as.data.frame)
            m <- function(x, y) {
              merge(x, y, all = TRUE, sort = FALSE)
            }
            r <- Reduce(m, dc)
            tidySet(r)
          })
