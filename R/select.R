#' @include AllClasses.R AllGenerics.R
#' @importFrom dplyr select
#' @importFrom rlang !!
#' @export
dplyr::select

#' select from a TidySet
#'
#' Use select to extract the columns of a TidySet object. You can use activate
#' with filter or use the specific function. The S3 method filters using all
#' the information on the TidySet.
#' @param .data The TidySet object
#' @param ... The name of the columns you want to keep, remove or rename.
#' @return A TidySet object
#' @export
#' @seealso dplyr \code{\link[dplyr]{select}} and \code{\link{activate}}
#' @family methods
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
#'     elements = rep(letters[seq_len(6)], 2),
#'     fuzzy = runif(12)
#' )
#' a <- tidySet(relations)
#' a <- mutate_element(a,
#'     type = c(rep("Gene", 4), rep("lncRNA", 2))
#' )
#' a <- mutate_set(a, Group = c("UFM", "UAB", "UPF", "MIT"))
#' b <- select(a, -type)
#' elements(b)
#' b <- select_element(a, elements)
#' elements(b)
#' # Select sets
#' select_set(a, sets)
#' @rdname select_
#' @method select TidySet
#' @export
select.TidySet <- function(.data, ...) {
    if (is.null(active(.data))) {
        out <- dplyr::select(as.data.frame(.data), ...)
        df2TS(.data, df = out)
    } else {
        switch(
            active(.data),
            elements = select_element(.data, ...),
            sets = select_set(.data, ...),
            relations = select_relation(.data, ...)
        )
    }
}

#' @rdname select_
#' @export
select_set <- function(.data, ...) {
    UseMethod("select_set")
}

#' @rdname select_
#' @export
select_element <- function(.data, ...) {
    UseMethod("select_element")
}

#' @rdname select_
#' @export
select_relation <- function(.data, ...) {
    UseMethod("select_relation")
}

#' @export
#' @method select_set TidySet
select_set.TidySet <- function(.data, ...) {
    sets <- sets(.data)
    out <- dplyr::select(sets, ...)
    .data@sets <- out
    validObject(.data)
    .data
}

#' @export
#' @method select_element TidySet
select_element.TidySet <- function(.data, ...) {
    elements <- elements(.data)
    out <- dplyr::select(elements, ...)
    .data@elements <- out
    validObject(.data)
    .data
}

#' @export
#' @method select_relation TidySet
select_relation.TidySet <- function(.data, ...) {
    relations <- relations(.data)
    out <- dplyr::select(relations, ...)
    .data@relations <- out
    validObject(.data)
    .data
}
