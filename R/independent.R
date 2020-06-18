
#' Independence of the sets
#'
#' Checks if the elements of the sets are present in more than one set.
#' @param object A [`TidySet`] object.
#' @param sets A character vector with the names of the sets to analyze.
#' @return A logical value indicating if the sets are independent (TRUE) or not.
#' @export
#' @examples
#' x <- list("A" = letters[1:5], "B" = letters[3:7], "C" = letters[6:10])
#' TS <- tidySet(x)
#' independent(TS)
#' independent(TS, c("A", "B"))
#' independent(TS, c("A", "C"))
#' independent(TS, c("B", "C"))
independent <- function(object, sets) {
    UseMethod("independent")
}

#' @export
#' @method independent TidySet
independent.TidySet <- function(object, sets = NULL) {
    if (is.null(sets)) {
        sets <- name_sets(object)
    } else if (any(!sets %in% name_sets(object))) {
        warning("Some sets provided are not present")
    }

    relations <- relations(object)
    flag <- anyDuplicated(relations$elements[relations$sets %in% sets])
    flag == 0
}
