#' @include AllClasses.R AllGenerics.R
NULL

# TODO Allow a vector for set1 and set2
# TODO Allow to keep old sets
operation_helper <- function(object, set1, set2, setName, FUN, keep = FALSE) {

  if (!is.logical(keep) || length(keep) > 1) {
    stop("keep should be a logical value")
  }

  if (length(set1) != length(set2)) {
    stop("Recycling set1 and set2 should be of the same length")
  }

  if (!keep) {
    sets <- name_sets(object)
    levels(object@sets$set)[sets %in% set1] <- setName
    levels(object@sets$set)[sets %in% set2] <- setName
    object@sets <- unique(object@sets)

    sets2 <- levels(object@relations$sets)
    levels(object@relations$sets)[sets2 %in% set1] <- setName
    levels(object@relations$sets)[sets2 %in% set2] <- setName
  }
  # Handle the duplicate cases
  basic <- paste(object@relations$sets, object@relations$elements)
  indices <- split(seq_along(basic), basic)
  # Helper function probably useful for intersection too
  iterate <- function(i, fuzzy, fun) {
    fun(fuzzy[i])
  }
  # It could be possible to apply some other function to the relations
  # that are the same
  FUN <- match.fun(FUN)
  fuzzy <- vapply(indices, iterate, fuzzy = object@relations$fuzzy,
                  fun = FUN, numeric(1L))
  relations2 <- unique(object@relations[, c("sets", "elements")])
  relations2 <- cbind.data.frame(relations2, fuzzy = fuzzy)
  object@relations <- relations2
  validObject(object)
  object
}
