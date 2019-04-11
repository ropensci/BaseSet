
add_elements_internal <- function(object, elements){

    original_elements <- name_elements(object)
    if (is.factor(elements)) {
        elements <- as.character(elements)
    }
    final_elements <- unique(c(original_elements, elements))

    if (length(final_elements) != length(original_elements)) {
        levels(object@elements$elements) <- final_elements

        new_elements <- setdiff(elements, original_elements)
        df_elements <- data.frame(elements = new_elements)
        column_names <- setdiff(colnames(object@elements), "elements")
        df_elements[, column_names] <- NA
        object@elements <- rbind(object@elements, df_elements)
    }
    rownames(object@elements) <- NULL
    object@elements <- droplevels(object@elements)
    object
}

add_sets_internal <- function(object, set) {

    original_sets <- name_sets(object)
    if (is.factor(set)) {
        set <- as.character(set)
    }
    final_sets <- unique(c(original_sets, set))

    if (length(final_sets) != length(original_sets)) {
        levels(object@sets$sets) <- final_sets

        new_sets <- setdiff(set, original_sets)
        df_sets <- data.frame(sets = new_sets)
        column_names <- setdiff(colnames(object@sets), "sets")
        df_sets[, column_names] <- NA
        object@sets <- rbind(object@sets, df_sets)
    }
    rownames(object@sets) <- NULL
    object@sets <- droplevels(object@sets)
    object
}

add_relations_interal <- function(object, elements, sets, fuzzy) {
    nElements <- length(elements)

    if (length(sets) != nElements && length(sets) == 1) {
        sets <- rep(sets, nElements)
    } else if (length(sets) != nElements && length(sets) > 1) {
        stop("Recycling sets is not allowed", call. = FALSE)
    }

    original_relations <- elements_sets(object)
    relations <- paste(elements, sets)
    final_relations <- unique(c(original_relations, relations))
    new_relations <- setdiff(relations, original_relations)

    if (length(fuzzy) > length(new_relations)) {
        stop("Redefining the same relations with a different fuzzy number", call. = FALSE)
    } else if (length(fuzzy) <= length(new_relations) && length(fuzzy) == 1) {
        fuzzy <- rep(fuzzy, length(new_relations))
    } else if (length(fuzzy) != length(elements)) {
        stop("Recyling fuzzy is not allowed", call. = FALSE)
    }

    if (length(final_relations) != length(original_relations)) {

        # Split the remaining elements and sets
        elements_sets <- strsplit(new_relations, split = " ")
        elements <- vapply(elements_sets, "[", i = 1, character(1L))
        sets <- vapply(elements_sets, "[", i = 2, character(1L))

        df_relations <- data.frame(elements = elements, sets = sets, fuzzy = fuzzy)
        column_names <- setdiff(colnames(object@relations),
                                c("sets", "elements", "fuzzy"))
        if (length(column_names) > 0) {
            df_relations[, column_names] <- NA
            object@relations <- rbind.data.frame(object@relations, df_relations)
        }
    }
    rownames(object@relations) <- NULL
    object@relations <- droplevels(object@relations)
    object
}



#' Add to a TidySet
#'
#' Functions to add elements or sets
#' @param object A [`TidySet`] object
#' @param elements The new elements
#' @param sets The new sets
#' @return A [`TidySet`] object with the new sets or elements.
#' @family add_*
#' @examples
#' x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
#' a <- tidySet(x)
#' b <- add_elements(a, "fg")
#' elements(b)
#' @export
add_elements <- function(object, elements, ...) {
    UseMethod("add_elements")
}

#' @export
#' @method add_elements TidySet
add_elements.TidySet <- function(object, elements) {
    object <- add_elements_internal(object, elements)
    validObject(object)
    object
}


#' Add to a TidySet
#'
#' Functions to add elements or sets
#' @param object A [`TidySet`] object.
#' @param sets A character vector with the new sets.
#' @return A [`TidySet`] object with the new sets.
#' @family add_*
#' @examples
#' x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
#' a <- tidySet(x)
#' b <- add_sets(a, "fg")
#' sets(b)
#' @export
add_sets <- function(object, sets, ...) {
    UseMethod("add_sets")
}

#' @export
#' @method add_sets TidySet
add_sets.TidySet <- function(object, sets) {
    object <- add_sets_internal(object, sets)
    validObject(object)
    object
}
#
# add_relation <- function(object, ...) {
#     l <- as.list(...)
#     browser()
#     object <- add_elements(object, l$elements)
#     object <- add_sets(object, l$sets)
#     # object <- add_relations_interal(object, as.data.frame(l))
#     validObject(object)
#     object
# }
