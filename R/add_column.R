#' @include AllGenerics.R AllClasses.R
NULL

#' @describeIn add_column Add a column to any slot
#' @export
setMethod("add_column",
    signature = signature(
        object = "TidySet",
        slot = "character",
        columns = "ANY"
    ),
    function(object, slot, columns) {
        slot <- match.arg(slot, c("sets", "elements", "relations"))
        original <- slot(object, slot)

        if (nrow(columns) != nrow(original)) {
            stop("Please columns should be of the same size as the slot",
                call. = FALSE
            )
        }
        out <- cbind(original, columns)
        slot(object, slot) <- out
        validObject(object)
        object
    }
)
