
fuzzy <- function(FUN, ...) {
  FUN <- match.fun(FUN)
  df <- FUN(...)
  stopifnot(is.array(df))
  stopifnot(ncol(df) == 2)
  df
}

#' @export
fuzzification <- function(name, FUN, ...) {
  df <- fuzzy(FUN, ...)
  relations <- cbind(df, sets = name)
  tidySet(relations)
}

#' @export
add_fuzzification <- function(object, name, FUN, ...) {
  df <- fuzzy(FUN, ...)
  replace_interactions(object, df, keep = TRUE)
}

# Given a function and a column of the elements runs through it and creates
# new sets.
#  Say we store the DE of an analysis but we want to test if which threshold is
# better we run the function for several thresholds and evaluate which set has
# less known functionality
