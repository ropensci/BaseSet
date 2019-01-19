#' @include AllClasses.R


#' @title Creates a TidySet
#'
#' Creates a new TidySet object to handle sets.
#' @param relations (required) Depending on the method, it should be a:
#' \itemize{
#'  \item{\code{data.frame}}{ with at least one column for the elements
#'  and one for the sets}
#'  \item{\code{list}}{ with the elements that belong to each set}
#'  \item{\code{matrix}}{ with the elements as the rownames and the sets as
#'  the column names}
#' }
#' @param sets A data.frame with at least one column: "sets"
#' @param elements A data.frame with at least one column: "elements"
#' @return A TidySet object
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b"),
#'                         elements = letters[seq_len(6)])
#' tidySet(relations = relations)
#' @export
#' @rdname tidySet
tidySet <- function(relations, ...) {
  UseMethod("tidySet", relations)
}


#' @describeIn tidySet Given the relations in a data.frame
#' @method tidySet data.frame
#' @export
tidySet.data.frame <- function(relations, sets = NULL, elements = NULL) {

  if (ncol(relations) >= 2 && all(c("sets", "elements") %in% colnames(relations))) {
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
  relations <- as.data.frame(relations, stringsAsFactors = FALSE)
  new("TidySet", sets = sets, elements = elements, relations = relations)
}


#' Method to show the TidySet object
#'
#' Prints the resulting table of a TidySet object
#' @param object A TidySet
#'
#' @return A table with the information of the relationships
#' @export
setMethod("show",
          signature = signature(object = "TidySet"),
          function(object) {
            s <- merge(object@relations, object@sets,
                       by.x = "sets", by.y = "set", sort = FALSE,
                       all.x = TRUE)
            o <- merge(s, object@elements,
                       by.x = "elements", by.y = "elements", sort = FALSE,
                       all.x = TRUE)
            print(o)
          })
