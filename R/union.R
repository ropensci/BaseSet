#' @include AllClasses.R AllGenerics.R operations.R
NULL

#' Join sets
#'
#' Given a TidySet merges several sets into the new one using the logic
#' defined on FUN.
#'
#' The default uses the `max` function following the [standard fuzzy
#' definition](https://en.wikipedia.org/wiki/Fuzzy_set_operations), but it can be
#' changed. See examples below.
#' @param object A TidySet object.
#' @param sets The name of the sets to be used.
#' @param name The name of the new set. By defaults joins the sets with an
#' \ifelse{latex}{\out{$\cap$}}{\ifelse{html}{\out{&cap;}}{}}.
#' @param FUN A function to be applied when performing the union.
#' The standard union is the "max" function, but you can provide any other
#' function that given a numeric vector returns a single number.
#' @param keep A logical value if you want to keep.
#' @param keep_relations A logical value if you wan to keep old relations.
#' @param keep_elements A logical value if you wan to keep old elements.
#' @param keep_sets A logical value if you wan to keep old sets.
#' @param ... Other named arguments passed to `FUN`.
#' @return A \code{TidySet} object.
#' @export
#' @family methods that create new sets
#' @family methods
#' @seealso [union_probability()]
#' @examples
#' # Classical set
#' rel <- data.frame(
#'     sets = c(rep("A", 5), "B", "B"),
#'     elements = c(letters[seq_len(6)], "a")
#' )
#' TS <- tidySet(rel)
#' union(TS, c("B", "A"))
#' # Fuzzy set
#' rel <- data.frame(
#'     sets = c(rep("A", 5), "B", "B"),
#'     elements = c(letters[seq_len(6)], "a"),
#'     fuzzy = runif(7)
#' )
#' TS2 <- tidySet(rel)
#' # Standard default logic
#' union(TS2, c("B", "A"), "C")
#' # Probability logic
#' union(TS2, c("B", "A"), "C", FUN = union_probability)
union <- function(object, ...) {
    UseMethod("union")
}

# #' @export
# union.default <- function(object, ...) {
#     stopifnot(length(list(...)) == 1)
#     base::union(object, ...)
# }

#' @rdname union
#' @export
#' @method union TidySet
union.TidySet <- function(object, sets, name = NULL, FUN = "max", keep = FALSE,
    keep_relations = keep,
    keep_elements = keep,
    keep_sets = keep, ...) {
    if (is.null(name)) {
        name <- naming(sets1 = sets)
    } else if (length(name) != 1) {
        stop("The new union can only have one name", call. = FALSE)
    }
    object <- add_sets(object, name)
    relations <- relations(object)
    union <- relations[relations$sets %in% sets, ]
    if (is.factor(union$sets)) {
        levels(union$sets)[levels(union$sets) %in% sets] <- name
    } else {
        union$sets[union$sets %in% sets] <- name
    }

    union <- fapply(union, FUN, ... = ...)
    object <- replace_interactions(object, union, keep_relations)
    object <- droplevels(object, !keep_elements, !keep_sets, !keep_relations)
    validObject(object)
    object
}
