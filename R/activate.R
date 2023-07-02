#' @include AllClasses.R AllGenerics.R
NULL

#' Determine the context of subsequent manipulations.
#'
#' Functions to help to perform some action to just some type of data: elements,
#'  sets or relations.
#' \code{activate}: To table the focus of future manipulations: elements, sets
#' or relations.
#' \code{active}: To check the focus on the \code{TidySet}.
#' \code{deactivate}: To remove the focus on a specific \code{TidySet}-
#' @param .data A \code{TidySet} object.
#' @param what Either "elements", "sets" or "relations"
#' @return A \code{TidySet} object.
#' @family methods
#' @export
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
#'     elements = rep(letters[seq_len(6)], 2),
#'     fuzzy = runif(12)
#' )
#' a <- tidySet(relations)
#' elements(a) <- cbind(elements(a),
#'     type = c(rep("Gene", 4), rep("lncRNA", 2))
#' )
#' # Filter in the whole TidySet
#' filter(a, elements == "a")
#' filter(a, elements == "a", type == "Gene")
#' # Equivalent to filter_elements
#' filter_element(a, type == "Gene")
#' a <- activate(a, "elements")
#' active(a)
#' filter(a, type == "Gene")
#' a <- deactivate(a)
#' active(a)
#' filter(a, type == "Gene")
activate <- function(.data, what) {
    UseMethod("activate")
}

#' @export
#' @importFrom rlang enquo quo_text
activate.TidySet <- function(.data, what) {
    active(.data) <- quo_text(enquo(what))
    .data
}

#' @rdname activate
#' @export
active <- function(.data) {
    attr(.data, "active")
}

`active<-` <- function(x, value) {
    if (is.null(value)) {
        attr(x, "active") <- value
    } else {
        value <- gsub('"', "", value)
        value <- switch(
            value,
            element = ,
            elements = "elements",
            set = ,
            sets = "sets",
            relation = ,
            relations = "relations",
            stop("Only possible to activate elements, sets and relations",
                call. = FALSE)
        )
        attr(x, "active") <- value
    }
    x
}
