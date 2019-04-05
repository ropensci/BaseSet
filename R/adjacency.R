
#' Adjacency
#'
#' Are two elements connected ?
#' @param object A TidySet object
#' @return A square matrix, 1 if two nodes are connected, 0 otherwise.
#' @export
#' @method adjacency TidySet
#' @seealso \code{\link{incidence}}
#' @examples
#' x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
#' a <- tidySet(x)
#' incidence(a)
adjacency <- function(object) {
    UseMethod("adjacency")
}

#' @export
adjacency_element <- function(object) {
    UseMethod("adjacency_element")
}

#' @export
adjacency_set <- function(object) {
    UseMethod("adjacency_set")
}

#' @export
#' @method adjacency TidySet
adjacency.TidySet <- function(object) {
    activated <- active(object)
    if (is.null(activated)) {
        NULL
    } else if (activated == "elements") {
        adjacency_element(object)
    } else if (activated == "sets") {
        adjacency_set(object)
        }
}

#' @export
#' @method adjacency_element TidySet
adjacency_element.TidySet <- function(object) {
    adj <- tcrossprod(incidence(object))
    adj[adj != 0] <- 1
    adj
}

#' @export
#' @method adjacency_set TidySet
adjacency_set.TidySet <- function(object) {
    adj <- crossprod(incidence(object))
    adj[adj != 0] <- 1
    adj
}
