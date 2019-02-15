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
  out <- filter(sets, !!!enquos(...))
  original_sets <- name_sets(.data)

  if (nrow(out) == 0) {
    sets(.data) <- out[0, , drop = FALSE]
  }

  remove_sets <- setdiff(original_sets, out$sets)
  remove_set(.data, remove_sets)
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

  if (nrow(out) == 0) {
    elements(.data) <- out[0, , drop = FALSE]
  }
  remove_elements <- setdiff(original_elements, out$elements)
  remove_element(.data, remove_elements)
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

  if (nrow(out) == 0) {
    relations(.data) <- out[0, , drop = FALSE]
  }

  original_elements <- as.character(relations$elements)
  original_sets <- as.character(relations$sets)

  remove_elements <- original_elements[!original_elements %in% out$elements]
  remove_sets <- original_sets[!original_sets %in% out$sets]

  .data <- remove_relation(.data, remove_elements, remove_sets)
  validate(.data)
}

