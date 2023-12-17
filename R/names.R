#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn name_sets Name sets
#' @export name_sets
setMethod("name_sets",
          signature = signature(object = "TidySet", all = "logical"),
          function(object, all = TRUE) {
              s <- sets(object)$sets
              if (is.factor(s) && isTRUE(all)) {
                  levels(s)
              } else if (is.factor(s) && isFALSE(all)) {
                  as.character(s)
              } else if (is.character(s)) {
                  s
              }
          }
)
#' @describeIn name_sets Name sets
#' @export name_sets
setMethod("name_sets",
          signature = signature(object = "TidySet", all = "missing"),
          function(object, all) {
              name_sets(object, TRUE)
          }
)

#' @describeIn name_elements Name elements
#' @export name_elements
setMethod("name_elements",
          signature = signature(object = "TidySet", all = "logical"),
          function(object, all = TRUE) {
              e <- elements(object)$elements
              if (is.factor(e) && isTRUE(all)) {
                  levels(e)
              } else if (is.factor(e) && isFALSE(all)) {
                  as.character(e)
              } else if (is.character(e)) {
                  e
              }
          }
)

#' @describeIn name_elements Name elements
#' @export name_elements
setMethod("name_elements",
          signature = signature(object = "TidySet", all = "missing"),
          function(object, all) {
              name_elements(object, TRUE)
          }
)

#' @describeIn name_elements Rename elements
#' @export name_elements<-
setMethod("name_elements<-",
          signature = signature(
              object = "TidySet",
              all = "logical",
              value = "characterORfactor"
          ),
          function(object, all, value) {
              old <- name_elements(object, all)

              if (is.factor(value)) {
                  value <- as.character(value)
              }

              elements <- elements(object)
              if (is.factor(elements$elements)) {
                  levels(elements$elements) <- value
              }
              if (length(value) == length(old)) {
                  elements$elements <- value
              } else if (length(value) > length(old)) {
                  stop("More elements provided than existing.\n\t",
                       "Use add_elements() if you want to add elements.",
                       call. = FALSE)
              } else {
                  stop("Less names provided than existing.\n\t",
                       "Use filter() if you want to remove some elements",
                       call. = FALSE)
              }

              object@elements <- unique(elements)
              if (anyDuplicated(object@elements$elements) > 0) {
                  stop("Duplicated elements but with different information",
                       call. = FALSE
                  )
              }

              old_relations <- object@relations$elements
              if (is.factor(old_relations)) {
                  old_relations <- levels(old_relations)
                  replace <- match(old_relations, old)
                  levels(object@relations$elements) <- value[replace]
              } else {
                  replace <- match(old_relations, old)
                  object@relations$elements <- value[replace]
              }

              validObject(object)
              object
          }
)
#' @describeIn name_elements Rename elements
#' @export name_elements<-
setMethod("name_elements<-",
          signature = signature(
              object = "TidySet",
              all = "missing",
              value = "characterORfactor"
          ),
          function(object, value) {
              name_elements(object, TRUE) <- value
              object
          }
)

#' @describeIn name_sets Rename sets
#' @export name_sets<-
setMethod("name_sets<-",
          signature = signature(
              object = "TidySet",
              all = "logical",
              value = "characterORfactor"
          ),
          function(object, all, value) {
              old <- name_sets(object, all)

              if (is.factor(value)) {
                  value <- as.character(value)
              }
              sets <- sets(object)
              if (is.factor(sets$sets)) {
                  levels(sets$sets) <- value
              }

              if (length(value) == length(old)) {
                  sets$sets <- value
              } else if (length(value) > length(old)) {
                  stop("More sets provided than existing.\n\t",
                       "Use add_sets() if you want to add sets.",
                       call. = FALSE)
              } else {
                  stop("Less names provided than existing.\n\t",
                       "Use filter() if you want to remove some sets.",
                       call. = FALSE)
              }

              object@sets <- unique(sets)
              if (anyDuplicated(object@sets$sets) > 0) {
                  stop("Duplicated sets but with different information",
                       call. = FALSE
                  )
              }
              old_relations <- object@relations$sets
              if (is.factor(old_relations)) {
                  old_relations <- levels(old_relations)
                  replace <- match(old_relations, old)
                  levels(object@relations$sets) <- value[replace]
              } else {
                  replace <- match(old_relations, old)
                  object@relations$sets <- value[replace]
              }
              validObject(object)
              object
          }
)
#' @describeIn name_sets Rename sets
#' @export name_sets<-
setMethod("name_sets<-",
          signature = signature(
              object = "TidySet",
              all = "missing",
              value = "characterORfactor"
          ),
          function(object, all, value) {
              name_sets(object, TRUE) <- value
              object
          }
)

#' Dimnames of a TidySet
#'
#' Retrieve the column names of the slots of a TidySet.
#' @param x A TidySet object.
#' @returns A list with the names of the columns of the sets, elements and
#' relations.
#' @seealso [names()]
#' @export
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("a", 5), "b"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' TS <- tidySet(relations)
#' dimnames(TS)
dimnames.TidySet <- function(x) {
    list(sets = colnames(x@sets),
         elements = colnames(x@elements),
         relations = colnames(x@relations))
}


#' Names of a TidySet
#'
#' Retrieve the column names of a slots of a TidySet.
#' @param x A TidySet object.
#' @returns A vector with the names of the present columns of the sets, elements and
#' relations.
#' If a slot is active it only returns the names of that slot.
#' @seealso [dimnames()]
#' @export
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("a", 5), "b"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' TS <- tidySet(relations)
#' names(TS)
#' names(activate(TS, "sets"))
names.TidySet <- function(x) {
    if (is.null(active(x))) {
        unique(unlist(dimnames(x), FALSE, FALSE))
    } else {
        switch(active(x),
               sets = colnames(x@sets),
               elements = colnames(x@elements),
               relations = colnames(x@relations))
    }
}
