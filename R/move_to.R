#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn move_to Move columns
#' @export
setMethod("move_to",
    signature = signature(
        object = "TidySet",
        from = "characterORfactor",
        to = "characterORfactor",
        columns = "character"
    ),
    function(object, from, to, columns) {
        if (from == to) {
            return(object)
        }

        from <- match.arg(from, c("sets", "elements", "relations"))
        to <- match.arg(to, c("sets", "elements", "relations"))
        from_df <- slot(object, from)
        to_df <- slot(object, to)
        if (!all(columns %in% colnames(from_df))) {
            stop("All columns must come from the same table.",
                call. = FALSE
            )
        }
        df <- as.data.frame(object)

        to_colnames <- colnames(to_df)
        from_colnames <- colnames(from_df)

        new_to <- unique(df[, c(to_colnames, columns), drop = FALSE])
        new_from <- unique(from_df[, !from_colnames %in% columns,
            drop = FALSE
        ])
        slot(object, to, check = FALSE) <- new_to
        slot(object, from, check = FALSE) <- new_from
        validObject(object)
        object
    }
)
