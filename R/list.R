
setAs("TidySet", "list", function(from) {
    out <- split(
        seq_len(nRelations(from)),
        relations(from)$sets
    )

    lapply(out, function(x, relations) {
        out <- relations$fuzzy[x]
        names(out) <- relations$elements[x]
        out
    }, relations = relations(from))
})

#' Convert to list
#'
#' Converts a TidySet to a list
#' @param x object to be coerced.
#' @param ... objects, possibly named (currently ignored).
#' @return A list
#' @method as.list TidySet
#' @export
as.list.TidySet <- function(x, ...) {
    as(x, "list")
}
