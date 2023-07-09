#' @importFrom methods setClassUnion
setClassUnion("characterORfactor", c("character", "factor"))


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
  errors <- c(errors, valid_relations(relations, sets, elements))

  if (length(errors) == 0) {
    TRUE
  } else {
    errors
  }
}

is_valid <- function(x) {
  if (is.logical(is.valid(x))) {
    TRUE
  } else {
    FALSE
  }
}

# relations should be a data.frame
# sets should be a vector
# elements should be a vector
valid_relations <- function(relations, sets, elements) {
  errors <- character()
  # A TS with no relations is a valid set.
  # if (nrow(relations) == 0) {
  #   errors <- c(errors, "No relations found.")
  # }

  if (!"fuzzy" %in% colnames(relations)) {
    errors <- c(errors, "A fuzzy column must be present.")
  } else if (length(relations$fuzzy) != 0) {
    fuzz <- relations$fuzzy
    if (!is.numeric(fuzz) || min(fuzz) < 0 || max(fuzz) > 1) {
      errors <- c(errors,
                  "fuzzy column is restricted to a number between 0 and 1."
      )
    }
  }

  # Check that there are duplicated ids
  es <- paste(relations$elements, relations$sets)

  # Check that relations have the same fuzzy value when the
  if (anyDuplicated(es) != 0 && !all(fuzz == 1)) {
    fuzziness <- tapply(fuzz, es, FUN = n_distinct)
    if (!all(fuzziness == 1)) {
      msg <- paste0(
        "A relationship between an element",
        " and a set must have a single fuzzy value"
        , collapse = " ")
      errors <- c(errors, msg)
    }
  }
  if (!all(relations$sets %in% sets)) {
    msg <- paste0("The TidySet has elements with a",
                  " relationship with a missing set.", collapse = " ")
    errors <- c(errors, msg)
  }
  if (!all(relations$elements %in% elements)) {
    msg <- paste0("The TidySet has elements with a",
                  " relationship with a missing element.", collapse = " ")
    errors <- c(errors, msg)
  }
errors
}

# sets should be a data.frame
valid_sets <- function(sets) {
    errors <- character()
    if (!is.data.frame(sets)) {
        errors <- c(errors, "Should be a data.frame.")
    }

    if (!"sets" %in% names(sets)) {
        errors <- c(errors, "There isn't a sets column.")
    }

    if (is.null(sets$sets)) {
        errors <- c(errors, paste0("Missing column sets."))
    }
    errors
}
