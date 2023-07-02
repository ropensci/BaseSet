#' @include AllClasses.R AllGenerics.R
NULL

#' Create the cartesian product of two sets
#'
#' Given two sets creates new sets with one element of each set
#' @param object A TidySet object.
#' @param set1,set2 The name of the sets to be used for the cartesian product
#' @param name The name of the new set.
#' @inheritParams union
#' @param ... Placeholder for other arguments that could be passed to the
#' method. Currently not used.
#' @return A TidySet object with the new set
#' @family methods
#' @export
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("a", 5), "b"),
#'     elements = letters[seq_len(6)]
#' )
#' TS <- tidySet(relations)
#' cartesian(TS, "a", "b")
cartesian <- function(object, set1, set2, name = NULL, ...) {
    UseMethod("cartesian")
}

#' @rdname cartesian
#' @method cartesian TidySet
#' @export
cartesian.TidySet <- function(object, set1, set2, name = NULL, keep = TRUE,
    keep_relations = keep,
    keep_elements = keep,
    keep_sets = keep, ...) {
    if (!is.logical(keep)) {
        stop("keep must be a logical value.", call. = FALSE)
    }
    if (any(!c(set1, set2) %in% name_sets(object))) {
        stop("Sets must be on the object", call. = FALSE)
    }
    if (length(set1) > 1 || length(set2) > 1) {
        stop("Sets must be of length 1", call. = FALSE)
    }

    if (is.null(name)) {
        name <- naming(sets1 = set1, sets2 = set2, middle = "product")
    }

    relations <- relations(object)
    elements1 <- relations$elements[relations$sets %in% set1]
    elements2 <- relations$elements[relations$sets %in% set2]

    new_sets <- base::expand.grid(elements1, elements2,
        stringsAsFactors = FALSE
    )
    l <- vector("list", nrow(new_sets))
    for (i in seq_len(nrow(new_sets))) {
        l[[i]] <- unique(as.character(simplify2array(new_sets[i, ])))
    }
    new_sets <- l[lengths(l) == 2]

    new_names <- paste0(name, "_", seq_along(new_sets))

    object <- add_sets(object, name)
    object <- add_sets(object, new_names)
    relation <- data.frame(
        elements = unlist(new_sets, FALSE, FALSE),
        sets = rep(new_names, lengths(new_sets))
    )
    object <- add_relation(object, relation)
    relations <- relations(object)
    cart <- relations[relations$sets %in% new_names, , drop = FALSE]
    cart$sets <- name

    if (keep_relations) {
        relations(object) <- unique(rbind(relations, cart))
    } else {
        relations(object) <- cart
    }
    droplevels(object)
}
