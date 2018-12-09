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
#' d <- setCollection(c(a, b))
setCollection <- function(sets) {
  s <- lapply(sets, function(x){
    if (is(x, "Set")){
      x
    } else {
      set(x)
    }
  })
  methods::new("SetCollection", sets = s)
}


#' @describeIn elements For \code{SetCollection} objects
#' @export
setMethod("elements",
          signature = signature(object="SetCollection"),
          function(object) {
            result <- lapply(object@sets, elements)
            names(result) <- names(object@sets)
            result
          })


#' @describeIn sets For \code{SetCollection} objects
#' @export
setMethod("sets",
          signature = signature(object = "SetCollection"),
          function(object) {
            names(object@sets)
          })

#' @describeIn is.fuzzy For \code{SetCollection} objects
#' @export
setMethod("is.fuzzy",
          signature = signature(object = "SetCollection"),
          function(object) {
            any(vapply(object@sets, is.fuzzy, logical(1L)))
          })

#' @export
setMethod("n_sets",
          signature = signature(object = "SetCollection"),
          function(object) {
            length(sets(object))
          }
)

#' @export
setMethod("show",
          signature = signature(object = "SetCollection"),
          function(object) {
            l <- n_sets(object)
            # ls <- vapply(object@sets, lengths, numeric(1L))
            le <- length(unique(unlist(elements(object))))
            if (is.fuzzy(object)) {
              cat("A SetCollection with fuzzy sets:\n",
                  " ", l, "sets from", le, "elements.")
            } else {
              cat("A SetCollection:\n",
                  " ", l, "sets from", le, "elements.")

            }
          })

setMethod("incidence",
          signature = signature(object = "SetCollection"),
          function(object) {
            elements <- elements(object)
            u_element <- unique(elements)
            set <- sets(objects)
            i <- matrix(0, ncol = length(set), nrow = length(u_element),
                        dimnames = list(set, u_element))

            is.fuzzy(object)
            for (s in set) {
              if (is.numeric(elements[[s]])) {

              }
            }
          })
#' Extract or Replace Parts of a SetCollection
#'
#' Equivalent of the base [], and [[]]
#' @param x,object SetCollection from which to extract element(s) or in which to
#' replace element(s)
#' @param i,j indices specifying elements to extract or replace. Indices are
#' numeric or character vectors or empty (missing) or \code{NULL}
#' @export
setMethod("[",
          signature = signature(x = "SetCollection", i = "logical"),
          function(x, i, j, ..., drop = TRUE){
            if (n_sets(x) > length(i)) {
              stop("Logical vector is longer than the number of sets")
            }
            setCollection(x@sets[i])
          })

setMethod("names<-",
          signature = signature(x = "SetCollection", value = "character"),
          function(x, value) {
           names(x@sets) <- value
           validObject(x)
           x
          })

setMethod("names",
          signature = signature(x = "SetCollection"),
          function(x) {
           names(x@sets)
          })
setMethod("relation",
          signature = signature(object = "SetCollection"),
          function(object) {
            lapply(object@sets, function(x){
              y <- x@elements
              if (is.character(y)){
                z <- rep(1, length(y))
                names(z) <- names(y)
                z
              } else {
                y
              }
            })
          })

setMethod("tidy",
          signature = signature(object = "SetCollection"),
          function(object) {
           e <- elements(object)
           s <- rep(names(e), lengths(e))
           w <- relation(object)
           cbind.data.frame(Element = unlist(e, use.names = FALSE),
                            Set = s,
                            Weight = unlist(w, use.names = FALSE))

          })
