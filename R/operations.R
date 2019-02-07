#' @include AllClasses.R AllGenerics.R
NULL

operation_helper <- function(object, set1, set2, setName, FUN, keep = FALSE) {

  if (!is.logical(keep) || length(keep) > 1) {
    stop("keep should be a logical value")
  }

  if (length(set1) != length(set2)) {
    stop("Recycling set1 and set2 should be of the same length")
  }

  if (length(set1) != length(setName)) {
    stop("setName must be of the same length as set1")
  }
  sets <- name_sets(object)
  sets2 <- levels(object@relations$sets)
  if (!keep) {
    levels(object@sets$set)[sets %in% set1] <- setName
    levels(object@sets$set)[sets %in% set2] <- setName
    object@sets <- unique(object@sets)

    levels(object@relations$sets)[sets2 %in% set1] <- setName
    levels(object@relations$sets)[sets2 %in% set2] <- setName
  } else {

    # Append the new set
    object <- add_sets(object, setName)

    # Append the new relationships
    s <- unique(c(set1, set2))
    df <- object@relations[object@relations$sets %in% s, ]
    column_names <- setdiff(colnames(df), c("sets", "elements", "fuzzy"))
    df[, column_names] <- NA
    for (set in seq_along(set1)) {
      levels(df$sets)[levels(df$sets) %in% c(set1[set], set2[set])] <- setName[set]
    }
    object@relations <- rbind(object@relations, df)
  }

  # Handle the duplicate cases
  basic <- elements_sets(object)
  indices <- split(seq_along(basic), basic)
  # Helper function probably useful for intersection too
  iterate <- function(i, fuzzy, fun) {
    fun(fuzzy[i])
  }
  # It could be possible to apply some other function to the relations
  # that are the same
  FUN <- match.fun(FUN)
  fuzzy <- vapply(indices, iterate, fuzzy = object@relations$fuzzy,
                  fun = FUN, numeric(1L))
  relations2 <- unique(object@relations[, c("sets", "elements")])
  relations2 <- cbind.data.frame(relations2, fuzzy = fuzzy)
  object@relations <- relations2
  validObject(object)
  object
}


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
  object
}

add_sets <- function(object, set) {

  original_sets <- name_sets(object)
  final_sets <- unique(c(original_sets, set))

  if (length(final_sets) != length(original_sets)) {
    levels(object@sets$set) <- final_sets

    new_sets <- setdiff(set, original_sets)
    df_sets <- data.frame(set = new_sets)
    column_names <- setdiff(colnames(object@sets), "set")
    df_sets[, column_names] <- NA
    object@sets <- rbind(object@sets, df_sets)
  }
  object
}

add_relations <- function(object, elements, sets, fuzzy) {
  nElements <- length(elements)

  if (length(sets) != nElements && length(sets) == 1) {
    sets <- rep(sets, nElements)
  } else if (length(sets) != nElements && length(sets) > 1) {
    stop("Recycling sets is not allowed")
  }

  original_relations <- elements_sets(object)
  relations <- paste(elements, sets)
  final_relations <- unique(c(original_relations, relations))
  new_relations <- setdiff(relations, original_relations)

  if (length(fuzzy) > length(new_relations)) {
    stop("Redefining the same relations with a different fuzzy number")
  } else if (length(fuzzy) < length(new_relations) && length(fuzzy) == 1) {
    fuzzy <- rep(fuzzy, length(new_relations))
  } else {
    stop("Recyling fuzzy is not allowed")
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
  object
}


remove_elements <- function(object, elements) {
  if (length(elements) == 0 ) {
    return(object)
  }
  old_elements <- name_elements(object)
  remove <- old_elements[old_elements %in% elements]

  new_elements <- object@elements[!object@elements$elements %in% remove, ,
                                  drop = FALSE]
  object@elements <- droplevels(new_elements)
  object
}

remove_sets <- function(object, sets) {
  if (length(sets) == 0) {
    return(object)
  }
  old_sets <- name_sets(object)
  remove <- old_sets[old_sets %in% sets]
  object@sets <- object@sets[!object@sets$set %in% remove, , drop = FALSE]
  object@sets <- droplevels(object@sets)
  object
}

remove_relations <- function(object, elements, sets) {
  if (length(sets) != length(elements)) {
    stop("sets and elements should be of the same length")
  }
  if (length(sets) == 0) {
    return(object)
  }
  relations <- paste(elements, sets)
  old_relations <- elements_sets(object)
  remove <- !old_relations %in% relations
  object@relations <- object@relations[remove, , drop = FALSE]
  object
}

elements_sets <- function(object){
  paste(object@relations$elements, object@relations$sets)
}
