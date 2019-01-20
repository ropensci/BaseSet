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

names_elements <- function(object){
  levels(elements(object)$elements)
}
