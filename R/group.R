#' @include AllClasses.R AllGenerics.R
NULL

#' Create a new set from existing elements
#'
#' @param object A TidySet object.
#' @param name The name of the new set.
#' @param ... A logical condition to subset some elements
#' @return A TidySet object with the new set
#' @family methods
#' @export
#' @examples
#' x <- list("a" = c("A" = 0.1, "B" = 0.5), "b" = c("A" = 0.2, "B" = 1))
#' a <- tidySet(x)
#' b <- group(a, "c", elements %in% c("A", "B"))
group <- function(object, name, ...) {
  UseMethod("group")
}

#' @rdname group
#' @export
group.TidySet <- function(object, name, ...) {

  out <- filter(object, ...)
  out <- elements(out)[, "elements", drop = FALSE]
  out$sets <- name
  out$fuzzy <- 1

  new_colnames <- setdiff(colnames(object@relations), colnames(out))
  out[, new_colnames] <- NA
  object@relations <- rbind(object@relations, out)

  new_colnames <- setdiff(colnames(object@sets), "sets")
  sets <- data.frame(sets = name)
  sets[, new_colnames] <- NA
  object@sets <- rbind(object@sets, sets)

  validObject(object)
  object
}
