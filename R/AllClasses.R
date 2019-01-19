# S4 classes ###
#' A tidy class to represent a set
#'
#' A set is a group of unique elements it can be either a fuzzy set, where the
#' relationship is between 0 or 1 or nominal
#' @slot relations A data.frame with elements and the sets were they belong.
#' @slot elements A data.frame of unique elements and related information.
#' @slot sets A data.frame of unique sets and related information.
#' @aliases TidySet
#' @export
setClass("TidySet",
         representation(elements = "data.frame",
                        sets = "data.frame",
                        relations = "data.frame")
)


setValidity("TidySet", function(object) {
  errors <- c()

 # Check that slots are not empty
  for (slot in slotNames(object)) {
    errors <- c(errors, check_empty(object, slot))
  }

  # Check that the slots have the right columns
  errors <- c(errors, check_colnames(object, "elements", "elements"))
  errors <- c(errors, check_colnames(object, "sets", "set"))
  errors <- c(errors, check_colnames(object, "relations", "elements"))
  errors <- c(errors, check_colnames(object, "relations", "sets"))
  errors <- c(errors, check_colnames(object, "relations", "fuzzy"))

  # Check that the tables are related
  if (!all(unique(object@relations$sets) %in% object@sets$set)) {
    errors <- c(errors, "All sets must be described on their table.")
  }
  if (!all(unique(object@relations$elements) %in% object@elements$elements)) {
    errors <- c(errors, "All elements must be described on their table.")
  }

  # Check that the columns contain the least information required
  elements <- object@elements$elements

  if (length(unique(elements)) != length(elements)) {
    errors <- c(errors, "Elements on the element slot must be unique")
  }
  sets <- object@sets$set
  if (length(unique(sets)) != length(sets)) {
    errors <- c(errors, "Set on the sets slot must be unique")
  }

  # Check the type of data
  if (!is.character(sets) && !is.factor(sets)) {
    errors <- c(errors, "Sets must be characters or factors")
  }
  if (!is.character(elements) && !is.factor(elements)) {
    errors <- c(errors, "Elements must be characters or factors")
  }

  fuzz <- object@relations$fuzzy
  if (!is.numeric(fuzz) || min(fuzz) < 0 || max(fuzz) > 1 ) {
    errors <- c(errors,
                "fuzzy column is restricted to a number between 0 and 1.")
  }

  # Check that the slots don't have duplicated information
  colnames_elements <- colnames(object@elements)
  colnames_sets <- colnames(object@sets)
  if (length(intersect(colnames_elements, colnames_sets)) != 0) {
    errors <- c(errors,
                "Sets and elements shouldn't share a column name: Use relations")
  }

  # Check that the relations is unique
  if (anyDuplicated(object@relations[, c("elements", "sets")])) {
    errors <- c(errors,
                "A relationship between an element and a set should be unique."
                )
  }
  if (length(errors) == 0){
    TRUE
  } else {
    errors
  }
})

check_empty <- function(object, slot){
  df <- slot(object, slot)
  if (nrow(df) < 0) {
    paste0(slot, " should not be empty.")
  }
}

check_colnames <- function(object, slot, colname) {
  if (length(colnames(slot(object, slot))) == 0) {
    paste0("Provide at least the required colnames for ", slot,
          ". See documentation.")
  } else if (!colname %in% colnames(slot(object, slot))) {
    paste0(colname, " column is not present on slot ", slot, ".")
  }
}
