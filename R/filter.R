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
  original_sets <- name_sets(.data)
  out <- filter(sets, ...)
  remove_sets <- original_sets[!original_sets %in% out$sets]
  object <- remove_set(.data, remove_sets)
  validObject(object)
  object
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
  original_elements <- name_elements(.data)
  remaining_elements <- as.character(out$elements)
  keep <- original_elements %in% remaining_elements
  remove_elements <- original_elements[!keep]
  object <- remove_element(.data, remove_elements)
  validObject(object)
  object
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

  object <- remove_relation(.data, remove_elements, remove_sets)
  validObject(object)
  object
}

