#' Are some sets as elements of other sets?
#'
#' Check if some elements are also sets of others. This is also known as
#' hierarchical sets.
#' @param object A TidySet object.
#' @return A logical value
#' @family methods
#' @export
#' @seealso adjacency
#' @examples
#' relations <- list(A = letters[1:3], B = c(letters[4:5], "A"))
#' TS <- tidySet(relations)
#' is_nested(TS)
is_nested <- function(object) {
    UseMethod("is_nested")
}

#' @rdname is_nested
#' @export
is_nested.TidySet <- function(object) {
    any(name_elements(object) %in% name_sets(object))
}
