#' @include AllClasses.R AllGenerics.R
NULL

#' Length of the TidySet
#'
#' Returns the number of sets in the object.
#' @param x A TidySet object.
#'
#' No replacement function is available, either delete sets or add them.
#' @return A numeric value.
#' @seealso [dim()], [ncol()] and [nrow()].
#' Also look at [lengths()] for the number of relations of sets.
#' @export
#' @examples
#' TS <- tidySet(list(A = letters[1:5], B = letters[6]))
#' length(TS)
length.TidySet <- function(x) {
    nSets(x)
}

#' Lengths of the TidySet
#'
#' Returns the number of relations of each set in the object.
#' @param x A TidySet object.
#' @param use.names A logical value whether to inherit names or not.
#'
#' @return A vector with the number of different relations for each set.
#' @seealso [length()], Use [set_size()] if you are using fuzzy sets.
#' @export
#' @examples
#' TS <- tidySet(list(A = letters[1:5], B = letters[6]))
#' lengths(TS)
setMethod("lengths", "TidySet",
          function(x, use.names = TRUE) {
              r <- relations(x)
              sets_elements <- paste0(r$sets, r$elements)
              names(sets_elements) <- r$sets
              d <- duplicated(sets_elements)
              td <- table(names(sets_elements)[!d])

              if (!use.names) {
                  names(td) <- NULL
              }

              # To convert the table to a named integer
              c(td)
          }
)
#' Probability of a vector of probabilities
#'
#' Calculates the probability that all probabilities happened simultaneously.
#' `independent_probabilities()` just multiply the probabilities of the index
#' passed.
#' @param p Numeric vector of probabilities.
#' @param i Numeric integer index of the complementary probability.
#' @return A numeric value of the probability.
#' @seealso [length_probability()]
#' @export
#' @examples
#' multiply_probabilities(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23), c(1, 3))
#' independent_probabilities(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23), c(1, 3))
multiply_probabilities <- function(p, i) {
    stopifnot(all(i > 0))
    stopifnot(all(p >= 0))
    if (length(i) == length(p)) {
        return(prod(p))
    } else if (length(i) == 0) {
        i <- seq_along(p)
    }
    prod(p[i], (1 - p)[-i])
}

#' @rdname multiply_probabilities
#' @export
independent_probabilities <- function(p, i) {
    stopifnot(all(i > 0))
    stopifnot(all(p >= 0))
    if (length(i) == length(p)) {
        return(prod(p))
    } else if (length(i) == 0) {
        i <- seq_along(p)
    }
    prod(p[i])
}

#' @rdname length_probability
#' @export
union_probability <- function(p) {
    l <- length(p)
    if (l == 1) {
        return(p)
    }
    n <- vapply(seq_len(l)[-1], function(x){
        sum(combn(seq_along(p), x, FUN = independent_probabilities, p = p))
    }, numeric(1L))
    sum(p) + sum(rep(c(-1, 1), length.out = length(n))*n)
}

#' Calculates the probability of a single length
#'
#' Creates all the possibilities and then add them up.
#' `union_probability` Assumes independence between the probabilities to
#' calculate the final size.
#' @param p Numeric vector of probabilities.
#' @param size Integer value of the size of the selected values.
#' @return A numeric value of the probability of the given size.
#' @seealso [multiply_probabilities()] and [length_set()]
#' @export
#' @examples
#' length_probability(c(0.5, 0.75), 2)
#' length_probability(c(0.5, 0.75, 0.66), 1)
#' length_probability(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23), 2)
#' union_probability(c(0.5, 0.1, 0.3))
length_probability <- function(p, size) {
    sum(combn(seq_along(p), size, FUN = multiply_probabilities, p = p))
}

#' Calculates the probability
#'
#' Given several probabilities it looks for how probable is to have a vector of
#' each length
#' @param probability A numeric vector of probabilities.
#' @return A vector with the probability of each set.
#' @seealso [length_probability()] to calculate the probability of a specific
#' length.
#' @export
#' @examples
#' length_set(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23))
length_set <- function(probability) {
    p1 <- probability == 1

    if (all(p1)) {
        out <- c(1)
        names(out) <- as.character(sum(probability))
        return(out) # Non fuzzy sets
    }
    if (all(probability == 0)) {
        max_length <- 0
    } else {
        max_length <- length(probability)
    }
    l <- seq(from = sum(p1), to = max_length)
    # Exclude those cases that are obvious
    l2 <- l - sum(p1)
    l2 <- l2[l2 != 0]
    v <- vapply(l2, length_probability, p = probability[!p1], numeric(1L))

    # Substitute in the original possibilities
    names(l) <- as.character(l)
    l[] <- 0
    l[as.character(l2 + sum(p1))] <- v
    l[as.character(sum(p1))] <- 1 - sum(v)
    l
}

# TODO Use matrix operations to simplify the process for large objects
#' @describeIn set_size Calculates the size of a set using [length_set()]
#' @export
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("A", 5), "B", "C"),
#'     elements = c(letters[seq_len(6)], letters[6]),
#'     fuzzy = runif(7)
#' )
#' a <- tidySet(relations)
#' set_size(a)
setMethod("set_size",
    signature = signature(object = "TidySet"),
    function(object, sets = NULL) {
        if (!all(sets %in% name_sets(object)) && !is.null(sets)) {
            stop("Please introduce valid set names. See name_sets",
                call. = FALSE
            )
        }
        if (is.null(sets)) {
            names_sets <- name_sets(object)
        } else {
            names_sets <- sets
        }

        rel <- relations(object)
        rel <- rel[rel$sets %in% names_sets, , drop = FALSE]
        missing <- names_sets[!names_sets %in% rel$sets]
        rel <- rel[, c("fuzzy", "elements", "sets")]

        if (length(missing) != 0) {
            missing <- data.frame(
                sets = missing, elements = NA,
                fuzzy = 0
            )
            rel <- rbind(rel, missing)
        }

        # Duplicate relationships with different information...
        # To filter to unique relationships
        if (anyDuplicated(rel) != 0) {
            rel <- unique(rel)
            rel <- droplevels(rel)
        }

        if (!all(rel$fuzzy == 1)) {
            fuzzy_values <- split(rel$fuzzy, rel$sets)
            sizes <- lapply(fuzzy_values, length_set)
            sets <- rep(names(fuzzy_values), lengths(sizes))
            lengths_set <- unlist(lapply(sizes, names), FALSE, FALSE)
            probability_length <- unlist(sizes, FALSE, FALSE)
        } else {
            sets <- names_sets
            lengths_set <- table(rel$sets)[names_sets]
            probability_length <- 1
        }
        # Empty set
        if (any(is.na(lengths_set))) {
            lengths_set[is.na(lengths_set)] <- 0
        }
        # Nothing is present
        if (is.null(lengths_set) && is.null(probability_length)) {
            sets <- names_sets
            lengths_set <- rep(0, length(sets))
            probability_length <- rep(1, length(sets))
        }
        out <- data.frame(
            sets = sets,
            size = as.numeric(lengths_set),
            probability = probability_length,
            stringsAsFactors = FALSE
        )
        out <- merge(out, sets(object), sort = FALSE)
        if (is.null(sets)) {
            out
        } else {
            out[sets %in% sets, , drop = FALSE]
        }
    }
)

#' @describeIn element_size Calculates the number of sets an element appears
#' with [length_set()]
#' @export
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("A", 5), "B", "C"),
#'     elements = c(letters[seq_len(6)], letters[6]),
#'     fuzzy = runif(7)
#' )
#' a <- tidySet(relations)
#' element_size(a)
setMethod("element_size",
    signature = signature(object = "TidySet"),
    function(object, elements = NULL) {
        if (!all(elements %in% name_elements(object)) && !is.null(elements)) {
            msg <- paste0(
                "Please introduce valid ",
                "element names. See element_names"
            )
            stop(msg, call. = FALSE)
        }

        # object <- droplevels(object)
        rel <- relations(object)
        if (is.null(elements)) {
            names_elements <- name_elements(object)
        } else {
            names_elements <- elements
        }

        rel <- rel[rel$elements %in% names_elements, , drop = FALSE]
        rel <- rel[, c("fuzzy", "elements", "sets")]
        missing <- names_elements[!names_elements %in% rel$elements]

        if (length(missing) != 0) {
            missing <- data.frame(
                sets = NA, elements = missing,
                fuzzy = 0
            )
            rel <- rbind(rel, missing)
        }

        # To filter to unique relationships
        if (anyDuplicated(rel) != 0) {
            rel <- unique(rel)
            rel <- droplevels(rel)
        }
        if (!all(rel$fuzzy == 1)) {
            fuzzy_values <- split(rel$fuzzy, rel$elements)
            sizes <- lapply(fuzzy_values, length_set)
            elements <- rep(names(fuzzy_values), lengths(sizes))
            lengths_set <- unlist(lapply(sizes, names), FALSE, FALSE)
            probability_length <- unlist(sizes, FALSE, FALSE)
        } else {
            elements <- names_elements
            lengths_set <- table(rel$elements)[names_elements]
            probability_length <- 1
        }
        # Empty group
        if (any(is.na(lengths_set))) {
            lengths_set[is.na(lengths_set)] <- 0
        }
        # Nothing is present
        if (is.null(lengths_set) && is.null(probability_length)) {
            elements <- names_elements
            lengths_set <- rep(0, length(elements))
            probability_length <- rep(1, length(elements))
        }

        out <- data.frame(
            elements = elements,
            size = as.numeric(lengths_set),
            probability = probability_length,
            stringsAsFactors = FALSE
        )
        out <- merge(out, elements(object), sort = FALSE)

        if (is.null(elements)) {
            out
        } else {
            out[elements %in% elements, , drop = FALSE]
        }
    }
)
