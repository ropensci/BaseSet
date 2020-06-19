#' @importFrom dplyr mutate
#' @importFrom rlang exprs
#' @export
dplyr::mutate

#' Mutate
#'
#' Use mutate to alter the TidySet object. You can use activate with mutate or
#' use the specific function. The S3 method filters using all the information
#' on the TidySet.
#' @param .data The TidySet object.
#' @param ... The logical predicates in terms of the variables of the sets.
#' @return A TidySet object
#' @export
#' @seealso \code{\link[dplyr]{mutate}} and \code{\link{activate}}
#' @family methods
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
#'     elements = rep(letters[seq_len(6)], 2),
#'     fuzzy = runif(12)
#' )
#' a <- tidySet(relations)
#' a <- mutate_element(a, Type = c(rep("Gene", 4), rep("lncRNA", 2)))
#' a
#' b <- mutate_relation(a, Type = sample(c("PPI", "PF", "MP"), 12,
#'     replace = TRUE
#' ))
#' @rdname mutate_
#' @export
#' @method mutate TidySet
mutate.TidySet <- function(.data, ...) {
    if (is.null(active(.data))) {
        df <- dplyr::mutate(as.data.frame(.data), ...)
        df2TS(.data, df)
    } else {
        switch(
            active(.data),
            elements = mutate_element(.data, ...),
            sets = mutate_set(.data, ...),
            relations = mutate_relation(.data, ...)
        )
    }
}

#' @rdname mutate_
#' @export
mutate_set <- function(.data, ...) {
    UseMethod("mutate_set")
}

#' @rdname mutate_
#' @export
mutate_element <- function(.data, ...) {
    UseMethod("mutate_element")
}

#' @rdname mutate_
#' @export
mutate_relation <- function(.data, ...) {
    UseMethod("mutate_relation")
}

#' @export
#' @method mutate_element TidySet
mutate_element.TidySet <- function(.data, ...) {
    elements <- elements(.data)
    out <- dplyr::mutate(elements, ...)
    if ("elements" %in% names(exprs(...))) {
        old_names <- name_elements(.data)
        new_names <- out$elements
        order <- match(.data@relations$elements, old_names)
        .data@relations$elements <- new_names[order]
    }
    elements(.data) <- unique(out)
    droplevels(.data)
}
#' @export
#' @method mutate_set TidySet
mutate_set.TidySet <- function(.data, ...) {
    sets <- sets(.data)
    out <- dplyr::mutate(sets, ...)
    if ("sets" %in% names(exprs(...))) {
        old_names <- name_sets(.data)
        new_names <- out$sets
        order <- match(.data@relations$sets, old_names)
        .data@relations$sets <- new_names[order]
    }
    sets(.data) <- unique(out)
    droplevels(.data)
}

#' @export
#' @method mutate_relation TidySet
mutate_relation.TidySet <- function(.data, ...) {
    relations <- relations(.data)
    out <- dplyr::mutate(relations, ...)
    relations(.data) <- out
    droplevels(.data)
}
