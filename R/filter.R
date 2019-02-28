#' @include AllClasses.R AllGenerics.R
#' @importFrom dplyr filter
#' @export
dplyr::filter


#' Filter TidySet
#'
#' Use filter to subset the TidySet object. You can use activate with filter or
#' use the specific function. The S3 method filters using all the information
#' on the TidySet.
#' @param .data The TidySet object
#' @param ... The logical predicates in terms of the variables of the sets
#' @return A TidySet object
#' @export
#' @seealso dplyr \code{\link[dplyr]{filter}} and \code{\link{activate}}
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
#'                         elements = rep(letters[seq_len(6)], 2),
#'                         fuzzy = runif(12))
#' a <- tidySet(relations)
#' elements(a) <- cbind(elements(a),
#'                  type = c(rep("Gene", 4), rep("lncRNA", 2)))
#' filter(a, elements == "a")
#' # Equivalent to filter_relation
#' filter(a, elements == "a", sets == "a")
#' filter_relation(a, elements == "a", sets == "a")
#' # Filter element
#' filter_element(a, type == "Gene")
#' # Filter sets and by property of elements simultaneously
#' filter(a, sets == "b", type == "lncRNA")
#' # Filter sets
#' filter_set(a, sets == "b")
#' @rdname filter_
#' @export
#' @method filter TidySet
filter.TidySet <- function(.data, ...) {
  if (is.null(active(.data))) {
    df <- dplyr::filter(as.data.frame(.data), ...)
    df2TS(.data, df)
  } else {
    switch(
      active(.data),
      elements = filter_element(.data, ...),
      sets = filter_set(.data, ...),
      relations = filter_relation(.data, ...)
    )
  }
}

#' @rdname filter_
#' @export
filter_set <- function(.data, ...) {
  UseMethod("filter_set")
}

#' @rdname filter_
#' @export
filter_element <- function(.data, ...) {
  UseMethod("filter_element")
}

#' @rdname filter_
#' @export
filter_relation <- function(.data, ...) {
  UseMethod("filter_relation")
}


#' @export
#' @method filter_set TidySet
filter_set.TidySet <- function(.data, ...) {
  sets <- sets(.data)
  out <- dplyr::filter(sets, ...)
  original_sets <- name_sets(.data)

  if (nrow(out) == 0) {
    sets(.data) <- out[0, , drop = FALSE]
  }

  remove_sets <- setdiff(original_sets, out$sets)
  remove_set(.data, remove_sets)
}

#' @export
#' @method filter_element TidySet
filter_element.TidySet <- function(.data, ...) {
  elements <- elements(.data)
  out <- dplyr::filter(elements, ...)
  original_elements <- name_elements(.data)

  if (nrow(out) == 0) {
    elements(.data) <- out[0, , drop = FALSE]
  }
  remove_elements <- setdiff(original_elements, out$elements)
  remove_element(.data, remove_elements)
}

#' @export
#' @method filter_relation TidySet
filter_relation.TidySet <- function(.data, ...) {

  relations <- relations(.data)
  out <- dplyr::filter(relations, ...)

  if (nrow(out) == 0) {
    relations(.data) <- out[0, , drop = FALSE]
  }

  original_elements <- as.character(relations$elements)
  original_sets <- as.character(relations$sets)

  remove_elements <- original_elements[!original_elements %in% out$elements]
  .data <- remove_element(.data, remove_elements)
  remove_sets <- original_sets[!original_sets %in% out$sets]
  remove_set(.data, remove_sets)
}

