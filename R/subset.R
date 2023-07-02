# From: https://stackoverflow.com/a/10961998
## $ ####
#' @export
setMethod("$", "TidySet",
          function(x, name) {
            if (name %in% colnames(relations(x))) {
              return(slot(x, "relations")[[name]])
            }
            if (name %in% colnames(sets(x))) {
              return(slot(x, "sets")[[name]])
            }
            if (name %in% colnames(elements(x))) {
              return(slot(x, "elements")[[name]])
            }
            NULL
          })

#' @export
setMethod("$<-", "TidySet",
          function(x, name, value) {
            w <- which(length(value) == dim(x))
            if (length(w) == 0) {
              w <- 2
              value <- rep(value, nRelations(x))
            } else if (length(w) == 2 && 2 %in% w) {
              # If multiple slots match assign to relations
              warning("Matching multiple slots. Assigning value to relations.",
                      call. = FALSE)
              w <- 2
            } else if (length(w) == 2) {
              warning("Matching multiple slots. Randomly assigning the value.",
                      call. = FALSE)
              w <- sample(w, 1)
            }

            if (w == 1) {
              elements(x)[[name]] <- value
            } else if (w == 2) {
              relations(x)[[name]] <- value
            } else if (w == 3) {
              sets(x)[[name]] <- value
            }

            x
          })


## [ ####
#' @examples
#' TS[1, "elements"]
#' TS[, "sets", "type"]
#' TS[, "sets", c("type", "origin")]
#' TS[, "sets"]
#' @export
setMethod("[", "TidySet",
          function(x, i, j, k, ..., drop = TRUE) {
            if (!missing(i) && is.character(i)) {
              stop("TidySet does not accept characters as `i` index for `[`.",
                   "\nDid you meant to use [[ instead?", call. = FALSE)
            }

            if (missing(j)) {
              j <- "relations"
            }
            if (length(j) > 1 || is.na(j)) {
              stop("j only accepts: 'elements', 'sets' and ' relations'")
            }
            j <- match.arg(j, c("elements", "sets", "relations"))
            s <-  slot(x, j)
            if (missing(k)) {
              k <- 1
            }

            k <- keep_columns(j, k)
            if (missing(i)) {
              s2 <- s[, k, ..., drop = FALSE]
            } else {
              s2 <- s[i, k, ..., drop = FALSE]
              rownames(s2) <- NULL
            }
            slot(x, j) <- s2
            droplevels(x, elements = drop, sets = drop, relations = drop)
          })

#' @examples
#' TS[, "sets", "origin"] <- "abDT"
#' TS[1, "sets", "sets"] <- "Abcd"
#' @export
setMethod("[<-", "TidySet",
          function(x, i, j, k, ..., value) {
            if (missing(j)) {
              j <- "relations"
            }
            j <- match.arg(j, c("elements", "sets", "relations"))
            s <-  slot(x, j)
            if (missing(k)) {
              k <- 1
            }

            s[i, k, ...] <- value
            slot(x, j) <- s
            drop <- TRUE
            droplevels(x, elements = drop, sets = drop, relations = drop)
          })

## [[ ####
#' @export
#' @examples
#' TS[["A"]]
#' TS[["A"]]
setMethod("[[", "TidySet",
          function(x, i, j, ..., exact =TRUE) {
            i <- unique(i)
            i <- i[!is.na(i)]
            if (length(i) > 1) {
              stop("Trying to extract more than one set.", call. = FALSE)
            }
            stopifnot(rlang::is_logical(exact))
            if (missing(j)) {
              j <- 1
            }
            j <- keep_columns("sets", j)
            ns <- nSets(x)
            logical_i <- is.logical(i) && length(i) > ns
            numeric_i <- is.numeric(i) && max(i, na.rm = TRUE) > ns
            if ( logical_i | numeric_i) {
              stop("Sets requested not available.")
            }
            nams <- name_sets(x)
            if (is.character(i)) {
              nsi <- i
            } else if (is.character(i) && !exact) {
              nsi <- pmatch(i, table = nams)
            } else {
              nsi <- nams[i]
            }
            namsi <- match(nsi, nams)
            x[namsi, "sets", j, drop = TRUE]
          })

keep_columns <- function(j, k) {
  if (is.numeric(k) && j == "relations") {
    return(unique(c(1:3, k)))
  } else if (is.numeric(k)) {
    return(unique(c(1, k)))
  }
  cc <- character_columns(j, k)
  if (!is.null(cc)) {
    return(cc)
  }

  if (is.logical(k) && j == "relations") {
    return(c(TRUE, TRUE, TRUE, k))
  } else {
    return(c(TRUE, k))
  }
}

character_columns <- function(j, k) {
  if (!is.character(k)) {
    return(NULL)
  }
  if (j == "relations") {
    return(unique(c("elements", "sets", "fuzzy", k)))
  } else if (j == "sets") {
    return(unique(c("sets", k)))
  } else if (j == "elements") {
    return(unique(c("elements", k)))
  }
}
