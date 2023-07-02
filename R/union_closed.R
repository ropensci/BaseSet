#' Union closed sets
#'
#' Tests if a given object is union-closed.
#' @export
#' @inheritParams union
#' @return A logical value: `TRUE` if the combinations of sets produce already
#' existing sets, `FALSE` otherwise.
#' @examples
#' l <- list(A = "1",
#'      B = c("1", "2"),
#'      C = c("2", "3", "4"),
#'      D = c("1", "2", "3", "4")
#' )
#' TS <- tidySet(l)
#' union_closed(TS)
#' union_closed(TS, sets = c("A", "B", "C"))
#' union_closed(TS, sets = c("A", "B", "C", "D"))
union_closed <- function(object, ...) {
    UseMethod("union_closed")
}

#' @rdname union_closed
#' @export
#' @method union_closed TidySet
union_closed.TidySet <- function(object, sets = NULL, ...) {
    if (is.null(sets)) {
        sets <- name_sets(object)
    } else {
        stopifnot("All sets should be in the object" =
                      all(sets %in% name_sets(object)))
    }
    elements_sets <- lapply(sets, elements_in_set, object = object)
    elements_combn <- combn(sets, 2, elements_in_set,
                            object = object, simplify = FALSE)
    # Sort vector o make it easier to search
    elements_sets <- elements_sets[order(lengths(elements_sets))]
    for (set2 in elements_combn) {
        set2 <- unique(set2)
        v <- vector(length = length(sets))
        for (s in seq_along(elements_sets)) {
            ess <- elements_sets[[s]]
            same_length <- length(set2) == length(ess)
            no_outside_left <- length(setdiff(set2, ess)) == 0
            no_outside_right <- length(setdiff(ess, set2)) == 0
            if (same_length && no_outside_left && no_outside_right) {
                v[s] <- TRUE
                # If one set already matches do not look further
                break
            }
        }
        if (!any(v)) {
            return(FALSE)
        }
    }
    TRUE
}
