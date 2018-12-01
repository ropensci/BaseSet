#' @importFrom methods new
#' @include AllClasses.R
NULL

#' Create a set
#'
#' @param elements Elements of the set
#' @return An object of class Set
#' @include AllClasses.R
#' @export
#' @examples
#' set(c("a", "b"))
set <- function(elements) {
  methods::new("Set", elements = elements)
}


setMethod("initialize",
          signature = signature(.Object = "Set"),
          function(.Object, elements) {
            .Object <- callNextMethod()
            .Object@elements <- elements

            # Give names
            if (is.null(names(.Object@elements))) {
              names(.Object@elements) <- .Object@elements
            }


            validObject(.Object)
            .Object
          })

#' Create a SetCollection
#'
#' @param sets The list of sets
#' @return An object of class SetCollection
#' @export
#' @examples
#' a <- set(c("a", "b"))
#' b <- set(c("a", "b"))
#' setCollection(c(a, b))
setCollection <- function(sets) {
  methods::new("SetCollection", sets = sets)
}
