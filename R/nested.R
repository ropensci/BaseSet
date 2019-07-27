#' Are some sets as elements of other sets?
#'
#' Check if some elements are also sets of others. This is also known as
#' hierarchical sets.
#' @param object A TidySet object.
#' @return A logical value: TRUE if there are some sets included as elements of
#' others.
#' @family methods
#' @export
#' @seealso adjacency
#' @examples
#' relations <- list(A = letters[1:3], B = c(letters[4:5]))
#' TS <- tidySet(relations)
#' is_nested(TS)
#' TS2 <- add_relation(TS, data.frame(elements = "A", sets = "B"))
#' # Note that A is both a set and an element of B
#' TS2
#' is_nested(TS2)
is_nested <- function(object) {
    UseMethod("is_nested")
}

#' @rdname is_nested
#' @export
is_nested.TidySet <- function(object) {
    any(name_elements(object) %in% name_sets(object))
}
