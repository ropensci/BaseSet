#' @include AllClasses.R AllGenerics.R
NULL

#' Determine the context of subsequent manipulations
#' @export
#'
activate <- function(.data, what) {
  UseMethod('activate')
}

#' @export
#' @importFrom rlang enquo quo_text
activate.TidySet <- function(.data, what) {
  active(.data) <- quo_text(enquo(what))
  .data
}

#' @rdname activate
#' @export
active <- function(x) {
  attr(x, 'active')
}

`active<-` <- function(x, value) {
  value <- gsub('"', '', value)
  value <- switch(
    value,
    element = ,
    elements = 'elements',
    set = ,
    sets = 'sets',
    relation = ,
    relations = 'relations',
    stop('Only possible to activate elements, sets and relations', call. = FALSE)
  )
  attr(x, 'active') <- value
  x
}
