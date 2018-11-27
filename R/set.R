
check_set <- function(object) {
  errors <- character()
  if (!is(object@elements, "character") && !is(object@elements, "vector")) {
    errors <- "Element should be a character vector"
  }
  if (any(duplicated(object@elements))) {
    errors <- c(errors, "All elements should be unique")
  }
  if (is.null(object@elements) && length(object@elements) < 1) {
    errors <- c(errors, "Elements should not be empty or null")
  }

  if (length(object@name) > 1) {
    errors <- c(errors, "Name should be short and descriptive")
  }


  if (length(errors) == 0){
    TRUE
  } else {
    errors
  }

}


setClass("Sets",
         representation(elements = "character",
                        name = "character"),
         validity  = check_set,
         prototype = prototype(name = NA_character_, elements = NA_character_)
)
#' @importFrom methods new
sets <- function(elements, ...) {
  methods::new("Sets", name = ..., elements = elements)
}
#' @importFrom methods is
check_SetCollection <- function(object){
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

setClass("SetCollection",
         representation(sets = "list")
         )
