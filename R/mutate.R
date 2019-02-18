#' @importFrom dplyr mutate
NULL

#' Mutate by set
#' @export
mutate_set <- function(.data, ...) {
  UseMethod("mutate_set")
}

#' @export
mutate_set.TidySet <- function(.data, ...) {
  sets <- sets(.data)
  out <- mutate(sets, !!!enquos(...))
  sets(.data) <- out
  .data
}

#' Mutate by element
#' @export
mutate_element <- function(.data, ...) {
  UseMethod("mutate_element")
}

#' @export
#' @method mutate_element TidySet
mutate_element.TidySet <- function(.data, ...) {
  elements <- elements(.data)
  out <- mutate(elements, !!!enquos(...))
  elements(.data) <- out
  .data
}

#' Mutate by relation
#' @export
mutate_relation <- function(.data, ...) {
  UseMethod("mutate_relation")
}

#' @export
#' @method mutate_relation TidySet
mutate_relation.TidySet <- function(.data, ...) {

  relations <- relations(.data)
  out <- mutate(relations, !!!enquos(...))
  relations(.data) <- out
  .data
}
