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

