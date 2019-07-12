#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn name_sets Name sets
#' @export name_sets
setMethod("name_sets",
          signature = signature(object = "TidySet"),
          function(object) {
            s <- sets(object)$sets
            if (is.factor(s)) {
              levels(s)
            } else if (is.character(s)) {
              s
            }
          }
)

#' @describeIn name_elements Name elements
#' @export name_elements
setMethod("name_elements",
          signature = signature(object = "TidySet"),
          function(object){
            e <- elements(object)$elements
            if (is.factor(e)) {
              levels(e)
            } else if (is.character(e)) {
              e
            }
          }
)

#' @describeIn name_elements Rename elements
#' @export name_elements<-
setMethod("name_elements<-",
          signature = signature(object = "TidySet", value = "characterORfactor"),
          function(object, value){
            old <- name_elements(object)

            if (is.factor(value)) {
              value <- as.character(value)
            }
            value2 <- rep(value, length.out = length(old))
            if (is.factor(object@elements$elements)) {
                levels(object@elements$elements) <- value2
            } else {
                object@elements$elements <- value2
            }
            object@elements <- unique(object@elements)
            if (anyDuplicated(object@elements$element) > 0) {
              stop("Duplicated elements but with different information",
                   call. = FALSE)
            }

            old_relations <- object@relations$elements
            if (is.factor(old_relations)) {
                old_relations <- levels(old_relations)
                replace <- match(old_relations, old)
                levels(object@relations$elements)<- value[replace]
            } else {
                replace <- match(old_relations, old)
                object@relations$elements <- value[replace]
            }

            validObject(object)
            object
          }
)
#' @describeIn name_sets Rename sets
#' @export name_sets<-
setMethod("name_sets<-",
          signature = signature(object = "TidySet", value = "characterORfactor"),
          function(object, value) {
            old <- name_sets(object)

            if (is.factor(value)) {
              value <- as.character(value)
            }
            value2 <- rep(value, length.out = length(old))
            if (is.factor(object@sets$sets)) {
                levels(object@sets$sets) <- value2
            } else {
                object@sets$sets <- value2
            }
            object@sets <- unique(object@sets)
            if (anyDuplicated(object@sets$sets) > 0) {
              stop("Duplicated sets but with different information",
                   call. = FALSE)
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
