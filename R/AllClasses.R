# S4 classes ###
#' A class to represent a set
#'
#' A set is a group of unique elements it can be either a fuzzy set, where the
#' relationship is between 0 or 1 or nominal
#' @slot elements A group of unique elements
#' @export
setClass("Set",
         representation(elements = "numeric")
)

#' A class to represent a group of sets
#'
#' Several sets together form a collection
#' @slot sets A group of unique sets
#' @export
setClass("SetCollection",
         representation(sets = "list")
)

# S4 validations ####
setValidity("Set", function(object) {
  errors <- character()

  if (is.null(names(object@elements))) {
    errors <- "Elements should be a named numeric vector"
  } else if (any(duplicated(names(object@elements)))) {
    errors <- c(errors, "All elements names should be unique")
  }

  if (any(object@elements > 1) || any(object@elements < 0)) {
    msg <- paste0("Fuzzy sets should be between numberic between 0 and 1.",
                  "\nTry scaling them.")
    errors <- c(errors, msg)
  }

  if (is.null(object@elements) || length(object@elements) < 1) {
    errors <- c(errors, "Elements should not be empty or null")
  }

  if (length(errors) == 0){
    TRUE
  } else {
    errors
  }

}
)

#' @importFrom methods is
setValidity("SetCollection", function(object) {
  errors <- character()

  if (is.null(object@sets) || length(object@sets) < 1) {
    errors <- c(errors, "Sets should not be empty or null")
  } else {
    classes <- vapply(object@sets, methods::is, class2 = "Set", logical(1L))
    if (!any(classes)) {
      errors <- c(errors, "Sets should be of class Set")
    }
  }


  if (length(errors) == 0){
    TRUE
  } else {
    errors
  }
})

# initialize
# https://github.com/variani/pckdev/wiki/Documenting-with-roxygen2#s4-classes??



# S4 classes ###
#' A tidy class to represent a set
#'
#' A set is a group of unique elements it can be either a fuzzy set, where the
#' relationship is between 0 or 1 or nominal
#' @slot relations A data.frame with elements and the sets were they belong.
#' @slot elements A data.frame of unique elements and related information.
#' @slot sets A data.frame of unique sets and related information.
#' @export
setClass("TidySet",
         representation(elements = "data.frame",
                        sets = "data.frame",
                        relations = "data.frame")
)


#' @importFrom methods is
setValidity("TidySet", function(object) {
  errors <- c()


  for (slot in slotNames(object)) {
    errors <- c(errors, check_empty(object, slot))
  }

  errors <- c(errors, check_colnames(object, "elements", "elements"))
  errors <- c(errors, check_colnames(object, "sets", "set"))
  errors <- c(errors, check_colnames(object, "relations", "elements"))
  errors <- c(errors, check_colnames(object, "relations", "sets"))

  if (length(errors) == 0){
    TRUE
  } else {
    errors
  }
})

check_empty <- function(object, slot){
  df <- slot(object, slot)
  if (nrow(df) < 0) {
    paste0(slot, " should not be empty")
  }
}

check_colnames <- function(object, slot, colname) {
  if (base::length(colnames(slot(object, slot))) == 0) {
    paste0("Provide at least the required colnames for ", slot,
          ". See documentation.")
  } else if (!colname %in% colnames(slot(object, slot))) {
    paste0(colname, " column is not present on slot ", slot, ".")
  }
}
