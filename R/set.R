#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn sets Retrieve the sets information
#' @export
setMethod("sets",
    signature = signature(object = "TidySet"),
    function(object) {
        slot(object, "sets")
    }
)

#' @describeIn sets Modify the sets information
#' @export
#' @examples
#' sets(TS) <- data.frame(sets = c("B", "A"))
setMethod("sets<-",
    signature = signature(object = "TidySet"),
    function(object, value) {
        slot(object, "sets") <- value
        validObject(object)
        object
    }
)

#' @rdname sets
#' @export
#' @examples
#' TS2 <- replace_sets(TS, data.frame(sets = c("A", "B", "C")))
#' sets(TS2)
replace_sets <- function(object, value) {
    UseMethod("replace_sets")
}

#' @export
#' @method replace_sets TidySet
replace_sets.TidySet <- function(object, value) {
    sets(object) <- value
    object
}

#' @describeIn sets Return the number of sets
#' @export
#' @examples
#' nSets(TS)
#' nSets(TS2)
setMethod("nSets",
    signature = signature(object = "TidySet"),
    function(object) {
        nrow(slot(object, "sets"))
    }
)
