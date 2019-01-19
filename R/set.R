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

#' @describeIn sets Return the number of sets
#' @export
setMethod("nSets",
          signature = signature(object = "TidySet"),
          function(object) {
            nrow(slot(object, "sets"))
          })
