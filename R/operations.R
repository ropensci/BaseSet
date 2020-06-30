#' @include AllClasses.R AllGenerics.R
NULL

remove_elements <- function(object, elements) {
    if (length(elements) == 0) {
        return(object)
    }

    keep_at_elements <- !object@elements$elements %in% elements
    new_elements <- object@elements[keep_at_elements, , drop = FALSE]
    rownames(new_elements) <- NULL
    object@elements <- droplevels(new_elements)
    object
}

remove_sets <- function(object, sets) {
    if (length(sets) == 0) {
        return(object)
    }

    keep_at_set <- !object@sets$sets %in% sets
    new_set <- object@sets[keep_at_set, , drop = FALSE]
    object@sets <- droplevels(new_set)
    object
}

remove_relations <- function(object, elements, sets,
    relations = paste(elements, sets)) {
    if (length(sets) != length(elements)) {
        stop("sets and elements should be of the same length", call. = FALSE)
    }
    if (length(sets) == 0) {
        return(object)
    }
    old_relations <- elements_sets(object)
    remove_relation <- !old_relations %in% relations
    object@relations <- object@relations[remove_relation, , drop = FALSE]
    rownames(object@relations) <- NULL
    object@relations <- droplevels(object@relations)
    object
}

rm_relations_with_sets <- function(object, sets) {
    if (length(sets) == 0) {
        return(object)
    }
    keep_at_relations <- !object@relations$set %in% sets
    new_relations <- object@relations[keep_at_relations, , drop = FALSE]
    object@relations <- droplevels(new_relations)
    rownames(object@relations) <- NULL
    object@relations <- droplevels(object@relations)
    object
}

rm_relations_with_elements <- function(object, elements) {
    if (length(elements) == 0) {
        return(object)
    }
    keep_at_relations <- !object@relations$elements %in% elements
    new_relations <- object@relations[keep_at_relations, , drop = FALSE]
    object@relations <- droplevels(new_relations)
    rownames(object@relations) <- NULL
    object@relations <- droplevels(object@relations)
    object
}

elements_sets <- function(object) {
    paste(object@relations$elements, object@relations$sets)
}

`%e-e%` <- function(object1, object2) {
    setdiff(object1@relations$elements, object2@relations$elements)
}

`%s-s%` <- function(object1, object2) {
    setdiff(object1@relations$sets, object2@relations$sets)
}

`%r-r%` <- function(object1, object2) {
    relations1 <- elements_sets(object1)
    relations2 <- elements_sets(object2)
    setdiff(relations1, relations2)
}

#' Apply to fuzzy
#'
#' Simplify and returns unique results of the object.
#' @param relations A data.frame or similar with fuzzy, sets and elements
#' columns.
#' @param FUN A function to perform on the fuzzy numbers.
#' @param ... Other named arguments passed to `FUN`.
#' @return A modified TidySet object
#' @keywords internal
fapply <- function(relations, FUN, ...) {
    if (ncol(relations) > 3) {
        warning("Dropping columns. Consider using `move_to`")
    }
    # Handle the duplicate cases
    relations <- unique(relations[, c("sets", "elements", "fuzzy")])
    basic <- paste(relations$elements, relations$sets)
    fuzzy <- split(relations$fuzzy, basic)
    # Helper function probably useful for intersection too
    iterate <- function(fuzzy, fun, ...) {
        fun(fuzzy, ...)
    }

    FUN <- match.fun(FUN)
    fuzzy <- vapply(fuzzy, iterate, fun = FUN, numeric(1L), ... = ...)
    relations2 <- unique(relations[, c("sets", "elements")])
    basic2 <- paste(relations2$elements, relations2$sets)
    # Sort again to match the new relations
    cbind(relations2, fuzzy = fuzzy[match(basic2, names(fuzzy))])
}

merge_tidySets <- function(object1, object2) {
    new_relations <- merge(object1@relations, object2@relations,
                           all = TRUE, sort = FALSE)
    new_sets <- merge(object1@sets, object2@sets,
                      all = TRUE, sort = FALSE)
    new_elements <- merge(object1@elements, object2@elements,
                          all = TRUE, sort = FALSE)

    object2@relations <- unique(new_relations)
    object2@sets <- unique(new_sets)
    object2@elements <- unique(new_elements)

    rownames(object2@relations) <- NULL
    rownames(object2@sets) <- NULL
    rownames(object2@elements) <- NULL

    object2
}

elements_in_set <- function(object, sets) {
    as.character(object@relations$elements[object@relations$sets %in% sets])
}

sets_for_elements <- function(object, elements) {
    as.character(object@relations$sets[object@relations$elements %in% elements])
}

replace_interactions <- function(object, new_relations, keep) {
    stopifnot(is.logical(keep))
    old_relations <- object@relations

    if (keep) {
        # To ensure that the number of columns match
        new_columns <- setdiff(colnames(old_relations), colnames(new_relations))
        new_relations[, new_columns] <- NA
        new_relations <- rbind(old_relations, new_relations)
    }
    object@relations <- unique(new_relations)
    object
}

check_sets <- function(object, sets) {
    sets %in% object@relations$sets
}

#' @importFrom dplyr n_distinct
check_fuzziness <- function(object) {
    r <- relations(object)
    fuzziness <- tapply(r$fuzzy, paste(r$elements, r$sets), FUN = n_distinct)
    all(fuzziness == 1)
}
