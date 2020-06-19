
setAs("TidySet", "list", function(from) {
    r <- relations(from)
    if (ncol(r) > 3) {
        warning("Dropping information on the coercion.", call. = FALSE)
    }
    r <- r[, c("elements", "sets", "fuzzy")]
    r <- unique(r)
    out <- split(
        seq_len(nrow(r)),
        r$sets
    )

    lapply(out, function(x, relations) {
        out <- relations$fuzzy[x]
        names(out) <- relations$elements[x]
        out
    }, relations = r)
})

#' Convert to list
#'
#' Converts a TidySet to a list.
#' @param x A TidySet object to be coerced to a list.
#' @param ... Placeholder for other arguments that could be passed to the
#' method. Currently not used.
#' @return A list.
#' @method as.list TidySet
#' @export
#' @examples
#' r <- data.frame(sets = c("A", "A", "A", "B", "C"),
#'              elements = c(letters[1:3], letters[2:3]),
#'              fuzzy = runif(5),
#'              info = rep_len(c("important", "very important"), 5))
#' TS <- tidySet(r)
#' TS
#' as.list(TS)
as.list.TidySet <- function(x, ...) {
    as(x, "list")
}
