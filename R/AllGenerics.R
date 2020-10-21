#' @include AllClasses.R
#' @importFrom methods setGeneric
#' @importFrom methods as
#' @importFrom methods new
#' @importFrom methods slot
#' @importFrom methods slot<-
#' @importFrom methods validObject
#' @importFrom methods show
NULL

#' Elements of the TidySet
#'
#' Given TidySet retrieve the elements or substitute them.
#' @param object A TidySet object.
#' @param value Modification of the elements.
#' @return A \code{data.frame} with information about the elements
#' @export elements
#' @seealso \code{\link{nElements}}
#' @family slots
#' @family methods
#' @aliases elements<-
#' @examples
#' TS <- tidySet(list(A = letters[1:5], B = letters[2:10]))
#' elements(TS)
methods::setGeneric("elements", function(object) setGeneric("elements"))

#' Sets of the TidySet
#'
#' Given TidySet retrieve the sets or substitute them.
#' @param object A \code{SetCollection} object.
#' @param value Modification of the sets.
#' @return A \code{data.frame} with information from the sets.
#' @export sets
#' @aliases sets<-
#' @seealso \code{\link{nSets}}
#' @family slots
#' @family methods
#' @examples
#' TS <- tidySet(list(A = letters[1:5], B = letters[2:10]))
#' sets(TS)
methods::setGeneric("sets", function(object) standardGeneric("sets"))

#' Check if a TidySet is fuzzy.
#'
#' Check if there are fuzzy sets. A fuzzy set is a set where the relationship
#' between elements is given by a probability (or uncertainty).
#' @param object Object to be coerced or tested.
#' @return A logical value.
#' @export is.fuzzy
#' @family methods
#' @examples
#' TS <- tidySet(list(A = letters[1:5], B = letters[2:10]))
#' is.fuzzy(TS)
methods::setGeneric("is.fuzzy", function(object) standardGeneric("is.fuzzy"))

#' Number of sets
#'
#' Check the number of sets of the TidySet
#' @param object Object to be coerced or tested.
#' @export nSets
#' @family count functions
#' @family methods
#' @return The number of sets present.
#' @examples
#' TS <- tidySet(list(A = letters[1:2], B = letters[5:7]))
#' nSets(TS)
methods::setGeneric("nSets", function(object) standardGeneric("nSets"))

#' Number of elements
#'
#' Check the number of elements of the TidySet.
#' @param object Object to be coerced or tested.
#' @return A numeric value with the number of elements.
#' @export nElements
#' @family count functions
#' @family methods
#' @examples
#' TS <- tidySet(list(A = letters[1:2], B = letters[5:7]))
#' nElements(TS)
methods::setGeneric("nElements", function(object) standardGeneric("nElements"))

#' Number of relations
#'
#' Check the number of relations of the TidySet.
#' @param object Object to be coerced or tested.
#' @return A numeric value with the number of the relations.
#' @export nRelations
#' @family count functions
#' @family methods
#' @examples
#' TS <- tidySet(list(A = letters[1:2], B = letters[5:7]))
#' nRelations(TS)
methods::setGeneric("nRelations", function(object)
  standardGeneric("nRelations")
)

#' Incidence
#'
#' Check which elements are in which sets.
#' @param object Object to be coerced or tested.
#' @export incidence
#' @family methods
#' @seealso \code{\link{adjacency}}
methods::setGeneric("incidence", function(object) standardGeneric("incidence"))

#' Relations of the TidySet
#'
#' Given TidySet retrieve the relations or substitute them.
#' \code{\link{TidySet}} object
#' @param object Object to be coerced or tested.
#' @param value Modification of the relations.
#' @return A \code{data.frame} with information about the relations between
#' elements and sets.
#' @family slots
#' @family methods
#' @seealso \code{\link{nRelations}}
#' @export
#' @examples
#' TS <- tidySet(list(A = letters[1:2], B = letters[5:7]))
#' relations(TS)
methods::setGeneric("relations", function(object) standardGeneric("relations"))

#' @rdname relations
#' @export
methods::setGeneric("relations<-", function(object, value)
      standardGeneric("relations<-")
)

#' @rdname elements
#' @export
methods::setGeneric("elements<-", function(object, value)
  standardGeneric("elements<-"))

#' @rdname sets
#' @export
methods::setGeneric("sets<-", function(object, value)
  standardGeneric("sets<-"))

#' Calculates the size of a set
#'
#' Assuming that the fuzzy values are probabilities,
#' calculates the probability of being of different sizes for a given set.
#' @param object A TidySet object.
#' @param sets The sets from which the length is calculated.
#' @return A list with the size of the set or the probability of having that
#' size.
#' @export set_size
#' @seealso cardinality
#' @family sizes
#' @family methods
methods::setGeneric("set_size", function(object, sets = NULL)
  standardGeneric("set_size"))

#' Calculates the size of the elements
#'
#' Assuming that the fuzzy values are probabilities, calculates the probability
#' of being of different sizes for a given set.
#' @param object A TidySet object.
#' @param elements The element from which the length is calculated.
#' @return A list with the size of the elements or the probability of having
#' that size.
#' @family sizes
#' @seealso cardinality
#' @export element_size
#' @family methods
methods::setGeneric("element_size", function(object, elements = NULL)
      standardGeneric("element_size")
)

#' Rename sets
#'
#' Change the default names of sets and elements.
#' @param object A TidySet object.
#' @param old A character vector of to be renamed.
#' @param new A character vector of with new names.
#' @return A \code{TidySet} object.
#' @family renames
#' @family names
#' @seealso \code{\link{name_sets}}
#' @export
#' @family methods
#' @examples
#' x <- list("A" = letters[1:5], "B" = letters[3:7])
#' TS <- tidySet(x)
#' name_sets(TS)
#' TS2 <- rename_set(TS, "A", "C")
#' name_sets(TS2)
methods::setGeneric("rename_set", function(object, old, new)
      standardGeneric("rename_set")
)

#' Rename elements
#'
#' Change the default names of sets and elements.
#' @param object A TidySet object.
#' @param old A character vector of to be renamed.
#' @param new A character vector of with new names.
#' @return A \code{TidySet} object.
#' @family renames
#' @family names
#' @seealso \code{\link{name_elements}}
#' @export
#' @family methods
#' @examples
#' x <- list("A" = letters[1:5], "B" = letters[3:7])
#' TS <- tidySet(x)
#' name_elements(TS)
#' TS2 <- rename_elements(TS, "a", "first")
#' name_elements(TS2)
methods::setGeneric("rename_elements", function(object, old, new)
      standardGeneric("rename_elements")
)

#' Name sets
#'
#' Retrieve the name of the sets.
#' @param object A TidySet object.
#' @param value A character with the new names for the sets.
#' @return A \code{TidySet} object.
#' @family names
#' @family methods
#' @export
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("A", 5), "B"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' TS <- tidySet(relations)
#' name_sets(TS)
methods::setGeneric("name_sets", function(object)
      standardGeneric("name_sets")
)

#' Name elements
#'
#' Retrieve the name of the elements.
#' @param object A TidySet object.
#' @param value A character with the new names for the elements.
#' @return A \code{TidySet} object.
#' @family names
#' @export
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("A", 5), "B"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' TS <- tidySet(relations)
#' name_elements(TS)
methods::setGeneric("name_elements", function(object)
      standardGeneric("name_elements")
)

#' Rename elements
#'
#' Rename elements.
#' @param object A TidySet object.
#' @param value A character with the new names for the elements.
#' @return A \code{TidySet} object.
#' @family names
#' @family methods
#' @seealso \code{\link{rename_elements}}
#' @export
#' @aliases name_elements<-
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("A", 5), "B"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' TS <- tidySet(relations)
#' TS
#' name_elements(TS) <- letters[1:6]
methods::setGeneric("name_elements<-", function(object, value)
      standardGeneric("name_elements<-")
)

#' Rename sets
#'
#' Rename sets.
#' @param object A TidySet object.
#' @param value A character with the new names for the sets.
#' @return A \code{TidySet} object.
#' @family names
#' @family methods
#' @seealso \code{\link{rename_set}}
#' @export
#' @aliases name_sets<-
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("a", 5), "b"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' TS <- tidySet(relations)
#' TS
#' name_sets(TS) <- LETTERS[1:2]
methods::setGeneric("name_sets<-", function(object, value)
      standardGeneric("name_sets<-")
)

#' Add column
#'
#' Add column to a slot of the TidySet object.
#' @param object A TidySet object.
#' @param slot A TidySet slot.
#' @param columns The columns to add.
#' @return A \code{TidySet} object.
#' @family column
#' @family methods
#' @seealso \code{\link{rename_set}}
#' @export
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("a", 5), "b"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' TS <- tidySet(relations)
#' add_column(TS, "relations", data.frame(well = c(
#'     "GOOD", "BAD", "WORSE",
#'     "UGLY", "FOE", "HEY"
#' )))
methods::setGeneric("add_column", function(object, slot, columns)
      standardGeneric("add_column")
)

#' Remove column
#'
#' Removes column from a slot of the TidySet object.
#' @param object A TidySet object.
#' @param slot A TidySet slot.
#' @param column_names The name of the columns.
#' @return A \code{TidySet} object.
#' @family column
#' @family methods
#' @seealso \code{\link{rename_set}}
#' @export
#' @examples
#' x <- data.frame(sets = c(rep("A", 5), rep("B", 5)),
#'                 elements = c(letters[1:5], letters[3:7]),
#'                 extra = sample(c("YES", "NO"), 10, replace = TRUE))
#' TS <- tidySet(x)
#' TS
#' remove_column(TS, "relations", "extra")
methods::setGeneric("remove_column", function(object, slot, column_names)
      standardGeneric("remove_column")
)

#' Intersection of two or more sets
#'
#' Given a TidySet creates a new set with the elements on the both of them
#' following the logic defined on FUN.
#'
#' #' The default uses the `min` function following the [standard fuzzy
#' definition](https://doi.org/10.1016/S0019-9958(65)90241-X), but it can be
#' changed.
#' @param sets The character of sets to be intersect.
#' @param name The name of the new set. By defaults joins the sets with an
#' \ifelse{latex}{\out{$\cup$}}{\ifelse{html}{\out{&cup;}}{}}.
#' @inheritParams union
#' @param FUN A function to be applied when performing the union.
#' The standard intersection is the "min" function, but you can provide any
#' other function that given a numeric vector returns a single number.
#' @param keep A logical value if you want to keep originals sets.
#' @param ... Other named arguments passed to `FUN`.
#' @return A \code{TidySet} object.
#' @export
#' @family methods that create new sets
#' @family methods
#' @aliases intersect
#' @examples
#' rel <- data.frame(
#'     sets = c(rep("A", 5), "B"),
#'     elements = c("a", "b", "c", "d", "f", "f")
#' )
#' TS <- tidySet(rel)
#' intersection(TS, c("A", "B")) # Default Name
#' intersection(TS, c("A", "B"), "C") # Set the name
#' # Fuzzy set
#' rel <- data.frame(
#'     sets = c(rep("A", 5), "B"),
#'     elements = c("a", "b", "c", "d", "f", "f"),
#'     fuzzy = runif(6)
#' )
#' TS2 <- tidySet(rel)
#' intersection(TS2, c("A", "B"), "C")
#' intersection(TS2, c("A", "B"), "C", FUN = function(x){max(sqrt(x))})
methods::setGeneric("intersection", function(object, sets, ...)
      standardGeneric("intersection")
)

#' Add relations
#'
#' Given a TidySet adds new relations between elements and sets.
#' @param object A TidySet object
#' @param relations A data.frame object
#' @param ... Placeholder for other arguments that could be passed to the
#' method. Currently not used.
#' @return A \code{TidySet} object.
#' @family add functions
#' @export
#' @family methods
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("A", 5), "B"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' TS <- tidySet(relations)
#' relations <- data.frame(
#'     sets = c(rep("A2", 5), "B2"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6),
#'     new = runif(6)
#' )
#' add_relation(TS, relations)
methods::setGeneric("add_relation", function(object, relations, ...)
      standardGeneric("add_relation")
)

#' Remove a relation
#'
#' Given a TidySet removes relations between elements and sets
#' @param object A TidySet object
#' @param elements The elements of the sets.
#' @param sets The name of the new set.
#' @param ... Placeholder for other arguments that could be passed to the
#' method. Currently not used.
#' @return A \code{TidySet} object.
#' @family remove functions
#' @family methods
#' @export
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("A", 5), "B"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' TS <- tidySet(relations)
#' remove_relation(TS, "A", "a")
methods::setGeneric("remove_relation", function(object, elements, sets, ...)
      standardGeneric("remove_relation")
)

#' Remove elements
#'
#' Given a TidySet remove elements and the related relations and if
#' required also the sets.
#' @param object A TidySet object.
#' @param elements The elements to be removed.
#' @param ... Placeholder for other arguments that could be passed to the
#' method. Currently not used.
#' @return A \code{TidySet} object.
#' @export
#' @family remove functions
#' @family methods
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("A", 5), "B"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' TS <- tidySet(relations)
#' remove_element(TS, "c")
methods::setGeneric("remove_element", function(object, elements, ...)
      standardGeneric("remove_element")
)

#' Remove sets
#'
#' Given a TidySet remove sets and the related relations and if
#' required also the elements
#' @param object A TidySet object.
#' @param sets The sets to be removed.
#' @param ... Placeholder for other arguments that could be passed to the
#' method. Currently not used.
#' @return A \code{TidySet} object.
#' @export
#' @family remove functions
#' @family methods
#' @examples
#' relations <- data.frame(
#'     sets = c("A", "A", "B", "B", "C", "C"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' TS <- tidySet(relations)
#' remove_set(TS, "B")
methods::setGeneric("remove_set", function(object, sets, ...)
      standardGeneric("remove_set")
)

#' Complement of a set
#'
#' Return the complement for a set
#' @param object A TidySet object.
#' @param sets The name of the set to look for the complement.
#' @param keep Logical value to keep all the other sets.
#' @param name Name of the new set. By default it adds a "C".
#' @param ... Placeholder for other arguments that could be passed to the
#' method. Currently not used.
#' @inheritParams union
#' @return A \code{TidySet} object.
#' @family complements
#' @family methods that create new sets
#' @family methods
#' @seealso \code{\link{filter}}
#' @export
#' @examples
#' relations <- data.frame(
#'     sets = c("A", "A", "B", "B", "C", "C"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' TS <- tidySet(relations)
#' complement_set(TS, "A")
methods::setGeneric("complement_set", function(object, sets, ...)
      standardGeneric("complement_set")
)

#' Cardinality or membership of sets
#'
#' Calculates the membership of sets according to the logic defined in FUN.
#' @param object A TidySet object.
#' @param sets Character vector with the name of the sets.
#' @export
#' @seealso [size()]
#' @examples
#' rel <- list(A = letters[1:3], B = letters[1:2])
#' TS <- tidySet(rel)
#' cardinality(TS, "A")
methods::setGeneric("cardinality", function(object, sets = NULL, ...)
  standardGeneric("cardinality")
)

#' Complement of elements
#'
#' Return the objects without the elements listed
#' @param object A TidySet object.
#' @param elements The set to look for the complement.
#' @inheritParams complement_set
#' @return A \code{TidySet} object.
#' @family complements
#' @family methods that create new sets
#' @family methods
#' @export
#' @examples
#' relations <- data.frame(
#'     sets = c("A", "A", "B", "B", "C", "C"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' TS <- tidySet(relations)
#' complement_element(TS, "a", "C_a")
#' complement_element(TS, "a", "C_a", keep = FALSE)
methods::setGeneric("complement_element", function(object, elements, ...)
      standardGeneric("complement_element")
)

#' Subtract
#'
#' Elements in a set not present in the other set. Equivalent to
#' \code{\link{setdiff}}.
#' @param object A TidySet object.
#' @param set_in Name of the sets where the elements should be present.
#' @param not_in Name of the sets where the elements should not be present.
#' @inheritParams complement_set
#' @return A \code{TidySet} object.
#' @family complements
#' @family methods that create new sets
#' @family methods
#' @seealso \code{\link{setdiff}}
#' @export
#' @examples
#' relations <- data.frame(
#'     sets = c("A", "A", "B", "B", "C", "C"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' TS <- tidySet(relations)
#' subtract(TS, "A", "B")
#' subtract(TS, "A", "B", keep = FALSE)
methods::setGeneric("subtract", function(object, set_in, not_in, ...)
      standardGeneric("subtract")
)

#' Move columns between slots
#'
#' Moves information from one slot to other slots.
#' For instance from the sets to the relations.
#' @param object A TidySet object.
#' @param from The name of the slot where the content is.
#' @param to The name of the slot to move the content.
#' @param columns The name of the columns that should be moved.
#' @return A TidySet object where the content is moved from one slot to other.
#' @family methods
#' @examples
#' x <- list("A" = c("a" = 0.1, "b" = 0.5), "B" = c("a" = 0.2, "b" = 1))
#' TS <- tidySet(x)
#' TS <- mutate_element(TS, b = runif(2))
#' TS2 <- move_to(TS, from = "elements", to = "relations", "b")
#' # Note that apparently we haven't changed anything:
#' TS2
methods::setGeneric("move_to", function(object, from, to, columns)
      standardGeneric("move_to")
)
