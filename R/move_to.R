

#' @export
move_to <- function(object, from, to, columns) {
  from <- match.arg(from, c("sets", "elements", "relations"))
  to <- match.arg(to, c("sets", "elements", "relations"))
  from_df <- slot(object, from)
  moving <- unique(from_df[, columns, drop = FALSE])
  add_column(object, slot, moving)
}
