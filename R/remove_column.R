#' @include AllGenerics.R AllClasses.R
NULL

#' @describeIn remove_column Remove columns to any slot
#' @export
setMethod("remove_column",
    signature = signature(
        object = "TidySet",
        slot = "character",
        column_names = "character"
    ),
    function(object, slot, column_names) {
        original <- slot(object, slot)
        remove <- colnames(original) %in% column_names
        slot(object, slot) <- original[, !remove]
        object
    }
)
