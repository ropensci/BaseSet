#' @include AllClasses.R
NULL

#' Method to show the TidySet object
#'
#' Prints the resulting table of a TidySet object. Does not shown elements or
#' sets without any relationship (empty sets). To see them use [sets()] or
#' [elements()].
#' @param object A TidySet
#'
#' @return A table with the information of the relationships.
#' @export
setMethod("show",
    signature = signature(object = "TidySet"),
    function(object) {
        validObject(object)
        o <- as.data.frame(object)
        print(o)
    }
)
