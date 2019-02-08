#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn name_sets Name sets
#' @export name_sets
setMethod("name_sets",
          signature = signature(object = "TidySet"),
          function(object){
            if (validObject(object)) {
              levels(sets(object)$set)
            } else {
              as.character(relations(object)$sets)
            }
          }
)

#' @describeIn name_elements Name elements
#' @export name_elements
setMethod("name_elements",
          signature = signature(object = "TidySet"),
          function(object){
            if (validObject(object)) {
              levels(elements(object)$elements)
            } else {
              as.character(relations(object)$elements)
            }
          }
)

#' @describeIn name_elements Rename elements
#' @export name_elements<-
setMethod("name_elements<-",
          signature = signature(object = "TidySet", value = "character"),
          function(object, value){
            old <- levels(object@elements$elements)
            value2 <- rep(value, length.out = length(name_elements(object)))
            levels(object@elements$elements) <- value2
            object@elements <- unique(object@elements)
            if (anyDuplicated(object@elements$element)) {
              stop("Duplicated elements but with different information")
            }

            old_relations <- levels(object@relations$elements)
            replace <- match(old_relations, old)
            levels(object@relations$elements)[replace] <- value
            validObject(object)
            object
          }
)
#' @describeIn name_sets Rename sets
#' @export name_sets<-
setMethod("name_sets<-",
          signature = signature(object = "TidySet", value = "character"),
          function(object, value){
            old <- levels(object@sets$set)
            value2 <- rep(value, length.out = length(name_sets(object)))
            levels(object@sets$set) <- value2
            object@sets <- unique(object@sets)
            if (anyDuplicated(object@sets$set)) {
              stop("Duplicated sets but with different information")
            }
            old_relations <- levels(object@relations$sets)
            replace <- match(old_relations, old)
            levels(object@relations$sets)[replace] <- value
            validObject(object)
            object
          }
)
