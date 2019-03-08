#' @include AllClasses.R AllGenerics.R
#' @importFrom dplyr arrange
#' @importFrom rlang !!
#' @export
dplyr::arrange


#' arrange from a TidySet
#'
#' Use arrange to extract the columns of a TidySet object. You can use activate with filter or
#' use the specific function. The S3 method filters using all the information
#' on the TidySet.
#' @param .data The TidySet object
#' @param ... Comma separated list of variables names or expressions
#' integer column position.
#' @return A TidySet object
#' @export
#' @seealso dplyr \code{\link[dplyr]{arrange}} and \code{\link{activate}}
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
#'                         elements = rep(letters[seq_len(6)], 2),
#'                         fuzzy = runif(12))
#' a <- tidySet(relations)
#' elements(a) <- cbind(elements(a),
#'                  type = c(rep("Gene", 4), rep("lncRNA", 2)))
#'
#' b <- arrange(a, desc(type))
#' elements(b)
#' b <- arrange_element(a, elements)
#' elements(b)
#' # Arrange sets
#' arrange_set(a, sets)
#' @rdname arrange_
#' @export
#' @method arrange TidySet
arrange.TidySet <- function(.data, ...) {
  if (is.null(active(.data))) {
    out <- dplyr::arrange(as.data.frame(.data), ...)
    df2TS(df = out)
  } else {
    switch(
      active(.data),
      elements = arrange_element(.data, ...),
      sets = arrange_set(.data, ...),
      relations = arrange_relation(.data, ...)
    )
  }
}

#' @rdname arrange_
#' @export
arrange_set <- function(.data, ...) {
  UseMethod("arrange_set")
}

#' @rdname arrange_
#' @export
arrange_element <- function(.data, ...) {
  UseMethod("arrange_element")
}

#' @rdname arrange_
#' @export
arrange_relation <- function(.data, ...) {
  UseMethod("arrange_relation")
}


#' @export
#' @method arrange_set TidySet
arrange_set.TidySet <- function(.data, ...) {
  sets <- sets(.data)
  out <- dplyr::arrange(sets, ...)
  .data@sets <- out
  validObject(.data)
  .data
}

#' @export
#' @method arrange_element TidySet
arrange_element.TidySet <- function(.data, ...) {
  elements <- elements(.data)
  out <- dplyr::arrange(elements, ...)
  .data@elements <- out
  validObject(.data)
  .data
}

#' @export
#' @method arrange_relation TidySet
arrange_relation.TidySet <- function(.data, ...) {
  relations <- relations(.data)
  out <- dplyr::arrange(relations, ...)
  .data@relations <- out
  validObject(.data)
  .data
}


