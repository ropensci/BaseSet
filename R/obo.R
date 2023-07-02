#' Read an OBO file
#'
#' Read an Open Biological and Biomedical Ontologies (OBO) formatted file
#' @param x Path to a file in OBO format.
#' @return A TidySet object.
#' @family IO functions
#' @references The format is described [here](
#' https://owlcollab.github.io/oboformat/doc/GO.format.obo-1_4.html)
#' @export
#' @examples
#' oboFile <- system.file(
#'     package = "BaseSet", "extdata",
#'     "go-basic_subset.obo"
#' )
#' gs <- getOBO(oboFile)
#' head(gs)
getOBO <- function(x) {
    data <- readLines(x)
    # Remove empty lines
    n <- vapply(data, nchar, numeric(1L))
    data <- data[n != 0]
    # Look for terms
    kv0 <- strsplit(data, ": ", fixed = TRUE)
    kv <- kv0[lengths(kv0) == 2]
    k <- vapply(kv, "[", character(1L), i = 1) # Keys
    v <- vapply(kv, "[", character(1L), i = 2) # Values
    d <- which(k == "id") # Which position indicate a beginning of description

    keys <- k[d[1]:length(k)]
    df <- data.frame(matrix(ncol = length(unique(keys)), nrow = 0),
        stringsAsFactors = FALSE
    )
    colnames(df) <- unique(keys)

    # For each term parse it in a tidy data frame
    for (i in seq_along(d)) {
        if (i == length(d)) {
            l <- seq(from = d[i], to = length(kv), by = 1)
        } else {
            l <- seq(from = d[i], to = d[i + 1] - 1, by = 1)
        }
        ch <- v[l]
        names(ch) <- k[l]

        keys <- unique(k[l])
        m <- max(table(k[l]))

        lr <- lapply(keys, function(a, y) {
            rep_len(y[names(y) == a], m)
        }, y = ch)
        names(lr) <- keys

        not_pres <- setdiff(colnames(df), keys)
        sub_df <- as.data.frame(lr, stringsAsFactors = FALSE)
        sub_df[, not_pres] <- NA
        df <- rbind(df, sub_df)
    }
    # Clean the data a bit
    if ("is_obsolete" %in% colnames(df)) {
        df <- df[is.na(df[, "is_obsolete"]), , drop = FALSE]
    }
    strs <- strsplit(df$is_a, " ! ")
    df$sets <- vapply(strs, "[", character(1L), i = 1)
    df$set_name <- vapply(strs, "[", character(1L), i = 2)
    strs <- strsplit(df$xref, ":")
    df$ref_origin <- vapply(strs, "[", character(1L), i = 1)
    df$ref_code <- vapply(strs, "[", character(1L), i = 2)
    df$fuzzy <- 1
    colnames(df)[colnames(df) == "id"] <- "elements"
    df <- df[!is.na(df$sets), , drop = FALSE]
    keep_columns <- setdiff(colnames(df), c("xref", "is_obsolete", "is_a"))
    df <- df[, keep_columns]
    tidySet.data.frame(df)
}

# Using data downloaded from
# https://geneontology.org/gene-associations/goa_human_rna.gaf.gz on 20190711
# About the format:
# https://geneontology.org/docs/go-annotation-file-gaf-format-2.1/
#' Read a GAF file
#'
#' Read a GO Annotation File (GAF) formatted file
#'
#' @references The format is defined [here](
#' https://geneontology.org/docs/go-annotation-file-gaf-format-2.1/).
#' @param x A file in GAF format
#' @return A TidySet object
#' @export
#' @family IO functions
#' @importFrom utils read.delim
#' @examples
#' gafFile <- system.file(
#'     package = "BaseSet", "extdata",
#'     "go_human_rna_valid_subset.gaf"
#' )
#' gs <- getGAF(gafFile)
#' head(gs)
getGAF <- function(x) {
    df <- read.delim(x,
        header = FALSE, comment.char = "!",
        stringsAsFactors = FALSE
    )
    gaf_columns <- c(
        "DB", "DB_Object_ID", "DB_Object_Symbol", "Qualifier",
        "O_ID", "DB_Reference", "Evidence_Code", "With_From",
        "Aspect", "DB_Object_Name", "DB_Object_Synonym",
        "DB_Object_Type", "Taxon", "Date", "Assigned_By",
        "Annotation_Extension", "Gene_Product_Form_ID"
    )
    colnames(df) <- gaf_columns

    # Check which optional columns are missing
    optional_columns <- c(4, 8, 10, 11, 16, 17)
    remove <- apply(df[, optional_columns], 2, function(x) {
        all(is.na(x))
    })
    df <- df[, -optional_columns[remove]]

    # Modify if they are GeneOntolgoy
    GO <- grepl("^GO:", df$O_ID)
    df$Aspect[GO] <- gsub("P", "BP", df$Aspect[GO])
    df$Aspect[GO] <- gsub("C", "CC", df$Aspect[GO])
    df$Aspect[GO] <- gsub("F", "MF", df$Aspect[GO])

    # Classification of the columns according to where do they belong
    elements <- c(1, 2, 3, 10, 11, 12, 13, 17)
    sets <- c(5, 6, 9, 16)

    # Change the name of the columns to be ready to use tidySet.data.frame
    colnames(df) <- gsub("O_ID", "sets", colnames(df))
    colnames(df) <- gsub("DB_Object_Symbol", "elements", colnames(df))

    TS <- tidySet(df)

    # Check that the columns really have information that allows them to be
    # moved to the new slot.
    columns_gaf <- function(names, originals) { # If there is a missing column
        names[names %in% originals]
    }
    sets_columns <- columns_gaf(gaf_columns[sets], colnames(df))
    nColm <- vapply(sets_columns, function(x) {
        nrow(unique(df[, c("sets", x)]))
    }, numeric(1))
    sets_columns <- sets_columns[nColm <= length(unique(df$sets))]
    elements_columns <- columns_gaf(gaf_columns[elements], colnames(df))
    nColm <- vapply(sets_columns, function(x) {
        nrow(unique(df[, c("elements", x)]))
    }, numeric(1))
    elements_columns <- elements_columns[nColm <= length(unique(df$elements))]

    TS <- move_to(TS, "relations", "sets", sets_columns)
    TS <- move_to(TS, "relations", "elements", elements_columns)
    TS
}
