#' @export
setMethod("relations",
          signature = signature(object = "TidySet"),
          function(object) {
            slot(object, "relations")
          })

#' @export
setMethod("relations<-",
          signature = signature(object = "TidySet"),
          function(object, value) {
            slot(object, "relations") <- value
          })


#' @export
setMethod("nRelations",
          signature = signature(object = "TidySet"),
          function(object) {
            nrow(slot(object, "relations"))
          })

#' @export
setMethod("is.fuzzy",
          signature = signature(object = "TidySet"),
          function(object) {
            "fuzzy" %in% colnames(slot(object, "relations"))
          })
