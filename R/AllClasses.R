# S4 classes ###
#' A tidy class to represent a set
#'
#' A set is a group of unique elements it can be either a fuzzy set, where the
#' relationship is between 0 or 1 or nominal.
#'
#' When printed if an element or a set do not have any relationship is not
#' shown.
#' They can be created from lists, matrices or data.frames. Check [tidySet()]
#' constructor for more information.
#' @slot relations A data.frame with elements and the sets were they belong.
#' @slot elements A data.frame of unique elements and related information.
#' @slot sets A data.frame of unique sets and related information.
#' @aliases TidySet
#' @export
#' @seealso \link{tidySet}
#' @family methods
#' @examples
#' x <- list("A" = letters[1:5], "B" = LETTERS[3:7])
#' a <- tidySet(x)
#' a
#' x <- list("A" = letters[1:5], "B" = character())
#' b <- tidySet(x)
#' b
#' name_sets(b)
setClass(
    "TidySet",
    representation(
        elements = "data.frame",
        sets = "data.frame",
        relations = "data.frame"
    )
)

#' @importFrom methods setClassUnion
setClassUnion("characterORfactor", c("character", "factor"))

is.valid <- function(object) {
    errors <- c()

    # Check that the slots have the right columns
    errors <- c(errors, check_colnames_slot(object, "elements", "elements"))
    errors <- c(errors, check_colnames_slot(object, "sets", "sets"))
    errors <- c(errors, check_colnames_slot(object, "relations", "elements"))
    errors <- c(errors, check_colnames_slot(object, "relations", "sets"))
    errors <- c(errors, check_colnames_slot(object, "relations", "fuzzy"))

    # Check that the columns contain the least information required
    elements <- object@elements$elements

    if (length(unique(elements)) != length(elements)) {
        errors <- c(errors, "Elements on the element slot must be unique")
    }
    sets <- object@sets$sets
    if (length(unique(sets)) != length(sets)) {
        errors <- c(errors, "Sets on the sets slot must be unique")
    }

    # Check the type of data
    if (!is.ch_fct(sets)) {
        errors <- c(errors, "Sets must be characters or factors")
    }
    if (!is.ch_fct(elements)) {
        errors <- c(errors, "Elements must be characters or factors")
    }

    if (!"fuzzy" %in% colnames(object@relations)) {
        errors <- c(errors, "A fuzzy column must be present")
    } else if (length(object@relations$fuzzy) != 0) {
        fuzz <- object@relations$fuzzy
        if (!is.numeric(fuzz)) {
            errors <- c(
                errors,
                "fuzzy column is restricted to a number between 0 and 1."
            )
        } else if (min(fuzz) < 0 || max(fuzz) > 1) {
            errors <- c(
                errors,
                "fuzzy column is restricted to a number between 0 and 1."
            )
        }
    }

    # Check that the slots don't have duplicated information
    colnames_elements <- colnames(object@elements)
    colnames_sets <- colnames(object@sets)
    if (length(intersect(colnames_elements, colnames_sets)) != 0) {
        errors <- c(
            errors,
            "Sets and elements can't share a column name.",
            "You might want to add a column to the relations instead"
        )
    }

    relations <- slot(object, "relations")
    if (nrow(relations) > 0) {
        # Check that there are duplicated ids
        es <- paste(relations$elements, relations$sets)

        # Check that relations have the same fuzzy value when the
        if (anyDuplicated(es) != 0 && !all(fuzz == 1)) {
            fuzziness <- tapply(fuzz, es, FUN = n_distinct)
            if (!all(fuzziness == 1)) {
                msg <- paste0(
                    "A relationship between an element",
                    "and a set must have a single fuzzy value"
                )
                errors <- c(errors, msg)
            }
        }
    }

    if (length(errors) == 0) {
        TRUE
    } else {
        errors
    }
}

setValidity("TidySet", is.valid)

is_valid <- function(x) {
    if (is.logical(is.valid(x))) {
        TRUE
    } else {
        FALSE
    }
}

check_colnames_slot <- function(object, slot, colname) {
    array_names <- colnames(slot(object, slot))

    if (length(array_names) == 0) {
        paste0(
            "Missing required colnames for ", slot,
            ". See tidySet documentation."
        )
    } else if (check_colnames(array_names, colname)) {
        paste0(colname, " column is not present on slot ", slot, ".")
    }
}

check_colnames <- function(array_names, colname) {
    all(!colname %in% array_names)
}

is.ch_fct <- function(x) {
    is.character(x) || is.factor(x)
}
