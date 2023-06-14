
#' Adjacency
#'
#' Are two elements connected ?
#' @param object A TidySet object
#' @return A square matrix, 1 if two nodes are connected, 0 otherwise.
#' @export
#' @method adjacency TidySet
#' @seealso [incidence()]
#' @examples
#' x <- list("SET1" = letters[1:5], "SET2" = LETTERS[3:7])
#' a <- tidySet(x)
#' adjacency_element(a)
#' adjacency_set(a)
adjacency <- function(object) {
    UseMethod("adjacency")
}

#' @rdname adjacency
#' @export
adjacency_element <- function(object) {
    UseMethod("adjacency_element")
}

#' @rdname adjacency
#' @export
adjacency_set <- function(object) {
    UseMethod("adjacency_set")
}

#' @rdname adjacency
#' @export
#' @method adjacency TidySet
adjacency.TidySet <- function(object) {
    activated <- active(object)
    if (is.null(activated)) {
        warning(
            "You must especify on what do you want the adjacency?",
            "\n\tYou might need activate() or adjacency_*"
        )
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
