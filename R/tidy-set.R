#' @include AllClasses.R

#' @export
TidySet <- function (relations, sets = NULL, elements = NULL) {

  if (ncol(relations) == 2 && all(c("sets", "elements") %in% colnames(relations))) {
    if (is.null(sets)) {
      sets <- data.frame(set = unique(relations$sets))
    }
    if (is.null(elements)) {
      elements <- data.frame(elements = unique(relations$elements))
    }
  }


  new("TidySet", sets = sets, elements = elements, relations = relations)
}
