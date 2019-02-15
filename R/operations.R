#' @include AllClasses.R AllGenerics.R
NULL

add_elements <- function(object, elements){

  original_elements <- name_elements(object)
  final_elements <- unique(c(original_elements, elements))

  if (length(final_elements) != length(original_elements)) {
    levels(object@elements$elements) <- final_elements

    new_elements <- setdiff(elements, original_elements)
    df_elements <- data.frame(elements = new_elements)
    column_names <- setdiff(colnames(object@elements), "elements")
    df_elements[, column_names] <- NA
    object@elements <- rbind(object@elements, df_elements)
  }
  rownames(object@elements) <- NULL
  object
}

add_sets <- function(object, set) {

  original_sets <- name_sets(object)
  final_sets <- unique(c(original_sets, set))

  if (length(final_sets) != length(original_sets)) {
    levels(object@sets$sets) <- final_sets

    new_sets <- setdiff(set, original_sets)
    df_sets <- data.frame(sets = new_sets)
    column_names <- setdiff(colnames(object@sets), "sets")
    df_sets[, column_names] <- NA
    object@sets <- rbind(object@sets, df_sets)
  }
  rownames(object@sets) <- NULL
  object
}

add_relations <- function(object, elements, sets, fuzzy) {
  nElements <- length(elements)

  if (length(sets) != nElements && length(sets) == 1) {
    sets <- rep(sets, nElements)
  } else if (length(sets) != nElements && length(sets) > 1) {
    stop("Recycling sets is not allowed", call. = FALSE)
  }

  original_relations <- elements_sets(object)
  relations <- paste(elements, sets)
  final_relations <- unique(c(original_relations, relations))
  new_relations <- setdiff(relations, original_relations)

  if (length(fuzzy) > length(new_relations)) {
    stop("Redefining the same relations with a different fuzzy number", call. = FALSE)
  } else if (length(fuzzy) <= length(new_relations) && length(fuzzy) == 1) {
    fuzzy <- rep(fuzzy, length(new_relations))
  } else {
    stop("Recyling fuzzy is not allowed", call. = FALSE)
  }

  if (length(final_relations) != length(original_relations)) {

    # Split the remaining elements and sets
    elements_sets <- strsplit(new_relations, split = " ")
    elements <- vapply(elements_sets, "[", i = 1, character(1L))
    sets <- vapply(elements_sets, "[", i = 2, character(1L))

    df_relations <- data.frame(elements = elements, sets = sets, fuzzy = fuzzy)
    column_names <- setdiff(colnames(object@relations), c("sets", "elements", "fuzzy"))
    df_relations[, column_names] <- NA
    object@relations <- rbind(object@relations, df_relations)
  }
  rownames(object@relations) <- NULL
  object
}


remove_elements <- function(object, elements) {
  if (length(elements) == 0 ) {
    return(object)
  }

  keep_at_elements <- !object@elements$elements %in% elements
  new_elements <- object@elements[keep_at_elements, ,drop = FALSE]
  rownames(new_elements) <- NULL
  object@elements <- droplevels(new_elements)
  object
}

remove_sets <- function(object, sets) {

  if (length(sets) == 0) {
    return(object)
  }

  keep_at_set <- !object@sets$sets %in% sets
  new_set <- object@sets[keep_at_set, , drop = FALSE]
  object@sets <- droplevels(new_set)
  object
}

remove_relations <- function(object, elements, sets,
                             relations = paste(elements, sets)) {
  if (length(sets) != length(elements)) {
    stop("sets and elements should be of the same length", call. = FALSE)
  }
  if (length(sets) == 0) {
    return(object)
  }
  old_relations <- elements_sets(object)
  remove_relation <- !old_relations %in% relations
  object@relations <- object@relations[remove_relation, , drop = FALSE]
  rownames(object@relations) <- NULL
  object
}

rm_relations_with_sets <- function(object, sets) {
  if (length(sets) == 0) {
    return(object)
  }
  keep_at_relations <- !object@relations$set %in% sets
  new_relations <- object@relations[keep_at_relations, , drop = FALSE]
  object@relations <- droplevels(new_relations)
  rownames(object@relations) <- NULL
  object
}

rm_relations_with_elements <- function(object, elements) {
  if (length(elements) == 0) {
    return(object)
  }
  keep_at_relations <- !object@relations$elements %in% elements
  new_relations <- object@relations[keep_at_relations, , drop = FALSE]
  object@relations <- droplevels(new_relations)
  rownames(object@relations) <- NULL
  object
}

elements_sets <- function(object){
  paste(object@relations$elements, object@relations$sets)
}

`%e-e%` <- function(object1, object2) {
  setdiff(object1@relations$elements, object2@relations$elements)
}

`%s-s%` <- function(object1, object2) {
  setdiff(object1@relations$sets, object2@relations$sets)
}

`%r-r%` <- function(object1, object2) {
  relations1 <- elements_sets(object1)
  relations2 <- elements_sets(object2)
  setdiff(relations1, relations2)
}


#' Apply to fuzzy
#'
#' Simplify and returns unique results of the object
#' @param object A TidySet object
#' @param FUN A function to perform on the fuzzy numbers
#' @return A modified TidySet object
#' @noRd
fapply <- function(object, FUN) {
  # Handle the duplicate cases
  relations_original <- object@relations
  basic <- elements_sets(object)
  indices <- split(seq_along(basic), basic)
  # Helper function probably useful for intersection too
  iterate <- function(i, fuzzy, fun) {
    fun(fuzzy[i])
  }
  # It could be possible to apply some other function to the relations
  # that are the same
  FUN <- match.fun(FUN)
  fuzzy <- vapply(indices, iterate, fuzzy = relations_original$fuzzy,
                  fun = FUN, numeric(1L))
  relations2 <- unique(relations_original[, c("sets", "elements")])
  relations2 <- cbind.data.frame(relations2, fuzzy = fuzzy)
  object@relations <- relations2
  object
}

merge_tidySets <- function(object1, object2) {
  new_relations <- rbind(object1@relations, object2@relations)
  new_sets <- rbind(object1@sets, object2@sets)
  new_elements <- rbind(object1@elements, object2@elements)

  object2@relations <- unique(new_relations)
  object2@sets <- unique(new_sets)
  object2@elements <- unique(new_elements)

  rownames(object2@relations) <- NULL
  rownames(object2@sets) <- NULL
  rownames(object2@elements) <- NULL

  object2
}
