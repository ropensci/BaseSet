#' @include AllClasses.R AllGenerics.R
NULL

setAs("TidySet", "data.frame", function(from) {
    # browser()
    r <- from@relations
    s <- merge(r, from@sets,
        by.x = "sets", by.y = "sets", sort = FALSE,
        all.x = TRUE, suffixes = c(".relations", ".sets")
    )
    o <- merge(s, from@elements,
        by.x = "elements", by.y = "elements", sort = FALSE,
        all.x = TRUE, suffixes = c("", ".elements")
    )

    # To keep the order of the data.frame
    new_ord <- paste0(o$elements, o$sets)
    old_ord <- paste0(r$elements, r$sets)

    o <- o[match(old_ord, new_ord), , drop = FALSE]
    rownames(o) <- seq_len(nrow(o))
    o
})

#' Transforms a TidySet to a data.frame
#'
#' Flattens the three slots to a single big table
#' @param x The \code{TidySet} object.
#' @param ... Placeholder for other arguments that could be passed to the
#' method. Currently not used.
#' @return A \code{data.frame} table.
#' @method as.data.frame TidySet
#' @export
as.data.frame.TidySet <- function(x, ...) {
    as(x, "data.frame")
}

#' The opposite of as.data.frame
#'
#' Convert a data.frame to a TidySet by first using the relations.
#' It requires the original TidySet in order to convert it back to resemble
#' the position of the columns.
#' @param .data The original TidySet
#' @param df The flattened data.frame
#' @seealso [tidySet.data.frame()]
#' @return A TidySet object
#' @keywords internal
df2TS <- function(.data = NULL, df) {
    if (!is.null(.data)) {
        colnames_sets <- colnames(sets(.data))
        colnames_elements <- colnames(elements(.data))
    }

    sets <- c("sets")
    elements <- c("elements")

    if (!"fuzzy" %in% colnames(df)) {
        df$fuzzy <- 1
    }
    final_colnames <- colnames(df)
    TS <- tidySet(df)

    # Move just the columns that need to be moved.
    move_sets <- setdiff(colnames_sets, sets)
    move_sets <- move_sets[move_sets %in% final_colnames]
    move_elements <- setdiff(colnames_elements, elements)
    move_elements <- move_elements[move_elements %in% final_colnames]
    TS <- move_to(TS, "relations", "sets", move_sets)
    TS <- move_to(TS, "relations", "elements", move_elements)
    validObject(TS)
    TS
}
