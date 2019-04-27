#' @include AllClasses.R AllGenerics.R
NULL


#' @describeIn sets Retrieve the sets information
#' @export
setMethod("sets",
          signature = signature(object = "TidySet"),
          function(object) {
            slot(object, "sets")
          })

#' @describeIn sets Modify the sets information
#' @export
setMethod("sets<-",
          signature = signature(object = "TidySet"),
          function(object, value) {
            slot(object, "sets") <- value
            validObject(object)
            object
          })

#' @rdname sets
#' @export
replace_sets <- function(object, value) {
    UseMethod("replace_sets")
}

#' @export
#' @method replace_sets TidySet
replace_sets.TidySet <- function(object, value) {
    sets(object) <- value
}

#' @describeIn sets Return the number of sets
#' @export
setMethod("nSets",
          signature = signature(object = "TidySet"),
          function(object) {
            nrow(slot(object, "sets"))
          })
