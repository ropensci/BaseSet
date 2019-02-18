#' @include AllClasses.R AllGenerics.R
NULL

#' Determine the context of subsequent manipulations
#' @export
deactivate <- function(.data) {
  UseMethod('deactivate')
}

#' @export
deactivate.TidySet <- function(.data) {
  active(.data) <- NULL
  .data
}
