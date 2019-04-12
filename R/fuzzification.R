
fuzzy <- function(FUN, ...) {
  FUN <- match.fun(FUN)
  df <- FUN(...)
  stopifnot(is.data.frame(df))
  stopifnot(ncol(df) == 2)
  df
}

#' Transform a numeric value to a TidySet
#'
#' @param name Name of the set
#' @param FUN A function that returns a data.frame
#' @param ... Arguments passed to FUN
#' @return A TidySet object.
#' @export
fuzzification <- function(name, FUN, ...) {
  df <- fuzzy(FUN, ...)
  relations <- cbind(df, sets = name)
  tidySet(relations)
}

#' Add a new set
#'
#' Given a numeric value and a function adds a new set to the TidySet object.
#' @param object A TidySet object.
#' @inheritParams fuzzification
#' @return A TidySet object with the new set.
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
