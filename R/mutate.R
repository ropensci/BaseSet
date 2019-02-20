#' @importFrom dplyr mutate
NULL

#' Mutate
#'
#' Use mutate to alter the TidySet object. You can use activate with mutate or
#' use the specific function. The S3 method filters using all the information
#' on the TidySet.
#' @param .data The TidySet object
#' @param ... The logical predicates in terms of the variables of the sets
#' @return A TidySet object
#' @export
#' @seealso \code{\link[dplyr]{filter}} and \code{\link{activate}}
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
#'                         elements = rep(letters[seq_len(6)], 2),
#'                         fuzzy = runif(12))
#' a <- tidySet(relations)
#' mutate_element(a, Type = c(rep("Gene", 4), rep("lncRNA", 2)))
mutate <- function(.data, ...) {
  UseMethod("mutate")
}

#' @export
mutate.TidySet <- function(.data, ...) {
  if (is.null(active(.data))) {
  stop("Must indicate what do you want to modify.\n",
         "Perhaps you missed activate?")
  } else {
    switch(
      active(.data),
      elements = mutate_element(.data, ...),
      sets = mutate_set(.data, ...),
      relations = mutate_relation(.data, ...)
    )
  }
}

#' @rdname mutate
#' @export
mutate_set <- function(.data, ...) {
  UseMethod("mutate_set")
}

#' @rdname mutate
#' @export
mutate_element <- function(.data, ...) {
  UseMethod("mutate_element")
}

#' @rdname mutate
#' @export
mutate_relation <- function(.data, ...) {
  UseMethod("mutate_relation")
}

#' @export
#' @method mutate_element TidySet
mutate_element.TidySet <- function(.data, ...) {
  elements <- elements(.data)
  out <- dplyr::mutate(elements, !!!enquos(...))
  elements(.data) <- out
  .data
}
#' @export
#' @method mutate_set TidySet
mutate_set.TidySet <- function(.data, ...) {
  sets <- sets(.data)
  out <- dplyr::mutate(sets, !!!enquos(...))
  sets(.data) <- out
  .data
}


#' @export
#' @method mutate_relation TidySet
mutate_relation.TidySet <- function(.data, ...) {
  relations <- relations(.data)
  out <- dplyr::mutate(relations, !!!enquos(...))
  relations(.data) <- out
  .data
}
