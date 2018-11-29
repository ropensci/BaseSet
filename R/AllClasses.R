#' An S4 class to represent a set account.
#'
#' @slot elements A group of unique elements
#' @include utilities.R
setClass("Set",
         representation(elements = "character"),
         validity  = validate_set,
         prototype = prototype(elements = NA_character_)
)


setClass("SetCollection",
         representation(sets = "list")
)
