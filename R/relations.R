#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn relations Retrieve the relations
#' @export
setMethod("relations",
    signature = signature(object = "TidySet"),
    function(object) {
        slot(object, "relations")
    }
)

#' @rdname relations
#' @export
replace_relations <- function(object, value) {
    UseMethod("replace_relations")
}

#' @export
#' @method replace_relations TidySet
replace_relations.TidySet <- function(object, value) {
    relations(object) <- value
}

#' @describeIn relations Modify the relations
#' @export
setMethod("relations<-",
    signature = signature(object = "TidySet"),
    function(object, value) {
        slot(object, "relations") <- value
        validObject(object)
        object
    }
)

`.relations<-` <- function(object, value) {
    slot(object, "relations") <- value
}

#' @describeIn relations Return the number of unique relations
#' @export
setMethod("nRelations",
    signature = signature(object = "TidySet"),
    function(object) {
        r <- slot(object, "relations")
        nrow(unique(r[, c("sets", "elements")]))
    }
)

#' @describeIn is.fuzzy Check if it is fuzzy
#' @export
setMethod("is.fuzzy",
    signature = signature(object = "TidySet"),
    function(object) {
        if (all(relations(object)$fuzzy == 1)) {
            FALSE
        } else {
            TRUE
        }
    }
)
