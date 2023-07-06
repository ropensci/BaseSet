#' @include AllClasses.R
NULL

#' Create a TidySet object
#'
#' These functions help to create a \code{TidySet} object from
#' `data.frame`, `list`, `matrix`, and `GO3AnnDbBimap`.
#' They can create both fuzzy and standard sets.
#'
#' Elements or sets without any relation are not shown when printed.
#' @param relations An object to be coerced to a TidySet.
#' @return A TidySet object.
#' @examples
#' relations <- data.frame(
#'     sets = c(rep("a", 5), "b"),
#'     elements = letters[seq_len(6)]
#' )
#' tidySet(relations)
#' relations2 <- data.frame(
#'     sets = c(rep("A", 5), "B"),
#'     elements = letters[seq_len(6)],
#'     fuzzy = runif(6)
#' )
#' tidySet(relations2)
#' @export
#' @seealso [`TidySet`]
tidySet <- function(relations) {
    UseMethod("tidySet")
}

#' @describeIn tidySet Given the relations in a data.frame
#' @method tidySet data.frame
#' @export
tidySet.data.frame <- function(relations) {
    check_colnames <- all(c("sets", "elements") %in% colnames(relations))
    if (ncol(relations) < 2 || !check_colnames) {
        stop("Unable to create a TidySet object.\n",
            "The data.frame does not have the sets and elements columns.",
            call. = FALSE
        )
    }
    if (!is.ch_fct(relations$sets)) {
        stop("Sets should be a factor or a character.", call. = FALSE)
    }
    if (!is.ch_fct(relations$elements)) {
        stop("Elements should be a factor or a character.", call. = FALSE)
    }
    sets <- data.frame(
        sets = unique(relations$sets),
        stringsAsFactors = FALSE
    )
    elements <- data.frame(
        elements = unique(relations$elements),
        stringsAsFactors = FALSE
    )
    if (!"fuzzy" %in% colnames(relations)) {
        fuzzy <- rep(1, nrow(relations))
        relations <- cbind.data.frame(relations, fuzzy,
                                      stringsAsFactors = FALSE)
    } else if (!is.numeric(relations$fuzzy)) {
        stop("Fuzzy column should be a numeric column with numbers ",
             "between 0 and 1.", call. = FALSE)
    }
    # Just in case
    rownames(relations) <- seq_len(nrow(relations))
    new("TidySet", sets = sets, elements = elements, relations = relations)
}

#' @export
#' @describeIn tidySet Convert to a TidySet from a list.
#' @examples
#' # A
#' x <- list("A" = letters[1:5], "B" = LETTERS[3:7])
#' tidySet(x)
#' # A fuzzy set taken encoded as a list
#' A <- runif(5)
#' names(A) <- letters[1:5]
#' B <- runif(5)
#' names(B) <- letters[3:7]
#' relations <- list(A, B)
#' tidySet(relations)
#' # Will error
#' # x <- list("A" = letters[1:5], "B" = LETTERS[3:7], "c" = runif(5))
#' # a <- tidySet(x) # Only characters or factors are allowed as elements.
tidySet.list <- function(relations) {

    char <- vapply(relations, is.character, logical(1L))
    num <- vapply(relations, is.numeric, logical(1L))
    fact <- vapply(relations, is.factor, logical(1L))

    if (!all(char | fact) && !all(num)) {
        stop("The list should have either characters or named numeric vectors",
            call. = FALSE
        )
    }
    if (is.null(names(relations))) {
        set_names <- paste0("Set", seq_along(relations))
        names(relations) <- set_names[length(relations)]
    }
    if (all(char | fact)) {
        relations <- lapply(relations, unique)
        elements <- unlist(relations, FALSE, FALSE)
        fuzzy <- rep(1, length(elements))
    } else if (all(num)) {
        elements <- unlist(lapply(relations, names), FALSE, FALSE)

        if (is.null(elements)) {
            stop("The numeric vectors should be named", call. = FALSE)
        }
        fuzzy <- unlist(relations, FALSE, FALSE)
    }

    sets_size <- lengths(relations)

    sets_size[sets_size == 0] <- 1
    sets <- rep(names(relations), sets_size)
    if (length(elements) == 0) {
        return(new("TidySet", sets = data.frame(sets = sets),
                   elements = data.frame(elements = character()),
                   relations = data.frame(elements = character(),
                                          sets = character(),
                                          fuzzy = numeric())))
    }

    size <- c(length(elements), length(sets), length(fuzzy))
    min_size <- min(size)

    relations <- data.frame(elements = elements[seq_len(min_size)],
                            sets = sets[seq_len(min_size)],
                            fuzzy = fuzzy,
        stringsAsFactors = FALSE
    )
    TS <- tidySet.data.frame(relations = relations)
    if (size[1] > min_size) {
        e <- elements[seq(from = min_size + 1, to = size[1])]
        add_elements(TS, e)
    }
    if (size[2] > min_size) {
        s <- sets[seq(from = min_size + 1, to = size[2])]
        TS <- add_sets(TS, s)
    }
    TS
}

#' @describeIn tidySet Convert an incidence matrix into a TidySet
#' @export
#' @examples
#' M <- matrix(c(1, 0.5, 1, 0), ncol = 2,
#'             dimnames = list(c("A", "B"), c("a", "b")))
#' tidySet(M)
tidySet.matrix <- function(relations) {
    if (anyDuplicated(colnames(relations))) {
        stop("There are duplicated colnames.", call. = FALSE)
    }
    if (anyDuplicated(rownames(relations))) {
        stop("There are duplicated rownames.", call. = FALSE)
    }
    if (!is.numeric(relations)) {
        stop("The incidence should be a numeric matrix.", call. = FALSE)
    }
    # Preparation
    incid <- relations
    elements <- rownames(incid)
    sets <- colnames(incid)
    relations <- as.data.frame(which(incid != 0, arr.ind = TRUE))
    colnames(relations) <- c("elements", "sets")

    # Replace by names
    relations[, 1] <- elements[relations[, 1]]
    relations[, 2] <- sets[relations[, 2]]

    fuzzy <- apply(relations, 1, function(x) {
        incid[x[1], x[2]]
    })
    relations <- cbind.data.frame(relations, fuzzy, stringsAsFactors = FALSE)
    tidySet(relations = relations)
}

#' @describeIn tidySet Convert Go3AnnDbBimap into a TidySet object.
#' @export
tidySet.Go3AnnDbBimap <- function(relations) {
    # Prepare the data
    df <- as.data.frame(relations)
    colnames(df) <- c("elements", "sets", "Evidence", "Ontology")

    # # Transform each evidence code into its own column
    # e_s <- paste(df$elements, df$sets)
    # tt <- as(table(e_s, df$Evidence), "matrix")
    # tt2 <- as.data.frame(tt)
    # tt2$elements <- gsub(" GO:.*", "", rownames(tt2))
    # tt2$sets <- gsub(".* ", "", rownames(tt2))
    # rownames(tt2) <- NULL
    #
    # df2 <- cbind(tt2, nEvidence = rowSums(tt))
    # df3 <- merge(df2, unique(df[, c("sets", "Ontology")]))
    TS <- tidySet.data.frame(df)
    move_to(TS, "relations", "sets", "Ontology")
}

#' @describeIn tidySet Convert TidySet into a TidySet object.
#' @export
tidySet.TidySet <- function(relations) {
    relations
}
