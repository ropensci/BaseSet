#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn elements Retrive the elements
#' @export
setMethod("elements",
          signature = signature(object = "TidySet"),
          function(object) {
            object@elements$elements
          })


#' @describeIn elements Modify the elements
#' @export
setMethod("elements<-",
          signature = signature(object = "TidySet"),
          function(object, value) {
            slot(object, "elements") <- value
          })


#' @describeIn nElements Return the number of elements
#' @export
setMethod("nElements",
          signature = signature(object = "TidySet"),
          function(object) {
            nrow(slot(object, "elements"))
          })
