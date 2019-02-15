#' @include AllClasses.R AllGenerics.R
NULL


validate <- function(object) {

  relations_df <- droplevels(relations(object))
  object <- validate_elements(object, relations_df)
  object <- validate_sets(object, relations_df)

  validObject(object)
  object
}

validate_elements <- function(object, relations_df = NULL) {

  if (is.null(relations_df)) {
    relations_df <- droplevels(relations(object))
  }

  rel_elements <- levels(relations_df$elements)
  ele_elements <- name_sets(object)

  if (all.equal(sort(ele_elements), sort(unique(rel_elements)))) {

    remove_elements <- setdiff(ele_elements, rel_elements)
    object <- remove_elements(object, remove_elements)

    add_elements <- setdiff(rel_elements, ele_elements)
    object <- add_elements(object, add_elements)
  }
  object
}

validate_sets <- function(object, relations_df = NULL) {

  if (is.null(relations_df)) {
    relations_df <- droplevels(relations(object))
  }

  rel_sets <- levels(relations_df$sets)
  ele_sets <- name_sets(object)

  if (all.equal(sort(ele_sets), sort(unique(rel_sets)))) {

    remove_sets <- setdiff(ele_sets, rel_sets)
    object <- remove_sets(object, remove_sets)

    add_sets <- setdiff(rel_sets, ele_sets)
    object <- add_sets(object, add_sets)
  }
  object
}
