
#' Find which variables are independently
#'
#' @param x Data.frame or matrix with logical or dummy (0, and 1) variables
#' @returns A list of the variables that do not overlap. There might be some missing variables.
overlap_variables <- function(x) {
    if (is.data.frame(x)) {
        v <- vapply(x, is.logical, logical(1L))
    } else  if (is.matrix(x)) {
        v <- apply(x, 2, is.logical)
    }
    is_logical <- all(v)
    is.dummy <- function(y){all(y %in% c(0, 1))}
    if (!is_logical) {
        if (is.data.frame(x)) {
            v2 <- vapply(x, is.dummy, logical(1L))
        } else  if (is.matrix(x)) {
            v2 <- apply(x, 2, is.dummy)
        }
        stopifnot("It is not dummy or logical" = all(v2))
    }
    vars <- colnames(x)
    co <- combn(vars, 2, FUN = function(var, y){
        a <- var[1]
        b <- var[2]
        if (is_logical & is.data.frame(y)) {
            out <- any(y[[a]] & y[[b]]) && any(!y[[a]] & !y[[b]])
        } else {
            out <- any(y[[a]] & y[[b]]) && any(!y[[a]] & !y[[b]])
        }
        data.frame(var1 = a, var2 = b, o = out)
    }, y = x, simplify = FALSE)
    coo <- do.call(rbind, co)
    combn_out <- coo[!coo$o, ]

    vars1 <- unique(c(combn_out$var1, combn_out$var2))
    l <- lapply(vars, function(i) {
        keep <- combn_out$var1 == i
        a <- unique(c(combn_out$var1[keep], combn_out$var2[keep]))
    })
    l <- l[lengths(l) != 0]
    vars2 <- sort(table(unlist(l, FALSE, FALSE)), decreasing = TRUE)
    vars2 <- names(vars2)[vars2 >= 2]
    out <- vector("list", length = length(vars2))
    for (i in seq_along(vars2)) {
        o <- vapply(l, function(x){vars2[i] %in% x}, logical(1L))
        out[[i]] <- unique(unlist(l[o], FALSE, FALSE))
    }

    unique(out)
}
