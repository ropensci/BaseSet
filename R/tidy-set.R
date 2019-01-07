#' @include AllClasses.R

#' Creates a TidySet
#'
#' Creates a new TidySet object to handle sets.
#' @param relations (required) A data.frame with at least two columns: "sets" and "elements"
#' @param sets A data.frame with at least one column: "sets"
#' @param elements A data.frame with at least one column: "elements"
#' @return A TidySet object
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b"),
#' elements = letters[seq_len(6)])
#' TidySet(relations = relations)
#' @export
#' @title tidySet
TidySet <- function (relations, sets = NULL, elements = NULL) {

  if (ncol(relations) == 2 && all(c("sets", "elements") %in% colnames(relations))) {
    if (is.null(sets)) {
      sets <- data.frame(set = unique(relations$sets))
    }
    if (is.null(elements)) {
      elements <- data.frame(elements = unique(relations$elements))
    }
  }

  if (!is.null(elements) && !is.null(sets) && is.null(relations)) {
    stop("Provide some relations between the elements and the sets.")
  }

  new("TidySet", sets = sets, elements = elements, relations = relations)
}
