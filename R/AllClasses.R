#' @include utilities.R
NULL

#' A class to represent a set
#'
#' A set is a group of unique elements it can be either a fuzzy set, where the
#' relationship is between 0 or 1 or nominal
#' @slot elements A group of unique elements
#' @export
setClass("Set",
         representation(elements = "ANY"),
         validity  = validate_set,
         prototype = prototype(elements = NA_character_)
)

#' A class to represent a group of sets
#'
#' Several sets together form a collection
#' @slot sets A group of unique sets
#' @export
setClass("SetCollection",
         representation(sets = "list")
)

# initialize
# https://github.com/variani/pckdev/wiki/Documenting-with-roxygen2#s4-classes??
