#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn name_sets Name sets
#' @export name_sets
setMethod("name_sets",
          signature = signature(object = "TidySet"),
          function(object){
            levels(sets(object)$set)
          }
)

#' @describeIn name_elements Name elements
#' @export name_elements
setMethod("name_elements",
          signature = signature(object = "TidySet"),
          function(object){
            levels(elements(object)$elements)
          }
)

#' @describeIn name_elements Rename elements
#' @export name_elements<-
setMethod("name_elements<-",
          signature = signature(object = "TidySet", value = "character"),
          function(object, value){

            old <- levels(object@elements$elements)

            levels(object@elements$elements) <- value
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

            levels(object@sets$set) <- value
            old_relations <- levels(object@relations$sets)
            replace <- match(old_relations, old)
            levels(object@relations$sets)[replace] <- value
            validObject(object)
            object
          }
)
