#' @include AllClasses.R AllGenerics.R
NULL

#' @describeIn subtract Elements present in sets but not in other sets
#' @export
setMethod("subtract",
    signature = signature(
        object = "TidySet",
        set_in = "characterORfactor",
        not_in = "characterORfactor"
    ),
    function(object, set_in, not_in, name = NULL, keep = TRUE,
    keep_relations = keep, keep_elements = keep,
    keep_sets = keep) {

        old_relations <- relations(object)
        test_set_in <- set_in %in% old_relations$sets
        if (!any(test_set_in)) {
            stop("No set from set_in could be found ", call. = FALSE)
        }

        if (!all(test_set_in)) {
            warning("sets", set_in[test_set_in], "could not be found",
                call. = FALSE
            )
        }

        sub_set2 <- not_in %in% old_relations$sets
        if (!any(sub_set2)) {
            stop("No set from not_in could be found", call. = FALSE)
        }

        if (!all(sub_set2)) {
            warning("sets", not_in[sub_set2], "could not be found",
                call. = FALSE
            )
        }

        sub_set <- old_relations$sets %in% set_in
        relations <- old_relations[sub_set, , drop = FALSE]
        remove_elements <- elements_in_set(object, not_in)
        relations <- relations[!relations$elements %in% remove_elements, ,
            drop = FALSE
        ]

        if (is.null(name)) {
            name <- naming(
                sets1 = set_in, middle = "minus",
                sets2 = not_in
            )
        }

        if (nrow(relations) >= 1) {
            relations$sets <- name
        }

        object <- add_sets(object, name)
        object <- replace_interactions(object, relations, keep_relations)
        object <- droplevels(
            object, !keep_elements, !keep_sets,
            !keep_relations
        )
        validObject(object)
        object
    }
)
