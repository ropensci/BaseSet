# for autocomplete: https://stackoverflow.com/a/52348809
#' @importFrom utils .DollarNames
#' @export
.DollarNames.TidySet <- function(x, pattern = "") {
  #x is the .CompletionEnv
  # Get the columns of each slot and provide it without merging everything
  r <- relations(x)[1:2, , drop = FALSE]
  s <- sets(x)[1:2, , drop = FALSE]
  e <- elements(x)[1:2, , drop = FALSE]
  l <- lapply(list(r, s, e), colnames)
  unique(unlist(l, FALSE, FALSE))
}


in_slots <- function(x, fun, ...) {
    l <- list(Elements = slot(x, "elements"),
         Relations = slot(x, "relations"),
         Sets = slot(x, "sets"))
    sapply(l, fun, ...)
}

# For usethis::use_release helper when making a release
release_bullets <- function() {
    c("Run `pkgdown::check_pkgdown()`")
}
