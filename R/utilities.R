validate_set <- function(object) {
  errors <- character()
  if (!is.vector(object@elements) && !is.character(object@elements) && !is.numeric(object@elements)) {
    errors <- "Element should be a character or a numeric vector"
  }

  if (is.numeric(object@elements) && is.null(names(object@elements))) {
    errors <- c(errors, "Numeric sets should be named")
  }

  # Check uniqueness
  if (any(duplicated(names(object@elements)))) {
    errors <- c(errors, "All elements should be unique")
  }

  if (is.null(object@elements) && length(object@elements) < 1) {
    errors <- c(errors, "Elements should not be empty or null")
  }

  if (length(errors) == 0){
    TRUE
  } else {
    errors
  }

}


#' @importFrom methods is
validate_SetCollection <- function(object){
  errors <- character()
  classes <- vapply(object@sets, methods::is, class2 = "Sets")
  if (!any(classes)) {
    errors <- "Sets should be of class Sets"
  }

  if (is.null(object@sets) && length(object@sets) < 1) {
    errors <- c(errors, "Sets should not be empty or null")
  }

  if (length(errors) == 0){
    TRUE
  } else {
    errors
  }
}
