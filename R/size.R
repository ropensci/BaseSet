#' Size
#'
#' Calculate the size of the elements or sets, using the fuzzy values as
#' probabilities. First it must have active either sets or elements.
#' @param object A TidySet object.
#' @param ... Character vector with the name of elements or sets you want to
#' calculate the size of.
#' @export
#' @seealso A related concept [cardinality()]. It is calculated using
#' [length_set()].
#' @return The size of the elements or sets. If there is no active slot or it
#' is the relations slot returns the TidySet object with a warning.
#' @examples
#' rel <- data.frame(
#'     sets = c(rep("A", 5), "B", "C"),
#'     elements = c(letters[seq_len(6)], letters[6])
#' )
#' TS <- tidySet(rel)
#' TS <- activate(TS, "elements")
#' size(TS)
#' TS <- activate(TS, "sets")
#' size(TS)
#' # With fuzzy sets
#' relations <- data.frame(
#'     sets = c(rep("A", 5), "B", "C"),
#'     elements = c(letters[seq_len(6)], letters[6]),
#'     fuzzy = runif(7)
#' )
#' TS <- tidySet(relations)
#' TS <- activate(TS, "elements")
#' size(TS)
#' TS <- activate(TS, "sets")
#' size(TS)
size <- function(object, ...) {
    UseMethod("size")
}

#' @export
#' @method size TidySet
size.TidySet <- function(object, ...) {
    a <- active(object)
    if (is.null(a) || a == "relations") {
        msg <- paste(
            "Unable to calculate the size,",
            "activate either elements or sets."
        )
        warning(msg)
        return(object)
    }

    switch(a,
           elements = element_size(object, ...),
           sets = set_size(object, ...))
}
