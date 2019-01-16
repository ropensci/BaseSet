#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn relations Retrieve the relations
#' @export
setMethod("relations",
          signature = signature(object = "TidySet"),
          function(object) {
            slot(object, "relations")
          })

#' @describeIn relations Modify the relations
#' @export
setMethod("relations<-",
          signature = signature(object = "TidySet"),
          function(object, value) {
            slot(object, "relations") <- value
            object
          })


#' @describeIn nRelations Return the number of relations
#' @export
setMethod("nRelations",
          signature = signature(object = "TidySet"),
          function(object) {
            nrow(slot(object, "relations"))
          })

#' @describeIn is.fuzzy Check if it is fuzzy
#' @export
setMethod("is.fuzzy",
          signature = signature(object = "TidySet"),
          function(object) {
            "fuzzy" %in% colnames(slot(object, "relations"))
          })
