#' @include AllClasses.R


#' @title Creates a TidySet
#'
#' Creates a new TidySet object to handle sets.
#' @param relations (required) Depending on the method, it should be a
#' \code{data.frame} with at least one column for the elements and one for the
#' sets, a \code{list} with the elements that belong to each set, a
#' \code{matrix} with the elements as the rownames and the sets as the column
#' names.
#' @return A TidySet object
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b"),
#'                         elements = letters[seq_len(6)])
#' tidySet(relations = relations)
#' @export
#' @rdname tidySet
tidySet <- function(relations) {
  UseMethod("tidySet")
}


#' @describeIn tidySet Given the relations in a data.frame
#' @method tidySet data.frame
#' @export
tidySet.data.frame <- function(relations) {

  if (ncol(relations) >= 2 && all(c("sets", "elements") %in% colnames(relations))) {
    if (is.null(sets)) {
      sets <- data.frame(set = unique(relations$sets))
    }
    if (is.null(elements)) {
      elements <- data.frame(elements = unique(relations$elements))
    }
  }

  if (!"fuzzy" %in% colnames(relations)) {
    fuzzy <- 1
    relations <- cbind.data.frame(relations, fuzzy)
  }

  new("TidySet", sets = sets, elements = elements, relations = relations)
}

#' @export
#' @describeIn tidySet Convert to a TidySet from a list
#' @examples
#' x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
#' a <- tidySet(x)
tidySet.list <- function(relations) {
  nSets <- length(relations)
  sets <- rep(names(relations), lengths(relations))

  char <- vapply(relations, is.character, logical(1L))
  num <- vapply(relations, is.numeric, logical(1L))

  if (!all(char) && !all(num)) {
    stop("The list should have either characters or named numeric vectors")
  }
  if (all(char)) {
    elements <- unlist(relations, use.names = FALSE)
    fuzzy <- rep(1, length(elements))
  } else if (all(num)) {
    elements <- unlist(lapply(relations, names), use.names = FALSE)

    if (is.null(elements)) {
      stop("The numeric vectors should be named")
    }
    fuzzy <- unlist(relations, use.names = FALSE)
  }

  relations <- data.frame(elements, sets, fuzzy)
  tidySet(relations = relations)
}

#' @describeIn tidySet Convert an incidence matrix into a TidySet
#' @export
#' @examples
#' x <- list("a" = letters[1:5], "b" = LETTERS[3:7], "c" = runif(5))
#' a <- tidySet(x)
#' tidySet.matrix(incidence(a))
tidySet.matrix <- function(relations) {

  if (anyDuplicated(colnames(relations))) {
    stop("There are duplicated colnames.")
  }
  if (anyDuplicated(rownames(relations))) {
    stop("There are duplicated rownames.")
  }
  if (!is.numeric(relations)) {
    stop("The incidence should be a numeric matrix.")
  }
  # Preparation
  incid <- relations
  elements <- rownames(incid)
  sets <- colnames(incid)
  relations <- as.data.frame(which(incid != 0, arr.ind = TRUE))
  colnames(relations) <- c("elements", "sets")

  # Replace by names
  relations[, 1] <- elements[relations[, 1]]
  relations[, 2] <- sets[relations[, 2]]

  fuzzy <- apply(relations, 1, function(x){
    incid[x[1], x[2]]
  })
  relations <- cbind.data.frame(relations, fuzzy)
  tidySet(relations = relations)
}
