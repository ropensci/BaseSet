#' @include AllClasses.R AllGenerics.R
NULL

setAs("TidySet", "data.frame", function(from) {
    s <- merge(from@relations, from@sets,
        by.x = "sets", by.y = "sets", sort = FALSE,
        all.x = TRUE, suffixes = c(".relations", ".sets")
    )
    o <- merge(s, from@elements,
        by.x = "elements", by.y = "elements", sort = FALSE,
        all.x = TRUE, suffixes = c("", ".elements")
    )

    o
})

#' Transforms a TidySet to a data.frame
#'
#' Flattens the three slots to a single big table
#' @param x The \code{TidySet} object.
#' @param ... Other arguments currently ignored.
#' @return A \code{data.frame} table.
#' @method as.data.frame TidySet
#' @export
as.data.frame.TidySet <- function(x, ...) {
    as(x, "data.frame")
}

#' The oposite of as.data.frame
#'
#' Convert a data.frame to a tidySet by first using the relations.
#' It requires the original TidySet in order to convert it back.
#' @param .data The original TidySet
#' @param df The flattened data.frame
#' @return A TidySet object
#' @noRd
df2TS <- function(.data = NULL, df) {
    if (!is.null(.data)) {
        colnames_sets <- colnames(sets(.data))
        colnames_elements <- colnames(elements(.data))
        colnames_relations <- colnames(relations(.data))
    } else {
        colnames_sets <- c("sets")
        colnames_elements <- c("elements")
        colnames_relations <- c("elements", "sets", "fuzzy")
    }
    if (!"fuzzy" %in% colnames(df)) {
        df$fuzzy <- 1
    }
    final_colnames <- colnames(df)
    colnames_data <- c(colnames_sets, colnames_elements, colnames_relations)
    new_colnames <- setdiff(final_colnames, colnames_data)
    relations <- df[, c(colnames_relations, new_colnames)]

    TS <- tidySet(relations)

    TS@elements <- merge(TS@elements,
        unique(df[, colnames_elements, drop = FALSE]),
        all.x = TRUE, all.y = FALSE, sort = FALSE
    )
    TS@sets <- merge(TS@sets,
        unique(df[, colnames_sets, drop = FALSE]),
        all.x = TRUE, all.y = FALSE, sort = FALSE
    )
    validObject(TS)
    TS
}
