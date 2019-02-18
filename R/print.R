#' @include AllClasses.R
NULL

#' Method to show the TidySet object
#'
#' Prints the resulting table of a TidySet object
#' @param object A TidySet
#'
#' @return A table with the information of the relationships
#' @export
setMethod("show",
          signature = signature(object = "TidySet"),
          function(object) {
            validObject(object)
            o <- as.data.frame(object)
            print(o)
          })
