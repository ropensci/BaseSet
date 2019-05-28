
#' @importFrom utils head
#' @export
#' @method head TidySet
head.TidySet <- function(x, n = 6L, ...) {
    head(as(x, "data.frame"), n = n)
}

#' @importFrom utils tail
#' @export
#' @method tail TidySet
tail.TidySet <- function(x, n = 6L, ...) {
    tail(as(x, "data.frame"), n = n)
}

#' @importFrom base dim
#' @export
#' @method base TidySet
dim.TidySet <- function(x) {
    c(nElements(x), nRelations(x), nSets(x))
}
