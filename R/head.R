
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

#' @export
#' @method dim TidySet
dim.TidySet <- function(x) {
    c(nElements(x), nRelations(x), nSets(x))
}

#' @export
sample <- function(x, size, replace = FALSE, prob = NULL) {
    UseMethod("sample")
}

#' @export
sample.default <- base::sample

#' @export
#' @method sample TidySet
sample.TidySet <- function(x, size, replace = FALSE, prob = NULL) {
    if (!is.numeric(size) | (size > nRelations(x) & !replace)) {
        stop("cannot take a sample larger than the number of ",
             "relations when replace  = FALSE")
    }
    relations <- relations(x)
    y <- seq_len(nrow(relations))
    out <- sample(y, size, replace, prob)

    tidySet(relations[out, ])
}
