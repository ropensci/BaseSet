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
#' a <- set(c("a", "b"))
#' e <- set(c("a" = 0.1, "b" = 0.5))
set <- function(elements) {

  # If character convert to equivalent fuzzy nomenclature
  if (is.character(elements)) {
    x <- rep(1, length(elements))
    # Give names
    if (is.null(names(elements))) {
      names(x) <- elements
    } else {
      names(x) <- names(elements)
    }
  } else {
    x <- elements
  }

  methods::new("Set", elements = x)
}

#' @export
setMethod("$",
          signature = signature(x = "Set"),
          function(x, name){
            x@elements[[name]]
          })

#' @describeIn elements For \code{Set} objects
#' @export
setMethod("elements",
          signature = signature(object = "Set"),
          function(object) {
            names(object@elements)
          })

#' @export
setMethod("length",
          signature = signature(x = "Set"),
          function(x) {
            length(x@elements)
          })

#' @describeIn is.fuzzy For \code{Set} objects
#' @export
setMethod("is.fuzzy",
          signature = signature(object = "Set"),
          function(object) {
            !all(object@elements == 1)
          })

#' @importFrom methods show
setMethod("show",
          signature = signature(object = "Set"),
          function(object) {
            e <- elements(object)
            l <- length(e)
            if (is.fuzzy(object)) {
              cat("Fuzzy set with", l, "elements.")
            } else {
              cat("Set with", l, "elements.")
            }
          })
