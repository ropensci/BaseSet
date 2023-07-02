#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn complement_set Complement of the sets.
#' @export
setMethod("complement_set",
    signature = signature(
        object = "TidySet",
        sets = "characterORfactor"
    ),
    function(object, sets, name = NULL, FUN = NULL, keep = TRUE,
    keep_relations = keep,
    keep_elements = keep,
    keep_sets = keep) {
        if (!is.logical(keep)) {
            stop("keep must be a logical value.", call. = FALSE)
        }

        old_relations <- relations(object)
        involved_relations <- old_relations$sets %in% sets
        # Elements present on sets
        complement <- old_relations[involved_relations, , drop = FALSE]

        if (is.null(FUN)) {
            complement$fuzzy <- 1 - complement$fuzzy
        } else {
            fun <- match.fun(FUN)
            complement$fuzzy <- fun(complement$fuzzy)
        }

        if (is.null(name)) {
            name <- naming("complement", sets)
        }

        object <- add_sets(object, name)
        complement$sets <- name

        object <- replace_interactions(object, complement, keep_relations)

        droplevels(object, !keep_elements, !keep_sets, !keep_relations)
    }
)

#' @describeIn complement_element Complement of the elements.
#' @export
setMethod("complement_element",
    signature = signature(
        object = "TidySet",
        elements = "characterORfactor"
    ),
    function(object, elements, name = NULL, FUN = NULL, keep = TRUE,
    keep_relations = keep,
    keep_elements = keep,
    keep_sets = keep) {
        if (!is.logical(keep)) {
            stop("keep must be a logical value.", call. = FALSE)
        }
        old_relations <- relations(object)
        complement <- old_relations[old_relations$elements %in% elements, ,
            drop = FALSE
        ]
        if (is.null(FUN)) {
            complement$fuzzy <- 1 - complement$fuzzy
        } else {
            fun <- match.fun(FUN)
            complement$fuzzy <- fun(complement$fuzzy)
        }

        if (is.null(name)) {
            name <- naming("complement", elements)
        }

        complement$sets <- name
        complement <- complement[complement$fuzzy != 0, , drop = FALSE]

        object <- replace_interactions(object, complement, keep_relations)
        object <- add_sets(object, name)
        droplevels(object, !keep_elements, !keep_sets, !keep_relations)
    }
)

#' Complement TidySet
#'
#' Use complement to find elements or sets the TidySet object. You can use
#' activate with complement or use the specific function. You must specify if
#' you want the complements of sets or elements.
#' @param .data The TidySet object
#' @param ... Other arguments passed to either [complement_set()] or
#' [complement_element()].
#' @return A TidySet object
#' @export
#' @family complements
#' @family methods
#' @seealso [activate()]
#' @examples
#' rel <- data.frame(
#'     sets = c("A", "A", "B", "B", "C", "C"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' TS <- tidySet(rel)
#' TS %>%
#'     activate("elements") %>%
#'     complement("a")
#' TS %>%
#'     activate("elements") %>%
#'     complement("a", "C_a", keep = FALSE)
#' TS %>%
#'     activate("set") %>%
#'     complement("A")
#' TS %>%
#'     activate("set") %>%
#'     complement("A", keep = FALSE)
#' TS %>%
#'     activate("set") %>%
#'     complement("A", FUN = function(x){abs(x - 0.2)}, keep = FALSE)
#' @export
complement <- function(.data, ...) {
    UseMethod("complement")
}

#' @export
#' @method complement TidySet
complement.TidySet <- function(.data, ...) {
    if (is.null(active(.data))) {
        stop("Specify about what do you want the complement.
             Activate sets or elements")
    } else {
        switch(
            active(.data),
            elements = complement_element(.data, ...),
            sets = complement_set(.data, ...),
            relations = stop("Select either elements or sets")
        )
    }
}
