#' @include AllClasses.R AllGenerics.R
NULL

#' @rdname activate
#' @export
deactivate <- function(.data) {
    UseMethod("deactivate")
}

#' @export
deactivate.TidySet <- function(.data) {
    active(.data) <- NULL
    .data
}
