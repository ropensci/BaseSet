#' @include AllClasses.R
NULL

#' Retrieve the elements
#'
#' Given a Set or a SetCollection retrieve the elements
#' @param object Either a \code{Set} or a \code{SetCollection} object
#' @export
setGeneric("elements", function(object)
  standardGeneric("elements")
)
#' Retrieve the names of the sets
#'
#' Given a SetCollection retrieve the names of the sets
#' @param object A \code{SetCollection} object
#' @export
setGeneric("sets", function(object)
  standardGeneric("sets")
)

#' Fuzzy Sets
#'
#' Check if there are fuzzy sets.
#' @param object Object to be coerced or tested.
#' @export
setGeneric("is.fuzzy", function(object)
  standardGeneric("is.fuzzy")
)

#' Number of Sets
#'
#' Check if the number of sets of the SetCollection
#' @param object Object to be coerced or tested.
#' @export
setGeneric("n_sets", function(object)
  standardGeneric("n_sets")
)

#' Incidence
#'
#' Check which elements are in which sets
#' @param object Object to be coerced or tested.
#' @export
setGeneric("incidence", function(object)
  standardGeneric("incidence")
)

#' Tidy the SetCollection
#'
#' Transform the object to a tidy/long \code{data.frame}
#' @param object Object to be coerced or tested.
#' @return A data.frame
#' @export
setGeneric("tidy", function(object)
  standardGeneric("tidy")
)
#' Find strength of the relationship
#'
#' Transform the object to a tidy/long \code{data.frame}
#' @param object Object to be coerced or tested.
#' @return A list of weight with the relationship. If it is not a fuzzy set
#' it is converted to 1.
#' @export
setGeneric("relation", function(object)
  standardGeneric("relation")
)
