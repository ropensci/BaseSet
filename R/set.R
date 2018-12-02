#' @importFrom methods new
#' @include AllClasses.R AllGenerics.R
NULL

#' Create a set
#'
#' @param elements Elements of the set
#' @return An object of class Set
#' @include AllClasses.R
#' @export
#' @examples
#' set(c("a", "b"))
#' set(c("a" = 0.1, "b" = 0.5))
set <- function(elements) {
  methods::new("Set", elements = elements)
}

#' @importFrom methods callNextMethod validObject
setMethod("initialize",
          signature = signature(.Object = "Set"),
          function(.Object, elements) {
            .Object <- methods::callNextMethod()
            .Object@elements <- elements

            # Give names
            if (is.null(names(.Object@elements))) {
              names(.Object@elements) <- .Object@elements
            }


            methods::validObject(.Object)
            .Object
          })


#' @describeIn elements For \code{Set} objects
#' @export
setMethod("elements",
          signature=signature(
            object="Set"),
          function(object) {
            names(object@elements)
          })

