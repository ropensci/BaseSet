#' @include AllClasses.R AllGenerics.R
NULL

#' Calculates the probabilities
#'
#' Calculates the probability that all happened simultaneously
#' @param p Probabilities
#' @param i Index of the complementary probability
#' @return  The log10 of the probability
#' @keywords internal
# multiply_probabilities(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23), c(1, 3))
multiply_probabilities <- function(p, i) {

    if (length(i) == length(p)) {
        return(prod(p))
    } else if (length(i) == 0) {
        i <- seq_along(p)
    }
    a <- prod(p[-i])
    b <- prod((1 - p)[i])
    a*b
}


# From the soucre code of combn
# (with some modifications because a function cannot be passed along)
#' Title
#'
#' @param x An integer.
#' @param m number of elements to choose.
#'
#' @return A list of indices
#' @keywords internal
# combn_indices(5, 2)
combn_indices <- function(x, m) {
    stopifnot(length(m) == 1L, is.numeric(m))
    if (m < 0)
        stop("m < 0", domain = NA, call. = FALSE)
    if (is.numeric(x) && length(x) == 1L && x > 0 && trunc(x) == x)
        x <- seq_len(x)
    n <- base::length(x)
    if (n < m)
        stop("n < m", domain = NA, call. = FALSE)

    m <- as.integer(m)
    e <- 0
    h <- m
    a <- seq_len(m)
    count <- as.integer(round(choose(n, m)))

    out <- vector("list", count)
    out[[1L]] <- a

    if (m > 0) {
        i <- 2L
        nmmp1 <- n - m + 1L
        while (a[1L] != nmmp1) {
            if (e < n - h) {
                h <- 1L
                e <- a[m]
                j <- 1L
            }
            else {
                e <- a[m - h]
                h <- h + 1L
                j <- 1L:h
            }
            a[m - h + j] <- e + j
            out[[i]] <- a
            i <- i + 1L
        }
    }
    out
}

#' Calculates the probability of a single length
#'
#' Creates all the possibilities and then add them up.
#' @param p Probabilities
#' @param n Size
#' @return A numeric value of the probability of the given size
#' @export
#' @keywords internal
# length_probability(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23), 2)
length_probability <- function(p, n) {
    i <- combn_indices(x = length(p), m = n)
    out <- vapply(i, multiply_probabilities, p = p, numeric(1L))
    sum(out)
}


#' Calculates the probability
#'
#' Given several probabilities it looks for how probable is to have a vector of
#' each length
#' @param fuzziness The probabilities
#' @return A vector with the probability of each set
#' @export
#' @examples
#' length_set(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23))
length_set <- function(fuzziness) {
    p1 <- fuzziness == 1

    if (all(p1)) {
        out <- c(1)
        names(out) <- as.character(sum(fuzziness))
        return(out) # Non fuzzy sets
    }

    l <- seq(from = sum(p1), to = length(fuzziness))
    # Exclude those cases that are obvious
    l2 <- l - sum(p1)
    l2 <- l2[l2 != 0]
    v <- vapply(l2, length_probability, p = fuzziness[!p1], numeric(1L))

    # Substitute in the original possibilities
    names(l) <- as.character(l)
    l[] <- 0
    l[as.character(l2 + sum(p1))] <- v
    l[as.character(sum(p1))] <- 1 - sum(v)
    l
}

#' @describeIn set_size Calculates the size of a set either fuzzy or not
#' @export
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
#'                         elements = c(letters[seq_len(6)], letters[6]),
#'                         fuzzy = runif(7))
#' a <- tidySet(relations)
#' set_size(a)
setMethod("set_size",
          signature = signature(object = "TidySet"),
          function(object, set = NULL) {

              if (!set %in% name_sets(object) && !is.null(set)) {
                  stop("Please introduce valid set names. See name_sets",
                       call. = FALSE)
              }
              # object <- droplevels(object)
              rel <- relations(object)
              if (is.null(set)) {
                  names_sets <- name_sets(object)
              } else {
                  names_sets <- set
                  rel <- rel[rel$sets %in% set, ]
              }

              # Duplicate relationships with different information...
              rel <- unique(rel[, c("fuzzy", "elements", "sets")])

              if (is.fuzzy(object)) {

                  fuzzy_values <- split(rel$fuzzy, rel$sets)
                  sizes <- lapply(fuzzy_values, length_set)
                  sets <- rep(unique(rel$sets), lengths(sizes))
                  lengths_set <- unlist(lapply(sizes, names), use.names = FALSE)
                  probability_length <- unlist(sizes, use.names = FALSE)
              } else {
                  sets <- names_sets
                  lengths_set <- table(rel$sets)[names_sets]
                  probability_length <- 1
              }

              if (any(is.na(lengths_set))) {
                  lengths_set[is.na(lengths_set)] <- 0
              }

              out <- data.frame(sets = sets,
                                size = as.numeric(lengths_set),
                                probability = probability_length)
              out <- merge(out, sets(object), sort = FALSE)
              if (is.null(set)) {
                  out
              } else {
                  out[sets %in% set, ]
              }
          }
)

#' @describeIn element_size Calculates the number of sets one element appears
#' @export
#' @examples
#' relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
#'                         elements = c(letters[seq_len(6)], letters[6]),
#'                         fuzzy = runif(7))
#' a <- tidySet(relations)
#' element_size(a)
setMethod("element_size",
          signature = signature(object = "TidySet"),
          function(object, element = NULL) {
              if (!element %in% name_elements(object) && !is.null(element)) {
                  stop("Please introduce valid element names. See element_names",
                       call. = FALSE)
              }
              # object <- droplevels(object)
              rel <- relations(object)
              if (is.null(element)) {
                  names_elements <- name_elements(object)
              } else {
                  names_elements <- element
                  rel <- rel[rel$elements %in% element, ]
              }

              # To filter to unique relationships
              rel <- unique(rel[, c("fuzzy", "elements", "sets")])

              if (is.fuzzy(object)) {
                  fuzzy_values <- split(rel$fuzzy, rel$elements)
                  sizes <- lapply(fuzzy_values, length_set)
                  elements <- rep(unique(rel$elements), lengths(sizes))
                  lengths_set <- unlist(lapply(sizes, names), use.names = FALSE)
                  probability_length <- unlist(sizes, use.names = FALSE)
              } else {
                  elements <- names_elements
                  lengths_set <- table(rel$elements)[names_elements]
                  probability_length <- 1
              }

              if (any(is.na(lengths_set))) {
                  lengths_set[is.na(lengths_set)] <- 0
              }

              out <- data.frame(elements = elements,
                                size = as.numeric(lengths_set),
                                probability = probability_length)
              out <- merge(out, elements(object), sort = FALSE)

              if (is.null(element)) {
                  out
              } else {
                  out[elements %in% element, ]
              }
          }
)

