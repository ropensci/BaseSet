#' @include AllClasses.R AllGenerics.R
NULL


setAs("TidySet", "data.frame", function(from) {
  s <- merge(from@relations, from@sets,
             by.x = "sets", by.y = "sets", sort = FALSE,
             all.x = TRUE)
  o <- merge(s, from@elements,
             by.x = "elements", by.y = "elements", sort = FALSE,
             all.x = TRUE)

  # Don't show the fuzzy column if they are all fuzzy
  # Could confuse users when they see this column appear in relations
  if (!is.fuzzy(from)) {
    keep <- setdiff(colnames(o), "fuzzy")
    o <- o[, keep]
  }
  o
})


#' @export
#' @method as.data.frame TidySet
as.data.frame.TidySet <- function(x) {
  as(x, "data.frame")
}
