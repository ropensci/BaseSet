#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn name_sets Name sets
#' @export name_sets
setMethod("name_sets",
    signature = signature(object = "TidySet"),
    function(object) {
        s <- sets(object)$sets
        if (is.factor(s)) {
            levels(s)
        } else if (is.character(s)) {
            s
        }
    }
)

#' @describeIn name_elements Name elements
#' @export name_elements
setMethod("name_elements",
    signature = signature(object = "TidySet"),
    function(object) {
        e <- elements(object)$elements
        if (is.factor(e)) {
            levels(e)
        } else if (is.character(e)) {
            e
        }
    }
)

#' @describeIn name_elements Rename elements
#' @export name_elements<-
setMethod("name_elements<-",
    signature = signature(
        object = "TidySet",
        value = "characterORfactor"
    ),
    function(object, value) {
        old <- name_elements(object)

        if (is.factor(value)) {
            value <- as.character(value)
        }

        elements <- elements(object)
        if (is.factor(elements$elements)) {
            levels(elements$elements) <- value
        }
        if (length(value) == length(old)) {
            elements$elements <- value
        } else if (length(value) > length(old)) {
            stop("More elements provided than existing.\n\t",
                 "Use add_elements() if you want to add elements.",
                 call. = FALSE)
        } else {
            stop("Less names provided than existing.\n\t",
                 "Use filter() if you want to remove some elements",
                 call. = FALSE)
        }

        object@elements <- unique(elements)
        if (anyDuplicated(object@elements$elements) > 0) {
            stop("Duplicated elements but with different information",
                call. = FALSE
            )
        }

        old_relations <- object@relations$elements
        if (is.factor(old_relations)) {
            old_relations <- levels(old_relations)
            replace <- match(old_relations, old)
            levels(object@relations$elements) <- value[replace]
        } else {
            replace <- match(old_relations, old)
            object@relations$elements <- value[replace]
        }

        validObject(object)
        object
    }
)
#' @describeIn name_sets Rename sets
#' @export name_sets<-
setMethod("name_sets<-",
    signature = signature(
        object = "TidySet",
        value = "characterORfactor"
    ),
    function(object, value) {
        old <- name_sets(object)

        if (is.factor(value)) {
            value <- as.character(value)
        }
        sets <- sets(object)
        if (is.factor(sets$sets)) {
            levels(sets$sets) <- value
        }

        if (length(value) == length(old)) {
            sets$sets <- value
        } else if (length(value) > length(old)) {
            stop("More sets provided than existing.\n\t",
                 "Use add_sets() if you want to add sets.",
                 call. = FALSE)
        } else {
            stop("Less names provided than existing.\n\t",
                 "Use filter() if you want to remove some sets.",
                 call. = FALSE)
        }

        object@sets <- unique(sets)
        if (anyDuplicated(object@sets$sets) > 0) {
            stop("Duplicated sets but with different information",
                call. = FALSE
            )
        }
        old_relations <- object@relations$sets
        if (is.factor(old_relations)) {
            old_relations <- levels(old_relations)
            replace <- match(old_relations, old)
            levels(object@relations$sets) <- value[replace]
        } else {
            replace <- match(old_relations, old)
            object@relations$sets <- value[replace]
        }
        validObject(object)
        object
    }
)
