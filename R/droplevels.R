#' Drop unused elements and sets
#'
#' Drop elements and sets without any relation.
#' @param x A TidySet object.
#' @param elements Logical value: Should elements be droped?
#' @param sets Logical value: Should sets be droped?
#' @param ... Other arguments, currently ignored.
#' @return A TidySet object.
#' @export
droplevels.TidySet <- function(x, elements = TRUE, sets = TRUE, ...) {
  stopifnot(is.logical(elements))
  stopifnot(is.logical(sets))

  if (elements) {
    x <- drop_elements(x)
  }
  if (sets) {
    x <- drop_sets(x)
  }
  x
}
