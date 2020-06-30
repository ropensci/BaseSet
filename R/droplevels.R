#' @include AllClasses.R AllGenerics.R
NULL

drop_elements <- function(object) {
    remaining <- unique(relations(object)$elements)
    elements <- name_elements(object)
    remove_elements(object, elements[!elements %in% remaining])
}

drop_sets <- function(object) {
    remaining <- unique(relations(object)$sets)
    sets <- name_sets(object)
    remove_sets(object, sets[!sets %in% remaining])
}

drop_relations <- function(object) {
    sets <- name_sets(object)
    elements <- name_elements(object)
    relations <- object@relations
    if (nrow(relations) != 0) {
        keep_sets <- relations$sets %in% sets
        keep_elements <- relations$elements %in% elements

        object@relations <- relations[keep_sets & keep_elements, , drop = FALSE]
    }
    object
}

#' Drop unused elements and sets
#'
#' Drop elements and sets without any relation.
#' @param x A TidySet object.
#' @param elements Logical value: Should elements be dropped?
#' @param sets Logical value: Should sets be dropped?
#' @param relations Logical value: Should sets be dropped?
#' @param ... Other arguments, currently ignored.
#' @return A TidySet object.
#' @export
#' @examples
#' rel <- list(A = letters[1:3], B = character())
#' TS <- tidySet(rel)
#' TS
#' sets(TS)
#' TS2 <- droplevels(TS)
#' TS2
#' sets(TS2)
droplevels.TidySet <- function(x, elements = TRUE, sets = TRUE,
    relations = TRUE, ...) {
    stopifnot(is.logical(elements))
    stopifnot(is.logical(sets))
    stopifnot(is.logical(relations))

    if (relations) {
        x <- drop_relations(x)
    }
    if (elements) {
        x <- drop_elements(x)
    }
    if (sets) {
        x <- drop_sets(x)
    }
    validObject(x)
    x
}
