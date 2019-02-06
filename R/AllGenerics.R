#' @include AllClasses.R
#' @import methods
NULL

#' Retrieve the elements
#'
#' Given TidySet retrieve the elements
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
#' Given a TidySet retrieve the names of the sets
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
#' @aliases relations<-
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

#' Calculates the size of the set
#'
#' Calculate the probability of being of different sizes for a given set
#' @param object A TidySet object
#' @param set The sets from which the length is calculated
#' @return A list with the size of the set or the probability of having that
#' size.
#' @export set_size
setGeneric("set_size", function(object, set = NULL) standardGeneric("set_size"))

#' Calculates the size of the elements
#'
#' Calculate the probability of being of different sizes for a given set
#' @param object A TidySet object
#' @param element The element from which the length is calculated.
#' @return A list with the size of the elements or the probability of having that
#' size.
#' @export element_size
setGeneric("element_size", function(object, element = NULL) standardGeneric("element_size"))

#' Rename sets
#'
#' Change the default names of sets and elements
#' @param object A TidySet object
#' @param old A character vector of to be renamed
#' @param new A character vector of with new names
#' @return A \code{TidySet} object
#' @family rename
#' @seealso \code{\link{name_sets}}
#' @export
setGeneric("rename_set", function(object, old, new) standardGeneric("rename_set"))

#' Rename elements
#'
#' Change the default names of sets and elements
#' @param object A TidySet object
#' @param old A character vector of to be renamed
#' @param new A character vector of with new names
#' @return A \code{TidySet} object
#' @family rename
#' @seealso \code{\link{name_elements}}
#' @export
setGeneric("rename_elements", function(object, old, new)
  standardGeneric("rename_elements"))


#' Name sets
#'
#' Retrieve the name of the sets
#' @param object A TidySet object
#' @param value A character with the new names for the sets
#' @return A \code{TidySet} object
#' @family name
#' @export
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b"),
#'                         elements = letters[seq_len(6)],
#'                         fuzzy = runif(6))
#' a <- tidySet(relations)
#' name_sets(a)
setGeneric("name_sets", function(object)
  standardGeneric("name_sets"))

#' Name elements
#'
#' Retrieve the name of the elements
#' @param object A TidySet object
#' @param value A character with the new names for the elements
#' @return A \code{TidySet} object
#' @family name
#' @export
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b"),
#'                         elements = letters[seq_len(6)],
#'                         fuzzy = runif(6))
#' a <- tidySet(relations)
#' name_elements(a)
setGeneric("name_elements", function(object)
  standardGeneric("name_elements"))

#' Rename elements
#'
#' Rename elements
#' @param object A TidySet object
#' @param value A character with the new names for the elements
#' @return A \code{TidySet} object
#' @family names
#' @seealso \code{\link{rename_elements}}
#' @export
#' @aliases name_elements<-
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b"),
#'                         elements = letters[seq_len(6)],
#'                         fuzzy = runif(6))
#' a <- tidySet(relations)
#' a
#' name_elements(a) <- letters[1:6]
setGeneric("name_elements<-", function(object, value)
  standardGeneric("name_elements<-"))

#' Rename sets
#'
#' Rename sets
#' @param object A TidySet object
#' @param value A character with the new names for the sets
#' @return A \code{TidySet} object
#' @family names
#' @seealso \code{\link{rename_set}}
#' @export
#' @aliases name_sets<-
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b"),
#'                         elements = letters[seq_len(6)],
#'                         fuzzy = runif(6))
#' a <- tidySet(relations)
#' a
#' name_sets(a) <- LETTERS[1:2]
setGeneric("name_sets<-", function(object, value)
  standardGeneric("name_sets<-"))

#' Add column
#'
#' Add column to a slot of the TidySet object
#' @param object A TidySet object
#' @param slot A TidySet slot
#' @param columns The columns to add
#' @return A \code{TidySet} object
#' @family column
#' @seealso \code{\link{rename_set}}
#' @export
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b"),
#'                         elements = letters[seq_len(6)],
#'                         fuzzy = runif(6))
#' a <- tidySet(relations)
#' add_column(a, "relations", data.frame(well = c("GOOD", "BAD", "WORSE", "UGLY",
#' "FOE", "HEY")))
setGeneric("add_column", function(object, slot, columns)
  standardGeneric("add_column"))

#' Remove column
#'
#' Removes column from a slot of the TidySet object
#' @param object A TidySet object
#' @param slot A TidySet slot
#' @param column_names The name of the columns
#' @return A \code{TidySet} object
#' @family column
#' @seealso \code{\link{rename_set}}
#' @export
setGeneric("remove_column", function(object, slot, column_names)
  standardGeneric("remove_column"))

#' Merge two sets
#'
#' Given a TidySets merges two sets into the new one.
#' @param object A TidySet object
#' @param set1,set2 The name of the sets to be used
#' @param setName The name of the new set
#' @param ... Other arguments
#' @return A \code{TidySet} object
#' @export
setGeneric("union", function(object, set1, set2, setName, ...)
  standardGeneric("union"))

#' Intersection of two sets
#'
#' Given a TidySets creates a new set with the elements on the both of them.
#' @inheritParams union
#' @param ... Other arguments
#' @return A \code{TidySet} object
#' @export
setGeneric("intersection", function(object, set1, set2, setName, ...)
  standardGeneric("intersection"))

#' Add a new set
#'
#' Given a TidySets merges two sets into the new one.
#' @param object A TidySet object
#' @param elements The elements of the sets.
#' @param setName The name of the new set.
#' @param fuzzy The membership of each element with the set.
#' @param ... Other arguments
#' @return A \code{TidySet} object
#' @export
setGeneric("add_set", function(object, elements, setName, fuzzy, ...)
  standardGeneric("add_set"))
