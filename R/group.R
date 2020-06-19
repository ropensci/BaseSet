#' @include AllClasses.R AllGenerics.R
NULL

#' Create a new set from existing elements
#'
#' It allows to create a new set given some condition. If no element meet the
#' condition an empty set is created.
#' @param object A TidySet object.
#' @param name The name of the new set.
#' @param ... A logical condition to subset some elements.
#' @return A TidySet object with the new set.
#' @family methods
#' @export
#' @examples
#' x <- list("A" = c("a" = 0.1, "b" = 0.5), "B" = c("a" = 0.2, "b" = 1))
#' TS <- tidySet(x)
#' TS1 <- group(TS, "C", fuzzy < 0.5)
#' TS1
#' sets(TS1)
#' TS2 <- group(TS, "D", fuzzy < 0)
#' sets(TS2)
#' r <- data.frame(
#'     sets = c(rep("A", 5), "B", rep("A2", 5), "B2"),
#'     elements = rep(letters[seq_len(6)], 2),
#'     fuzzy = runif(12),
#'     type = c(rep("Gene", 2), rep("Protein", 2), rep("lncRNA", 2))
#' )
#' TS3 <- tidySet(r)
#' group(TS3, "D", sets %in% c("A", "A2"))
group <- function(object, name, ...) {
    UseMethod("group")
}

#' @rdname group
#' @export
group.TidySet <- function(object, name, ...) {
    object <- tryCatch({
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
        object
    },
    error = function(x){
        add_sets(object, name)
    })

    validObject(object)
    object
}
