#' @include AllClasses.R AllGenerics.R operations.R
NULL

.intersection <- function(object, sets, name, FUN, keep_relations,
    keep_elements, keep_sets, ...) {
    if (length(name) > 1) {
        stop("The name of the new set must be of length 1", call. = FALSE)
    }

    if (is.null(name)) {
        name <- collapse_sets(sets, "intersection")
    }
    inclusion <- check_sets(object, sets)
    if (!all(inclusion)) {
        stop("Sets must be present on the relations", call. = FALSE)
    }

    if (any(!inclusion)) {
        warning("Sets", sets[inclusion], "could not be found", call. = FALSE)
    }

    old_relations <- relations(object)

    relevant_relations <- old_relations$sets %in% sets
    intersection <- old_relations[relevant_relations, , drop = FALSE]
    intersection <- droplevels(intersection)
    intersection$sets <- as.character(intersection$sets)
    intersection$sets <- name

    relations <- paste(intersection$elements, intersection$sets)
    t_relations <- table(relations)
    k_relations <- t_relations >= sum(length(sets))
    dup_relations <- names(t_relations)[k_relations]
    duplicate_rel <- relations %in% dup_relations
    if (any(duplicate_rel)) {
        intersection <- intersection[duplicate_rel, , drop = FALSE]
        intersection <- fapply(intersection, FUN, ... = ...)
    }

    object <- replace_interactions(object, intersection, keep_relations)
    object <- add_sets(object, name)

    object <- droplevels(object, !keep_elements, !keep_sets, !keep_relations)
    validObject(object)
    object
}

#' @describeIn intersection Applies the standard intersection
#' @export
setMethod("intersection",
    signature = signature(
        object = "TidySet",
        sets = "character"
    ),
    function(object, sets, name = NULL, FUN = "min", keep = FALSE,
    keep_relations = keep,
    keep_elements = keep,
    keep_sets = keep,
    ...) {
        .intersection(
            object, sets, name, match.fun(FUN), keep_relations,
            keep_elements, keep_sets, ...
        )
    }
)
