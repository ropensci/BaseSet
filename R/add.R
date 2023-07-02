add_elements_internal <- function(object, elements) {
    original_elements <- name_elements(object)
    final_elements <- unique(c(original_elements, elements))
    new_elements <- setdiff(final_elements, original_elements)

    if (length(new_elements) == 0) {
        return(object)
    }
    df_elements <- data.frame(elements = new_elements)
    column_names <- setdiff(colnames(object@elements), "elements")
    df_elements[, column_names] <- NA
    object@elements <- rbind(object@elements, df_elements)

    rownames(object@elements) <- NULL
    object@elements <- droplevels(object@elements)
    object
}

add_sets_internal <- function(object, set) {
    original_sets <- name_sets(object)
    final_sets <- unique(c(original_sets, set))
    new_sets <- setdiff(final_sets, original_sets)

    if (length(new_sets) == 0) {
        return(object)
    }
    df_sets <- data.frame(sets = new_sets)
    column_names <- setdiff(colnames(object@sets), "sets")
    df_sets[, column_names] <- NA
    object@sets <- rbind(object@sets, df_sets)

    rownames(object@sets) <- NULL
    object@sets <- droplevels(object@sets)
    object
}

add_relations_internal <- function(object, elements, sets, fuzzy) {
    nElements <- length(elements)

    if (length(sets) != nElements && length(sets) == 1) {
        sets <- rep(sets, nElements)
    } else if (length(sets) != nElements && length(sets) > 1) {
        stop("The number of elements is greater than the number of sets.",
            "It can be either equal to the number of sets or just one set",
            call. = FALSE
        )
    }

    original_relations <- elements_sets(object)
    relations <- paste(elements, sets)
    new_relations <- setdiff(relations, original_relations)

    if (length(fuzzy) > length(new_relations)) {
        stop("Redefining the same relations with a different fuzzy number",
            call. = FALSE
        )
    } else if (length(fuzzy) <= length(new_relations) && length(fuzzy) == 1) {
        fuzzy <- rep(fuzzy, length(new_relations))
    } else if (length(fuzzy) != length(elements)) {
        stop("Recyling fuzzy is not allowed", call. = FALSE)
    }

    # Split the remaining elements and sets
    elements_sets <- strsplit(new_relations, split = " ")
    elements <- vapply(elements_sets, "[", i = 1, character(1L))
    sets <- vapply(elements_sets, "[", i = 2, character(1L))

    df_relations <- data.frame(
        elements = elements,
        sets = sets,
        fuzzy = fuzzy
    )
    column_names <- setdiff(
        colnames(object@relations),
        c("sets", "elements", "fuzzy")
    )
    df_relations[, column_names] <- NA
    object@relations <- rbind.data.frame(object@relations, df_relations)
    rownames(object@relations) <- NULL
    object@relations <- droplevels(object@relations)
    object
}

#' Add elements to a TidySet
#'
#' Functions to add elements. If the elements are new they are added,
#' otherwise they are omitted.
#' @note `add_element` doesn't set up any other information about the elements.
#' Remember to add/modify them if needed with [`mutate`] or [`mutate_element`]
#' @param object A [`TidySet`] object
#' @param elements A character vector of the elements.
#' @param ... Placeholder for other arguments that could be passed to the
#' method. Currently not used.
#' @return A [`TidySet`] object with the new elements.
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
add_elements.TidySet <- function(object, elements, ...) {
    object <- add_elements_internal(object, elements)
    validObject(object)
    object
}

#' Add sets to a TidySet
#'
#' Functions to add sets. If the sets are new they are added,
#' otherwise they are omitted.
#' @note `add_sets` doesn't set up any other information about the sets.
#' Remember to add/modify them if needed with [`mutate`] or [`mutate_set`]
#' @inheritParams add_elements
#' @param sets A character vector of sets to be added.
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
add_sets.TidySet <- function(object, sets, ...) {
    object <- add_sets_internal(object, sets)
    validObject(object)
    object
}

#' Add relations to a TidySet
#'
#' Adds new relations to existing or new sets and elements.
#' If the sets or elements do not exist they are added.
#' @note `add_relations` doesn't set up any other information about the
#' relationship.
#' Remember to add/modify them if needed with [`mutate`] or [`mutate_relation`]
#' @inheritParams add_sets
#' @inheritParams add_elements
#' @param fuzzy The strength of the membership.
#' @return A [`TidySet`] object with the new relations.
#' @family add_*
#' @seealso [add_relation()] to add relations with new sets or/and
#' new elements.
#' @examples
#' x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
#' a <- tidySet(x)
#' add_relations(a, elements = c("a", "b", "g"), sets = "d")
#' add_relations(a, elements = c("a", "b"), sets = c("d", "g"))
#' add_relations(a, elements = c("a", "b"), sets = c("d", "g"), fuzzy = 0.5)
#' add_relations(a,
#'     elements = c("a", "b"), sets = c("d", "g"),
#'     fuzzy = c(0.5, 0.7)
#' )
#' @export
add_relations <- function(object, elements, sets, fuzzy, ...) {
    UseMethod("add_relations")
}

#' @export
#' @method add_relations TidySet
add_relations.TidySet <- function(object, elements, sets, fuzzy = 1, ...) {
    object <- add_elements(object, elements)
    object <- add_sets(object, sets)
    object <- add_relations_internal(object, elements, sets, 1)

    if (length(fuzzy) != length(elements) && length(fuzzy) != 1) {
        stop("Fuzzy values do not match with the number of relations",
            call. = FALSE
        )
    }

    relations <- relations(object)
    e_s <- paste(relations$elements, relations$sets)
    eo_so <- paste(elements, sets)
    m <- match(e_s, eo_so)
    m <- m[!is.na(m)]
    if (length(fuzzy) != length(elements)) {
        fuzzy <- rep(fuzzy, length(elements))
    } else {
        fuzzy <- fuzzy[m]
    }
    relations$fuzzy[relations$elements %in% elements &
        relations$sets %in% sets] <- fuzzy
    relations(object) <- relations
    validObject(object)
    object
}
