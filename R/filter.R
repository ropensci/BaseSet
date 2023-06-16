#' @include AllClasses.R AllGenerics.R
#' @importFrom dplyr filter
#' @export
dplyr::filter

#' Filter TidySet
#'
#' Use filter to subset the TidySet object. You can use activate with filter or
#' use the specific function. The S3 method filters using all the information
#' on the TidySet.
#' @param .data The TidySet object.
#' @param ... The logical predicates in terms of the variables of the sets.
#' @return A TidySet object.
#' @export
#' @family methods
#' @seealso [dplyr::filter()] and [activate()]
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
#'     elements = rep(letters[seq_len(6)], 2),
#'     fuzzy = runif(12),
#'     type = c(rep("Gene", 4), rep("lncRNA", 2))
#' )
#' TS <- tidySet(relations)
#' TS <- move_to(TS, from = "relations", to = "elements", column = "type")
#' filter(TS, elements == "a")
#' # Equivalent to filter_relation
#' filter(TS, elements == "a", sets == "a")
#' filter_relation(TS, elements == "a", sets == "a")
#' # Filter element
#' filter_element(TS, type == "Gene")
#' # Filter sets and by property of elements simultaneously
#' filter(TS, sets == "b", type == "lncRNA")
#' # Filter sets
#' filter_set(TS, sets == "b")
#' @rdname filter_
#' @export
#' @method filter TidySet
filter.TidySet <- function(.data, ...) {
    if (is.null(active(.data))) {
        df <- dplyr::filter(as.data.frame(.data), ...)
        df2TS(.data, df)
    } else {
        switch(
            active(.data),
            elements = filter_element(.data, ...),
            sets = filter_set(.data, ...),
            relations = filter_relation(.data, ...)
        )
    }
}

#' @rdname filter_
#' @export
filter_set <- function(.data, ...) {
    UseMethod("filter_set")
}

#' @rdname filter_
#' @export
filter_element <- function(.data, ...) {
    UseMethod("filter_element")
}

#' @rdname filter_
#' @export
filter_relation <- function(.data, ...) {
    UseMethod("filter_relation")
}

#' @export
#' @method filter_set TidySet
filter_set.TidySet <- function(.data, ...) {
    sets <- sets(.data)
    out <- dplyr::filter(sets, ...)

    if (nrow(out) == 0) {
        .data@sets <- out[0, , drop = FALSE]
    } else {
        .data@sets <- droplevels(out)
    }
    # Keep elements without sets, drop relations
    droplevels(.data, elements = FALSE, relations = TRUE)
}

#' @export
#' @method filter_element TidySet
filter_element.TidySet <- function(.data, ...) {
    elements <- elements(.data)
    out <- dplyr::filter(elements, ...)

    if (nrow(out) == 0) {
        .data@elements <- out[0, , drop = FALSE]
    } else {
        .data@elements <- droplevels(out)
    }
    # Keep empty sets, drop relations
    droplevels(.data, sets = FALSE, relations = TRUE)
}

#' @export
#' @method filter_relation TidySet
filter_relation.TidySet <- function(.data, ...) {
    relations <- relations(.data)
    out <- dplyr::filter(relations, ...)

    if (nrow(out) == 0) {
        .data@relations <- out[0, , drop = FALSE]
    } else {
        .data@relations <- droplevels(out)
    }
    # Keep empty sets and elements
    droplevels(.data, sets = FALSE, elements = FALSE)
}
