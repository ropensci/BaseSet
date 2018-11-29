#' Create a set
#'
#' @param elements Elements of the set
#' @return An object of class Set
#' @include AllClasses.R
#' @importFrom methods new
#' @export
#' @examples
#' set(c("a", "b"))
set <- function(elements) {
  methods::new("Set", elements = elements)
}
