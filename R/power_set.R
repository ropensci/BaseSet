#' Create the power set
#'
#'
#' @param object A TidySet object.
#' @param set The name of the set to be used for the power set
#' @param name The root name of the new set.
#' @param ... Other arguments passed down if possible. Currently ignored.
#' @return A TidySet object with the new set
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
power_set.TidySet <- function(object, set, name, keep = TRUE,
    keep_relations = keep,
    keep_elements = keep,
    keep_sets = keep, ...) {
    if (!is.logical(keep)) {
        stop("keep must be a logical value.", call. = FALSE)
    }
    if (any(!c(set) %in% name_sets(object))) {
        stop("Sets must be on the object", call. = FALSE)
    }

    elements_orig <- elements(filter_set(object, sets == !!set))
    length_sets <- seq(2, nrow(elements_orig) - 1)
    new_sets <- lapply(length_sets, function(x) {
        combn(elements_orig$elements, x, simplify = FALSE)
    })
    names(new_sets) <- paste0(name, "_", length_sets, "_")
    list_sets <- unlist(new_sets, recursive = FALSE)
    new_object <- tidySet(list_sets)

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
    validObject(object)
    object
}
