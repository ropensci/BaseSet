#' @include AllGenerics.R
NULL

#' @describeIn rename_set Rename sets
#' @export rename_set
setMethod("rename_set",
    signature = signature(object = "TidySet"),
    function(object, old, new) {
        membership <- name_sets(object) %in% old
        if (!any(membership)) {
            stop("All sets must be found on the TidySet", call. = FALSE)
        }
        if (is.factor(new)) {
            new <- as.character(new)
        }
        new <- rep(new, length.out = sum(membership))
        name_sets(object)[membership] <- new
        validObject(object)
        object
    }
)

#' @describeIn rename_elements Rename elements
#' @export rename_elements
setMethod("rename_elements",
    signature = signature(object = "TidySet"),
    function(object, old, new) {
        membership <- name_elements(object) %in% old
        if (!any(membership)) {
            stop("All elements must be found on the TidySet", call. = FALSE)
        }
        if (is.factor(new)) {
            new <- as.character(new)
        }
        new <- rep(new, length.out = sum(membership))
        name_elements(object)[membership] <- new
        validObject(object)
        object
    }
)
