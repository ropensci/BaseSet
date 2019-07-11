#' @include AllClasses.R
NULL

#' Create a TidySet object
#'
#' This functions help to create a \code{TidySet} object.
#' @param relations,object An object to be coerced to a TidySet.
#' @return A TidySet object
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b"),
#'                         elements = letters[seq_len(6)])
#' tidySet(relations)
#' @export
#' @seealso \code{\link{TidySet-class}}
tidySet <- function(relations) {
  UseMethod("tidySet")
}


#' @describeIn tidySet Given the relations in a data.frame
#' @method tidySet data.frame
#' @export
tidySet.data.frame <- function(relations) {

  if (ncol(relations) >= 2 && all(c("sets", "elements") %in% colnames(relations))) {
    sets <- data.frame(sets = unique(relations$sets),
                       stringsAsFactors = FALSE)
    elements <- data.frame(elements = unique(relations$elements),
                           stringsAsFactors = FALSE)
  } else {
    stop("Unable to create a TidySet object.\n",
         "The data.frame is not in the right format", call. = FALSE)
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
#' # A
#' x <- list("A" = letters[1:5], "B" = LETTERS[3:7])
#' tidySet(x)
#' # A fuzzy set taken encoded as a list
#' A <- runif(5)
#' names(A) <- letters[1:5]
#' B <- runif(5)
#' names(B) <- letters[3:7]
#' relations <- list(A, B)
#' tidySet(relations)
#' \dontrun{
#' x <- list("A" = letters[1:5], "B" = LETTERS[3:7], "c" = runif(5))
#' a <- tidySet(x) # An error for mixing letters and numbers
#' }
tidySet.list <- function(relations) {

  char <- vapply(relations, is.character, logical(1L))
  num <- vapply(relations, is.numeric, logical(1L))
  fact <- vapply(relations, is.factor, logical(1L))

  if (!all(char | fact) && !all(num)) {
    stop("The list should have either characters or named numeric vectors",
         call. = FALSE)
  }
  if (is.null(names(relations))) {
      names(relations) <- paste0("Set", seq_along(relations))
  }
  if (all(char | fact)) {
    relations <- lapply(relations, unique)
    elements <- unlist(relations, use.names = FALSE)
    fuzzy <- rep(1, length(elements))
  } else if (all(num)) {
    elements <- unlist(lapply(relations, names), use.names = FALSE)

    if (is.null(elements)) {
      stop("The numeric vectors should be named", call. = FALSE)
    }
    fuzzy <- unlist(relations, use.names = FALSE)
  }
  sets <- rep(names(relations), lengths(relations))
  relations <- data.frame(elements, sets, fuzzy,
                          stringsAsFactors = FALSE)
  tidySet.data.frame(relations = relations)
}

#' @describeIn tidySet Convert an incidence matrix into a TidySet
#' @export
#' @examples
#' # Numeric input should be named
#' x <- list("a" = c("A" = 0.1, "B" = 0.5), "b" = c("A" = 0.2, "B" = 1))
#' a <- tidySet(x)
#' tidySet(incidence(a))
tidySet.matrix <- function(relations) {

  if (anyDuplicated(colnames(relations))) {
    stop("There are duplicated colnames.", call. = FALSE)
  }
  if (anyDuplicated(rownames(relations))) {
    stop("There are duplicated rownames.", call. = FALSE)
  }
  if (!is.numeric(relations)) {
    stop("The incidence should be a numeric matrix.", call. = FALSE)
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



#' @describeIn tidySet Convert Go3AnnDbBimap into a TidySet object.
#' @export
tidySet.Go3AnnDbBimap <- function(relations) {
  # Prepare the data
  df <- as.data.frame(relations)
  colnames(df) <- c("elements", "sets",  "Evidence", "Ontology")

  # Transform each evidence code into its own column
  e_s <- paste(df$elements, df$sets)
  tt <- as(table(e_s, df$Evidence), "matrix")
  tt2 <- as.data.frame(tt)
  tt2$elements <- gsub(" GO:.*", "", rownames(tt2))
  tt2$sets <- gsub(".* ", "", rownames(tt2))
  rownames(tt2) <- NULL

  df2 <- cbind(tt2, nEvidence = rowSums(tt))
  df3 <- merge(df2, unique(df[, c("sets", "Ontology")]))
  TS <- tidySet.data.frame(df3)
  move_to(TS, "relations", "sets", "Ontology")
  }
