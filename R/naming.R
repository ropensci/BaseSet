# Null doesn't use a symbol
# Other it is a symbol
collapse_sets <- function(sets, symbol = "union") {
    symbol <- check_symbol(symbol)

    if (length(symbol) == 0) {
        stop("Unrecognized set symbol. See set_symbols")
    }

    if (length(sets) > 1) {
        paste0(sets, collapse = set_symbols[symbol])
    } else {
        sets
    }
}

check_symbol <- function(symbol) {
    p <- pmatch(symbol, names(set_symbols))
    names(set_symbols)[p]
}

#' Name an operation
#'
#' Helps setting up the name of an operation.
#' @param start,middle Character used as a start symbol or to divide
#' \code{sets1} and \code{sets2}.
#' @param sets1,sets2 Character of sets
#' @param collapse_symbol Name of the symbol that joins the sets on
#' \code{sets1} and \code{sets2}.
#' @seealso \code{\link{set_symbols}}
#' @return A character vector combining the sets
#' @export
#' @examples
#' naming(sets1 = c("a", "b"))
#' naming(sets1 = "a", middle = "union", sets2 = "b")
#' naming(sets1 = "a", middle = "intersection", sets2 = c("b", "c"))
#' naming(sets1 = "a", middle = "intersection", sets2 = c("b", "c"))
#' naming(
#'     start = "complement", sets1 = "a", middle = "intersection",
#'     sets2 = c("b", "c"), collapse_symbol = "intersection"
#' )
naming <- function(start = NULL, sets1, middle = NULL, sets2 = NULL,
    collapse_symbol = "union") {
    msg <- "Symbol should be of length 1"
    longer <- any(c(length(collapse_symbol), length(start), length(middle)) > 1)
    if (longer) {
        stop(msg)
    }

    start <- check_symbol(start)
    if (!is.null(sets2) && is.null(middle)) {
        stop("sets1 and sets2 should be separated by a symbol")
    }
    middle <- check_symbol(middle)

    nSets1 <- length(sets1)
    nSets2 <- length(sets2)

    # Join the sets
    sets1 <- collapse_sets(sets1, collapse_symbol)
    sets2 <- collapse_sets(sets2, collapse_symbol)

    # Add parenthesis
    if (length(middle) != 0 && middle == check_symbol(collapse_symbol)) {
        return(paste0(set_symbols[start], sets1, set_symbols[middle], sets2))
    }

    if (!is.null(sets2) && nSets1 > 1) {
        sets1 <- paste0("(", sets1, ")")
    }
    if (nSets2 > 1) {
        sets2 <- paste0("(", sets2, ")")
    }

    paste0(set_symbols[start], sets1, set_symbols[middle], sets2)
}
