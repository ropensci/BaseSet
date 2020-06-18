#' @include AllClasses.R AllGenerics.R
#' @importFrom dplyr pull
#' @importFrom rlang !!
#' @export
dplyr::pull

#' Pull from a TidySet
#'
#' Use pull to extract the columns of a TidySet object. You can use activate
#' with filter or use the specific function. The S3 method filters using all
#' the information on the TidySet.
#' @param .data The TidySet object
#' @param var The literal variable name, a positive integer or a negative
#' integer column position.
#' @return A TidySet object
#' @export
#' @seealso dplyr \code{\link[dplyr]{pull}} and \code{\link{activate}}
#' @family methods
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
#'                         elements = rep(letters[seq_len(6)], 2),
#'                         fuzzy = runif(12))
#' a <- tidySet(relations)
#' a <- mutate_element(a, type = c(rep("Gene", 4), rep("lncRNA", 2)))
#' pull(a, type)
#' # Equivalent to pull_relation
#' b <- activate(a, "relations")
#' pull_relation(b, elements)
#' pull_element(b, elements)
#' # Filter element
#' pull_element(a, type)
#' # Filter sets
#' pull_set(a, sets)
#' @rdname pull_
#' @export
#' @method pull TidySet
pull.TidySet <- function(.data, var = -1) {
  if (is.null(active(.data))) {
    dplyr::pull(as.data.frame(.data), !!enquo(var))
  } else {
    switch(
      active(.data),
      elements = pull_element(.data, var),
      sets = pull_set(.data, var),
      relations = pull_relation(.data, var)
    )
  }
}

#' @rdname pull_
#' @export
pull_set <- function(.data, var) {
  UseMethod("pull_set")
}

#' @rdname pull_
#' @export
pull_element <- function(.data, var) {
  UseMethod("pull_element")
}

#' @rdname pull_
#' @export
pull_relation <- function(.data, var) {
  UseMethod("pull_relation")
}

#' @export
#' @method pull_set TidySet
pull_set.TidySet <- function(.data, var) {
  sets <- sets(.data)
  dplyr::pull(sets, !!enquo(var))
}

#' @export
#' @method pull_element TidySet
pull_element.TidySet <- function(.data, var) {
  elements <- elements(.data)
  dplyr::pull(elements, !!enquo(var))
}

#' @export
#' @method pull_relation TidySet
pull_relation.TidySet <- function(.data, var) {

  relations <- relations(.data)
  dplyr::pull(relations, !!enquo(var))
}
