#' @include AllClasses.R AllGenerics.R
#' @importFrom dplyr group_by
#' @export
dplyr::group_by

#' group_by TidySet
#'
#' Use group_by to group the TidySet object. You can use activate with
#' group_by or with the whole data.
#' @param .data The TidySet object
#' @param ... The logical predicates in terms of the variables of the sets
#' @return A grouped data.frame (See The dplyr help page)
#' @export
#' @family methods
#' @seealso dplyr \code{\link[dplyr]{group_by}} and \code{\link{activate}}
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
#'     elements = rep(letters[seq_len(6)], 2),
#'     fuzzy = runif(12)
#' )
#' a <- tidySet(relations)
#' elements(a) <- cbind(elements(a),
#'     type = c(rep("Gene", 4), rep("lncRNA", 2))
#' )
#' group_by(a, elements)
#' @rdname group_by_
#' @export
#' @method group_by TidySet
group_by.TidySet <- function(.data, ...) {
    if (is.null(active(.data))) {
        dplyr::group_by(as.data.frame(.data), ...)
    } else {
        dplyr::group_by(slot(.data, active(.data)), ...)
    }
}
