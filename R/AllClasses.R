#' @include validity.R
NULL

# S4 classes ###
#' A tidy class to represent a set
#'
#' A set is a group of unique elements it can be either a fuzzy set, where the
#' relationship is between 0 or 1 or nominal.
#'
#' When printed if an element or a set do not have any relationship is not
#' shown.
#' They can be created from lists, matrices or data.frames. Check [tidySet()]
#' constructor for more information.
#' @slot relations A data.frame with elements and the sets were they belong.
#' @slot elements A data.frame of unique elements and related information.
#' @slot sets A data.frame of unique sets and related information.
#' @aliases TidySet
#' @export
#' @seealso \link{tidySet}
#' @family methods
#' @examples
#' x <- list("A" = letters[1:5], "B" = LETTERS[3:7])
#' a <- tidySet(x)
#' a
#' x <- list("A" = letters[1:5], "B" = character())
#' b <- tidySet(x)
#' b
#' name_sets(b)
setClass(
    "TidySet",
    representation(
        elements = "data.frame",
        sets = "data.frame",
        relations = "data.frame"
    ),
    validity = is.valid
)
