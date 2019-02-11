#' @include AllClasses.R AllGenerics.R
NULL


#' Filter by set
#' @export
filter_set <- function(.data, ...) {
  UseMethod("filter_set")
}

#' @export
#' @method filter_set TidySet
#' @importFrom dplyr filter
filter_set.TidySet <- function(.data, ...) {
  sets <- sets(.data)
  out <- filter(sets, ...)
  remove_sets <- as.character(out$sets[out$sets %in% name_sets(.data)])
  remove_set(.data, remove_sets)
}

#' Filter by element
#' @export
filter_element <- function(.data, ...) {
  UseMethod("filter_element")
}

#' @export
#' @method filter_element TidySet
#' @importFrom dplyr filter
filter_element.TidySet <- function(.data, ...) {
  elements <- elements(.data)
  out <- filter(elements, ...)
  remaining_elements <- as.character(out$elements)
  keep <- remaining_elements %in% name_sets(.data)
  remove_elements <- remaining_elements[keep]
  remove_element(.data, remove_elements)
}

#' Filter by relation
#' @export
filter_relation <- function(.data, ...) {
  UseMethod("filter_relation")
}

#' @export
#' @method filter_relation TidySet
#' @importFrom dplyr filter
filter_relation.TidySet <- function(.data, ...) {
  relations <- relations(.data)
  out <- filter(relations, ...)

  remaining_elements <- as.character(out$elements)
  remaining_sets <- as.character(out$sets)

  keep_elements <- remaining_elements %in% name_elements(.data)
  keep_sets <- remaining_sets %in% name_sets(.data)

  remove_elements <- remaining_elements[keep_elements]
  remove_sets <- remaining_sets[keep_sets]

  remove_relation(.data, remove_elements, remove_sets)
}

