#' Size
#'
#' Calculate the size of the elements or sets
#' @param object A TidySet object
#' @param ... Other arguments to filter which size should be shown.
#' @export
#' @return The size of the active slot. Not available for relations.
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
#'                         elements = c(letters[seq_len(6)], letters[6]),
#'                         fuzzy = runif(7))
#' a <- tidySet(relations)
#' a <- activate(a, "elements")
#' size(a)
#' a <- activate(a, "sets")
#' size(a)
size <- function(object, ...) {
    UseMethod("size")
}



#' @export
#' @method size TidySet
size.TidySet <- function(object, ...) {
    a <- active(object)
    if (is.null(a) || a == "relations") {
        warning("Unable to calculate the size, activate either elements or sets.")
    } else {
        switch(a,
               elements = element_size(object, ...),
               sets = set_size(object, ...))
    }
}
