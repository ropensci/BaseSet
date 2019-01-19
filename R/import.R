#' @include tidy-set.R
NULL

#' @export
#' @describeIn tidySet Convert to a TidySet from a list
#' @examples
#' x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
#' a <- tidySet(x)
tidySet.list <- function(relations) {
  sets <- rep(names(relations), lengths(relations))
  elements <- unique(unlist(relations, use.names = FALSE))
  if (is.numeric(elements)) {
    fuzzy <- elements
    elements <- unique(unlist(lapply(relations, names), use.names = FALSE))
    relations <- data.frame(elements, sets, fuzzy)
  } else {
    relations <- data.frame(elements, sets)
  }
  tidySet(relations = relations)
}

#' @describeIn tidySet Convert an incidence matrix into a TidySet
#' @export
#' @examples
#' tidySet.matrix(incidence(a))
tidySet.matrix <- function(relations) {

  if (anyDuplicated(colnames(relations))) {
    stop("There are duplicated colnames.")
  }
  if (anyDuplicated(rownames(relations))) {
    stop("There are duplicated rownames.")
  }
  browser()
  incid <- relations
  relations <- as.data.frame(which(incid != 0, arr.ind = TRUE))
  elements <- rownames(incid)
  sets <- colnames(incid)
  relations[, 1] <- elements[relations[, 1]]
  relations[, 2] <- sets[relations[, 2]]
  colnames(relations) <- c("elements", "sets")
  fuzzy <- apply(relations, 1, function(x){
    incid[x[1], x[2]]
  })
  relations <- cbind(relations, fuzzy)
  tidySet(relations = relations)
}
