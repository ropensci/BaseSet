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
            s <- merge(object@relations, object@sets,
                       by.x = "sets", by.y = "sets", sort = FALSE,
                       all.x = TRUE)
            o <- merge(s, object@elements,
                       by.x = "elements", by.y = "elements", sort = FALSE,
                       all.x = TRUE)

            # Don't show the fuzzy column if they are all fuzzy
            # Could confuse users when they see this column appear in relations
            if (!is.fuzzy(object)) {
              keep <- setdiff(colnames(o), "fuzzy")
              o <- o[, keep]
            }
            print(o)
          })
