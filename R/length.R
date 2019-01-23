#' @include AllClasses.R AllGenerics.R
NULL

#' Calculates the probabilities
#'
#' Calculates the probability that all happened simultaneously
#' @param p Probabilities
#' @param i Index of the complemetary probability
#' @return  The log10 of the probability
#' @keywords interna
#' @examples
#' multiply_probabilities(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23), c(1, 3))
multiply_probabilities <- function(p, i) {

  if (length(i) == length(p)) {
    return(prod(p))
  } else if (length(i) == 0) {
    i <- seq_along(p)
  }
  a <- p[-i]
  b <- (1 - p)[i]
  prod(a[a != 0]) * prod(b[b != 0])
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
#' @examples
#' combn_indices(5, 2)
combn_indices <- function(x, m) {
  stopifnot(length(m) == 1L, is.numeric(m))
  if (m < 0)
    stop("m < 0", domain = NA)
  if (is.numeric(x) && length(x) == 1L && x > 0 && trunc(x) == x)
    x <- seq_len(x)
  n <- base::length(x)
  if (n < m)
    stop("n < m", domain = NA)

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
#' @examples
#' length_probability(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23), 2)
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

  l <- seq(from = sum(fuzziness == 1), to = length(fuzziness))
  v <- vapply(l, length_probability, p = fuzziness, numeric(1L))

  names(v) <- as.character(l)
  v
}

#' @describeIn set_size Calculates the size of a set either fuzzy or not
#' @export
setMethod("set_size",
          signature = signature(object = "TidySet"),
          function(object, set = NULL) {

            if (!set %in% name_sets(object) && !is.null(set)) {
              stop("Please introduce valid element names. See name_sets")
            }
            rel <- relations(object)
            if (is.null(set)) {
              names_sets <- name_sets(object)
            } else {
              names_sets <- set
            }
            sizes <- lapply(names_sets, function(x){
              length_set(rel[rel$sets == x, "fuzzy"])
            })

            sets <- rep(names_sets, lengths(sizes))
            lengths_set <- unlist(lapply(sizes, names), use.names = FALSE)
            probability_length <- unlist(sizes, use.names = FALSE)
            out <- data.frame(set = sets,
                       size = as.numeric(lengths_set),
                       probability = probability_length)
            if (is.null(set)) {
              out
            } else {
              out[sets %in% set, ]
            }
          }
)

#' @describeIn element_size Calculates the number of sets one element appears
#' @export
setMethod("element_size",
          signature = signature(object = "TidySet"),
          function(object, element = NULL) {

            if (!element %in% name_elements(object) && !is.null(element)) {
              stop("Please introduce valid element names. See element_names")
            }
            out <- rowsum(rep(1, nRelations(object)),
                   relations(object)$elements)
            if (is.null(element)) {
              out[, 1]
              data.frame(element = rownames(out), size = out[, 1],
                         probability = 1)
            } else {
              data.frame(element = element, size = out[, 1][element],
                         probability = 1)
            }
          }
)

