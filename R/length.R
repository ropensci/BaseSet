#' @include AllClasses.R AllGenerics.R
NULL

#' Calculates the probabilities
#'
#' Calculates the probability that all happened simultaneously
#' @param p Probabilities
#' @param i Index of the complemetary probability
#' @keywords internal
multiply_probabilities <- function(p, i) {
  a <- prod(p[-i])
  b <- prod((1-p)[i])
  if (is.null(a) && is.null(b)) {
    0
  } else if (is.null(a)) {
    b
  } else if (is.null(b)) {
    a
  } else {
    a*b
  }
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
combn_indices <- function (x, m) {
  stopifnot(length(m) == 1L, is.numeric(m))
  if (m < 0)
    stop("m < 0", domain = NA)
  if (is.numeric(x) && length(x) == 1L && x > 0 && trunc(x) ==
      x)
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
length_probability <- function(p, n) {
  i <- combn_indices(x = length(p), m = n)
  sum(vapply(i, multiply_probabilities, p = p, numeric(1L)))
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
    return(length(fuzziness)) # Non fuzzy sets
  }

  p <- fuzziness[!p1 && fuzziness != 0]
  l <- seq(from = 1, to = length(p))
  v <- vapply(l, length_probability, p = p, numeric(1L))

  names(v) <- as.character(l + sum(p1))
  v
}

#' Set size
#'
#' Calculates the size of a set either fuzzy or not
#' @param set A set of class \code{Set}
#' @return A vector with the length of the set and its probability
#' @export
setMethod("set_size",
          signature = signature(object = "TidySet"),
          function(object, set) {

            rel <- relations(object)
            out <- lapply(set, function(x){
              length_set(rel[rel$sets == x, "fuzzy"])
            })
            names(out) <- set
            # TODO return a matrix or a consistent data format
            # Probably a matrix
            out
          }
)
