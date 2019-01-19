#' @include AllClasses.R
#' @import methods
NULL

#' Retrieve the elements
#'
#' Given a Set or a SetCollection retrieve the elements
#' @param object A TidySet object
#' @param value Modification of the elements
#' @return Either the information about the elements
#' @export elements
#' @seealso \code{\link{nElements}}
#' @family slots
#' @aliases elements<-
setGeneric("elements", function(object) standardGeneric("elements"))

#' Retrieve the names of the sets
#'
#' Given a SetCollection retrieve the names of the sets
#' @param object A \code{SetCollection} object
#' @param value Modification of the sets
#' @export sets
#' @aliases sets<-
#' @seealso \code{\link{nSets}}
#' @family slots
setGeneric("sets", function(object) standardGeneric("sets"))

#' Fuzzy Sets
#'
#' Check if there are fuzzy sets.
#' @param object Object to be coerced or tested.
#' @export is.fuzzy
setGeneric("is.fuzzy", function(object) standardGeneric("is.fuzzy"))

#' Number of sets
#'
#' Check the number of sets of the TidySet
#' @param object Object to be coerced or tested.
#' @export nSets
setGeneric("nSets", function(object) standardGeneric("nSets"))

#' Number of elements
#'
#' Check the number of elements of the TidySet
#' @param object Object to be coerced or tested.
#' @export nElements
setGeneric("nElements", function(object) standardGeneric("nElements"))

#' Number of relations
#'
#' Check the number of relations of the TidySet
#' @param object Object to be coerced or tested.
#' @export nRelations
setGeneric("nRelations", function(object) standardGeneric("nRelations"))

#' Incidence
#'
#' Check which elements are in which sets
#' @param object Object to be coerced or tested.
#' @export incidence
setGeneric("incidence", function(object) standardGeneric("incidence"))

#' Find the relationship
#'
#' Method to find the relationships between the elements and the sets of a given
#' \code{\link{TidySet}} object
#' @param object Object to be coerced or tested.
#' @param value Modification of the relationsihps
#' @return The existing relationships
#' @family slots
#' @seealso \code{\link{nRelations}}
#' @export
setGeneric("relations", function(object) standardGeneric("relations"))

#' @describeIn relations Modify the relationships
#' @export
setGeneric("relations<-", function(object, value)
  standardGeneric("relations<-"))


#' @describeIn elements Modify the elements
#' @export
setGeneric("elements<-", function(object, value) standardGeneric("elements<-"))

#' @describeIn sets Modify the sets
#' @export
setGeneric("sets<-", function(object, value) standardGeneric("sets<-"))


setGeneric("set_size", function(object, set) standardGeneric("set_size"))
