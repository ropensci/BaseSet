#' @importFrom methods new
#' @include AllClasses.R AllGenerics.R
NULL

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


#' @describeIn elements For \code{SetCollection} objects
#' @export
setMethod("elements",
          signature=signature(
            object="SetCollection"),
          function(object) {
            result <- lapply(object@sets, elements)
            names(result) <- names(object@sets)
            result
          })
