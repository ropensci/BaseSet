#' @export
subtract <- function(object, set_in, not_in, name = NULL, keep = TRUE,
                     keep_relations = keep, keep_elements = keep,
                     keep_sets = keep) {

  old_relations <- relations(object)
  relations <- old_relations[old_relations$sets %in% set_in, , drop = FALSE]
  remove_elements <- elements_in_set(object, not_in)
  relations <- relations[!relations$elements %in% remove_elements, ,
                         drop = FALSE]

  if (is.null(name)) {
    name <- paste(paste0(set_in, collapse = set_symbols["union"]),
           paste0(not_in, collapse = set_symbols["union"]),
           sep = set_symbols["minus"])
  }

  if (nrow(relations) >= 1) {
    relations$sets <- name
  }
  object <- add_sets(object, name)
  object <- replace_interactions(object, relations, keep_relations)

  if (!keep_elements) {
    object <- drop_elements(object)
  }
  if (!keep_sets) {
    object <- drop_sets(object)
  }
  object

}
