#' @include AllClasses.R AllGenerics.R
NULL

setAs("TidySet", "data.frame", function(from) {
  s <- merge(from@relations, from@sets,
             by.x = "sets", by.y = "sets", sort = FALSE,
             all.x = TRUE, suffix = c(".relations", ".sets"))
  o <- merge(s, from@elements,
             by.x = "elements", by.y = "elements", sort = FALSE,
             all.x = TRUE, suffix = c("", ".elements"))

  # Don't show the fuzzy column if they are all fuzzy
  # Could confuse users when they see this column appear in relations
  if (!is.fuzzy(from)) {
    keep <- setdiff(colnames(o), "fuzzy")
    o <- o[, keep]
  }
  o
})


#' Transforms a TidySet to a data.frame
#'
#' Flattens the three slots to a single big table
#' @param x The \code{TidySet} object.
#' @param ... Other arguments currently ignored.
#' @return A \code{data.frame} table.
#' @export
#' @method as.data.frame TidySet
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
df2TS <- function(.data, df){
  colnames_sets <- colnames(sets(.data))
  colnames_elements <- colnames(elements(.data))
  colnames_relations <- colnames(relations(.data))
  TS <- tidySet(df[, colnames_relations])

  TS@elements <- merge(TS@elements,
                       unique(df[, colnames_elements, drop = FALSE]),
                       all.x = TRUE, all.y = FALSE)
  TS@sets <- merge(TS@sets,
                   unique(df[, colnames_sets, drop = FALSE]),
                   all.x = TRUE, all.y = FALSE)
  validObject(TS)
  TS
}
