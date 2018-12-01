#' @include utilities.R
NULL

#' An S4 class to represent a set account.
#'
#' @slot elements A group of unique elements
#' @exportClass Set
#' @name Set
#' @rdname Set-class
setClass("Set",
         representation(elements = "ANY"),
         validity  = validate_set,
         prototype = prototype(elements = NA_character_)
)


setClass("SetCollection",
         representation(sets = "list")
)

# initialize
# https://github.com/variani/pckdev/wiki/Documenting-with-roxygen2#s4-classes??
