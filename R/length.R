#' @include AllClasses.R AllGenerics.R
NULL

#' Calculates the probabilities
#'
#' Calculates the probability that all happened simultaneously
#' @param p Probabilities
#' @param i Index of the complementary probability
#' @return  The log10 of the probability
#' @keywords internal
#' @examples
#' multiply_probabilities(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23), c(1, 3))
multiply_probabilities <- function(p, i) {

    if (length(i) == length(p)) {
        return(prod(p))
    } else if (length(i) == 0) {
        i <- seq_along(p)
    }
    prod(p[i], (1 - p)[-i])
}

#' Calculates the probability of a single length
#'
#' Creates all the possibilities and then add them up.
#' @param p Probabilities
#' @param n Size
#' @return A numeric value of the probability of the given size
#' @export
#' @keywords internal
#' @examples
#' length_probability(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23), 2)
length_probability <- function(p, n) {
    pos <- combn(seq_along(p), n)
    sum(apply(pos, 2, multiply_probabilities, p = p))
}


#' Calculates the probability
#'
#' Given several probabilities it looks for how probable is to have a vector of
#' each length
#' @param fuzziness The probabilities
#' @return A vector with the probability of each set
#' @export
#' @examples
#' length_set(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23))
length_set <- function(fuzziness) {
    p1 <- fuzziness == 1

    if (all(p1)) {
        out <- c(1)
        names(out) <- as.character(sum(fuzziness))
        return(out) # Non fuzzy sets
    }
    if (all(fuzziness == 0)) {
        max_length <- 0
    } else {
        max_length <- length(fuzziness)
    }
    l <- seq(from = sum(p1), to = max_length)
    # Exclude those cases that are obvious
    l2 <- l - sum(p1)
    l2 <- l2[l2 != 0]
    v <- vapply(l2, length_probability, p = fuzziness[!p1], numeric(1L))

    # Substitute in the original possibilities
    names(l) <- as.character(l)
    l[] <- 0
    l[as.character(l2 + sum(p1))] <- v
    l[as.character(sum(p1))] <- 1 - sum(v)
    l
}

# TODO Use matrix operations to simplify tha process for large objects
#' @describeIn set_size Calculates the size of a set either fuzzy or not
#' @export
#' @examples
#' relations <- data.frame(sets = c(rep("A", 5), "B", "C"),
#'                         elements = c(letters[seq_len(6)], letters[6]),
#'                         fuzzy = runif(7))
#' a <- tidySet(relations)
#' set_size(a)
setMethod("set_size",
          signature = signature(object = "TidySet"),
          function(object, set = NULL) {

              if (!set %in% name_sets(object) && !is.null(set)) {
                  stop("Please introduce valid set names. See name_sets",
                       call. = FALSE)
              }

              if (is.null(set)) {
                  names_sets <- name_sets(object)
              } else {
                  names_sets <- set
              }

              rel <- relations(object)
              rel <- rel[rel$sets %in% names_sets, ]
              missing <- names_sets[!names_sets %in% rel$sets]
              rel <- rel[, c("fuzzy", "elements", "sets")]

              if (length(missing) != 0) {
                  missing <- data.frame(sets = missing, elements = NA, fuzzy = 0)
                  rel <- rbind(rel, missing)
              }

              # Duplicate relationships with different information...
              # To filter to unique relationships
              if (anyDuplicated(rel) != 0) {
                  rel <- unique(rel)
                  rel <- droplevels(rel)
              }

              if (!all(rel$fuzzy == 1)) {

                  fuzzy_values <- split(rel$fuzzy, rel$sets)
                  sizes <- lapply(fuzzy_values, length_set)
                  sets <- rep(names(fuzzy_values), lengths(sizes))
                  lengths_set <- unlist(lapply(sizes, names), use.names = FALSE)
                  probability_length <- unlist(sizes, use.names = FALSE)
              } else {
                  sets <- names_sets
                  lengths_set <- table(rel$sets)[names_sets]
                  probability_length <- 1
              }
              # Empty set
              if (any(is.na(lengths_set))) {
                  lengths_set[is.na(lengths_set)] <- 0
              }
              # Nothing is present
              if (is.null(lengths_set) & is.null(probability_length)) {
                  sets <- names_sets
                  lengths_set <- rep(0, length(sets))
                  probability_length <- rep(1, length(sets))
              }
              out <- data.frame(sets = sets,
                                size = as.numeric(lengths_set),
                                probability = probability_length,
                                stringsAsFactors = FALSE)
              out <- merge(out, sets(object), sort = FALSE)
              if (is.null(set)) {
                  out
              } else {
                  out[sets %in% set, ]
              }
          }
)

#' @describeIn element_size Calculates the number of sets one element appears
#' @export
#' @examples
#' relations <- data.frame(sets = c(rep("A", 5), "B", "C"),
#'                         elements = c(letters[seq_len(6)], letters[6]),
#'                         fuzzy = runif(7))
#' a <- tidySet(relations)
#' element_size(a)
setMethod("element_size",
          signature = signature(object = "TidySet"),
          function(object, element = NULL) {
              if (!element %in% name_elements(object) && !is.null(element)) {
                  stop("Please introduce valid element names. See element_names",
                       call. = FALSE)
              }

              # object <- droplevels(object)
              rel <- relations(object)
              if (is.null(element)) {
                  names_elements <- name_elements(object)
              } else {
                  names_elements <- element
              }

              rel <- rel[rel$elements %in% names_elements, ]
              rel <- rel[, c("fuzzy", "elements", "sets")]
              missing <- names_elements[!names_elements %in% rel$elements]

              if (length(missing) != 0) {
                  missing <- data.frame(sets = NA, elements = missing, fuzzy = 0)
                  rel <- rbind(rel, missing)
              }

              # To filter to unique relationships
              if (anyDuplicated(rel) != 0) {
                  rel <- unique(rel)
                  rel <- droplevels(rel)
              }
# browser()
              if (!all(rel$fuzzy == 1)) {
                  fuzzy_values <- split(rel$fuzzy, rel$elements)
                  sizes <- lapply(fuzzy_values, length_set)
                  elements <- rep(names(fuzzy_values), lengths(sizes))
                  lengths_set <- unlist(lapply(sizes, names), use.names = FALSE)
                  probability_length <- unlist(sizes, use.names = FALSE)
              } else {
                  elements <- names_elements
                  lengths_set <- table(rel$elements)[names_elements]
                  probability_length <- 1
              }
              # Empty group
              if (any(is.na(lengths_set))) {
                  lengths_set[is.na(lengths_set)] <- 0
              }
              # Nothing is present
              if (is.null(lengths_set) & is.null(probability_length)) {
                  elements <- names_elements
                  lengths_set <- rep(0, length(elements))
                  probability_length <- rep(1, length(elements))
              }

              out <- data.frame(elements = elements,
                                size = as.numeric(lengths_set),
                                probability = probability_length,
                                stringsAsFactors = FALSE)
              out <- merge(out, elements(object), sort = FALSE)

              if (is.null(element)) {
                  out
              } else {
                  out[elements %in% element, ]
              }
          }
)

