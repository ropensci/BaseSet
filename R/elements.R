#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn elements Retrieve the elements
#' @export
setMethod("elements",
    signature = signature(object = "TidySet"),
    function(object) {
        slot(object, "elements")
    }
)

#' @describeIn elements Modify the elements
#' @export
#' @examples
#' elements(TS) <- data.frame(elements = letters[10:1])
setMethod("elements<-",
    signature = signature(object = "TidySet"),
    function(object, value) {
        slot(object, "elements") <- value
        validObject(object)
        object
    }
)

#' @rdname elements
#' @export
#' @examples
#' TS2 <- replace_elements(TS, data.frame(elements = letters[1:11]))
replace_elements <- function(object, value) {
    UseMethod("replace_elements")
}

#' @export
#' @method replace_elements TidySet
replace_elements.TidySet <- function(object, value) {
    elements(object) <- value
    object
}

#' @describeIn elements Return the number of elements
#' @export
#' @examples
#' nElements(TS)
#' nElements(TS2)
setMethod("nElements",
    signature = signature(object = "TidySet"),
    function(object) {
        nrow(slot(object, "elements"))
    }
)
