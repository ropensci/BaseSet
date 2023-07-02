#' Create the power set
#'
#' Create the power set of the object: All the combinations of the elements of
#' the sets.
#' @param object A TidySet object.
#' @param set The name of the set to be used for the power set, if not provided
#' all are used.
#' @param name The root name of the new set, if not provided the standard
#' notation "P()" is used.
#' @param ... Other arguments passed down if possible.
#' @return A TidySet object with the new set.
#' @family methods
#' @export
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("a", 5), "b"),
#'     elements = letters[seq_len(6)]
#' )
#' TS <- tidySet(relations)
#' power_set(TS, "a", name = "power_set")
power_set <- function(object, set, name, ...) {
    UseMethod("power_set")
}

#' @export
#' @method power_set TidySet
#' @importFrom utils combn
power_set.TidySet <- function(object, set, name = NULL, keep = TRUE,
    keep_relations = keep,
    keep_elements = keep,
    keep_sets = keep, ...) {
    if (!is.logical(keep)) {
        stop("keep must be a logical value.", call. = FALSE)
    }
    if (any(!c(set) %in% name_sets(object))) {
        stop("Sets must be on the object", call. = FALSE)
    }

    elements_orig <- name_elements(filter(object, sets == !!set))
    length_sets <- seq(1, length(elements_orig) - 1)
    new_sets <- lapply(length_sets, function(x) {
        combn(elements_orig, x, simplify = FALSE)
    })

      # Power sets naming from wiki and other sources:
    # https://en.wikipedia.org/wiki/Power_set
    if (is.null(name)) {
        name <- paste0("P(", set, ")")
    }

    names(new_sets) <- paste0(name, "_", length_sets, "_")
    list_sets <- unlist(new_sets, recursive = FALSE)
    # Improve the naming to some convention to not use length_number or

    new_object <- tidySet(list_sets[lengths(list_sets) >= 1])

    if (keep_relations) {
        out <- relations(new_object)
        new_colnames <- setdiff(colnames(object@relations), colnames(out))
        out[, new_colnames] <- NA
        object@relations <- rbind(object@relations, out)

        new_colnames <- setdiff(colnames(object@sets), "sets")
        sets <- data.frame(sets = new_object@sets$sets)
        sets[, new_colnames] <- NA
        object@sets <- rbind(object@sets, sets)
    } else {
        object <- new_object
    }

    droplevels(object)
}
