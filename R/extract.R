#' @include AllClasses.R AllGenerics.R
NULL

#' Extract
#'
#' Operators acting on TidySet to extract or replace parts.
#' They are designed to resemble the basic operators.
#' @param x A TidySet object.
#' @param name The data about the TidysSet object to extract.
#' @param value The value to overwrite
#' @param i Which rows do you want to keep? By default all.
#' @param j Which slot do you want to extract? One of "sets", "elements" or
#' "relations".
#' @param k Which columns do you want to extract. By default all.
#' @param ... Other arguments currently ignored.
#' @param drop Remove remaining elements, sets and relations? Passed to all
#' arguments of [droplevels()].
#' @param exact A logical value. FALSE if fuzzy matching is wanted.
#' Add values to the TidySet. Allows to control to which slot is it added.
#' @return Always returns a valid [TidySet].
#'
#' @examples
#' TS <- tidySet(list(A = letters[1:5], B = letters[6]))
#' TS[, "sets", "origin"] <- sample(c("random", "non-random"), 2, replace = TRUE)
#' TS[, "sets", "type"] <- c("Fantastic", "Wonderful")
#' # This produces a warning
#  TS$description <- c("What", "can", "I", "say", "now", "?")
#' # Better to be explicit:
#' TS[, "relations", "description"] <- c("What", "can", "I", "say", "now", "?")
#' relations(TS)
#' TS[, "elements", "description"] <- rev(c("What", "can", "I", "say", "now", "?"))
#' elements(TS)
#' # Which will be deleted?
#' # TS$description <- NULL
#' TS$type
#' TS$origin <- c("BCN", "BDN")
#' # Different subsets
#' TS[1, "elements"]
#' TS[1, "sets"]
#' # Always print
#' TS
#' TS[, "sets", c("type", "origin")] # Same
#' TS[, "sets", "origin"] # Drop column type
#' is(TS[, "sets", "origin"])
#' TS[, "sets"]
#' TS[["A"]]
#' TS[["B"]]
#' TS[["C"]] # Any other set is the empty set
#' @rdname extract-TidySet
#' @name extract-TidySet
NULL

# From: https://stackoverflow.com/a/10961998
# $ ####


#' @rdname extract-TidySet
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

#' @rdname extract-TidySet
#' @export
setMethod("$<-", "TidySet",
          function(x, name, value) {
              p_length <- which(length(value) == dim(x))
              # As per dim named output
              p_named <- switch(name,
                                elements = 1,
                                fuzzy = 2,
                                sets = 3,
                                NA)

              if (is.na(p_named)) {
                  p_named <- in_slots(x, function(x, y){
                      y %in% colnames(x)},
                      y = name)
                  p_named <- which(p_named)
              }
              # unknown new column to relations
              if (length(p_named) == 0 && length(p_length) == 0) {
                  pos <- 2
                  value <- rep(value, nRelations(x))
              }
              #  Not tested with a relation documented multiple times!
              if (length(p_named) > 1 && length(p_length) > 1) {
                  p_named <- intersect(p_named, p_length)
              } else if (length(p_named) == 0 && length(p_length) > 1) {
                  p_named <- p_length
              }

              if (length(p_named) > 1) {
                  if (2 %in% p_named) {
                      warning("Matching multiple slots. Assigning value to relations.",
                              call. = FALSE)
                      pos <- 2
                  } else {
                      warning("Matching multiple slots. Randomly assigning the value.",
                              call. = FALSE)
                      pos <- sample(p_named, 1)
                  }
              } else {
                  pos <- p_named
              }

              if (pos == 1) {
                  elements(x)[[name]] <- value
              } else if (pos == 2) {
                  relations(x)[[name]] <- value
              } else if (pos == 3) {
                  sets(x)[[name]] <- value
              }
              droplevels(x)
          })


# [ ####

#' @rdname extract-TidySet
#' @export
setMethod("[", "TidySet",
          function(x, i, j, k, ..., drop = TRUE) {
              if (!missing(i) && is.character(i)) {
                  stop("TidySet does not accept characters as `i` index for `[`.",
                       "\nDid you meant to use [[ instead?", call. = FALSE)
              }
              stopifnot(is.logical(drop))
              if (missing(j)) {
                  j <- "relations"
              }
              if (length(j) > 1 || is.na(j)) {
                  stop("j only accepts: 'elements', 'sets' and ' relations'")
              }
              j <- match.arg(j, c("elements", "sets", "relations"))
              s <-  slot(x, j)
              if (missing(k)) {
                  k <- seq_len(ncol(s))
              }

              k <- keep_columns(j, k)
              if (missing(i)) {
                  s2 <- s[, k, ..., drop = FALSE]
              } else {
                  s2 <- s[i, k, ..., drop = FALSE]
                  rownames(s2) <- NULL
              }
              slot(x, j) <- s2
              if (drop) {
                  x <- switch(j,
                              "sets" = drop_sets(x),
                              "elements" = drop_elements(x),
                              x)
                  x <- drop_relations(x)
              }
              validObject(x)
              x
          })

#' @export
#' @rdname extract-TidySet
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
              if (length(k) == 1 && NCOL(value) > 1) {
                  if (missing(i)) {
                      i <- ""
                  }
                  msg <- paste0("TS[", i, ", '", j, "', ", "c('column1', 'column2')] <- value")
                  stop("Assigning multiple columns to a single position!\nUse one of:\n",
                       "add_column(TS, '", j, "', value) or ",msg)
              }
              s[i, k, ...] <- value
              slot(x, j) <- s
              validObject(x)
              x
          })

# [[ ####
#' @export
#' @rdname extract-TidySet
setMethod("[[", "TidySet",
          function(x, i, j, ..., exact =TRUE) {
              if (missing(i)) {
                  stop("missing subscript")
              }
              i <- unique(i)
              i <- i[!is.na(i)]
              if (length(i) > 1) {
                  stop("Trying to extract more than one set.")
              }
              stopifnot(isTRUE(exact) || isFALSE(exact))
              if (missing(j)) {
                  j <- seq_len(ncol(sets(x)))
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

#' @export
#' @rdname extract-TidySet
setMethod("[[<-", "TidySet",
          function(x, i, value) {
              if (missing(i)) {
                  stop("missing subscript")
              }
              if (is.null(value)) {
                  errors <- character()
              } else {
                  errors <- valid_sets(value)
              }

              if (length(errors) != 0) {
                  stop(paste(errors, collapse = "\n"))
              }
              i <- unique(i)
              i <- i[!is.na(i)]
              if (length(i) > 1) {
                  stop("Trying to extract more than one set.")
              }

              ns <- nSets(x)
              logical_i <- is.logical(i) && length(i) > ns
              numeric_i <- is.numeric(i) && max(i, na.rm = TRUE) > ns
              if ( logical_i | numeric_i) {
                  stop("Sets requested not available.")
              }
              nams <- name_sets(x)
              if (is.character(i)) {
                  nsi <- i
              } else {
                  nsi <- nams[i]
              }
              y <- remove_set(x, nsi)

              if (is.null(value)) {
                  return(y)
              }

              new_sets <- merge(sets(y), value, all = TRUE, sort = FALSE)
              sets(y) <- new_sets
              y <- drop_relations(y)
              validObject(y)
              y
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
