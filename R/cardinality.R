
#' @param FUN Function that returns a single numeric value given a vector of
#' fuzzy values.
#' @param ... Other arguments passed to `FUN`.
#' @describeIn cardinality Cardinality of sets
#' @export cardinality
setMethod("cardinality",
          signature = signature(object = "TidySet"),
          function(object, sets, FUN = "sum", ...) {
          FUN <- match.fun(FUN)
          rel <- relations(object)
          if (is.null(sets)) {
              sets <- name_sets(object)
          }
          rel <- rel[rel$sets %in%  sets, ]
          fuzzy <- split(rel$fuzzy, rel$sets)
          card <- vapply(fuzzy, FUN, FUN.VALUE = numeric(1L), ... = ...)
          df <- data.frame(sets = names(fuzzy), cardinality = card)
          rownames(df) <- NULL
          df
          })
