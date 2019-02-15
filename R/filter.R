#' @include AllClasses.R AllGenerics.R
#' @importFrom rlang !!!
#' @importFrom rlang enquos
#' @importFrom dplyr filter
NULL


#' Filter by set
#' @export
filter_set <- function(.data, ...) {
  UseMethod("filter_set")
}

#' @export
filter_set.TidySet <- function(.data, ...) {
  sets <- sets(.data)
  original_sets <- name_sets(.data)
  out <- filter(sets, !!!enquos(...))

  remove_sets <- setdiff(original_sets, out$sets)
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
filter_element.TidySet <- function(.data, ...) {
  elements <- elements(.data)
  out <- filter(elements, !!!enquos(...))

  original_elements <- name_elements(.data)

  remove_elements <- setdiff(original_elements, out$elements)

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
filter_relation.TidySet <- function(.data, ...) {

  relations <- relations(.data)
  out <- filter(relations, !!!enquos(...))

  original_elements <- as.character(relations$elements)
  original_sets <- as.character(relations$sets)

  remove_elements <- original_elements[!original_elements %in% out$elements]
  remove_sets <- original_sets[!original_sets %in% out$sets]

  object <- remove_relation(.data, remove_elements, remove_sets)
  validObject(object)
  object
}

