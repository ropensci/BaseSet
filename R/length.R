length_helper <- function(p, i) {
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

length_helper2 <- function(p, n) {
  i <- combn_indices(x = p, m = n)
  sum(vapply(i, length_helper, p = p, numeric(1L)))
}

length <- function(set) {
  p1 <- set == 1
  if (all(p1)) {
    return(base::length(set)) # Non fuzzy sets
  }

  p <- set[!p1 && set != 0]
  l <- seq(from = 1, to = base::length(p))
  v <- vapply(l, length_helper2, p = p, numeric(1L))

  names(v) <- as.character(l+sum(p1))
  v
}


combn_indices <- function (x, m) {
  stopifnot(base::length(m) == 1L, is.numeric(m))
  if (m < 0)
    stop("m < 0", domain = NA)
  if (is.numeric(x) && base::length(x) == 1L && x > 0 && trunc(x) ==
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

