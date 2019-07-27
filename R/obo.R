#' Read an OBO file
#'
#' Read a OBO formatted file
#'
#' @param x A file in OBO format
#' @return A TidySet object
#' @family IO functions
#' @export
#' @examples
#' oboFile <- system.file(package = "BaseSet", "extdata",
#'                                   "go-basic_subset.obo")
#' gs <- getOBO(oboFile)
#' head(gs)
getOBO <- function(x) {
    parser <- list(blank_line = "^\\s*$",
                   comment_line = "^\\s*!",
                   comment = "\\s*!.*$",
                   stanza = "^\\[(.+)\\]",
                   subsetdef = "^(\\w+)\\s*\"(.*)\"",
                   kv = "^([^:]*):\\s*(.*)")
    data <- readLines(x)
    comments <- grep(parser$comment_line, data)
    if (length(comments) > 0)
        data <- data[-comments]
    data <- sub(parser$comment, "", data)
    stnz <- grep(parser$stanza, data)
    stnz <- stnz[stnz %in% (grep(parser$blank_line, data) + 1)]

    stanza <- data.frame(id = c(0, stnz),
                         value = c("Root", sub(parser$stanza, "\\1", data[stnz])),
                         stringsAsFactors = FALSE)
    kv_id <- grep(parser$kv, data)
    stanza_id <- sapply(kv_id, function(x) {
        idx <- x > stanza$id
        stanza$id[xor(idx, c(idx[-1], FALSE))]
    })
    kv_pairs <- data[kv_id]
    kv_key = sub(parser$kv, "\\1", kv_pairs)
    kv_value = sub(parser$kv, "\\2", kv_pairs)
    id_keys <- kv_key == "id"
    stanza_idx <- match(stanza_id[id_keys], stanza$id)
    row.names(stanza)[c(1, stanza_idx)] <- c(".__Root__", kv_value[id_keys])
    stanza_id <- row.names(stanza)[match(stanza_id, stanza$id)]
    stanza$id <- NULL
    kv <- data.frame(id = kv_id[!id_keys], stanza_id = stanza_id[!id_keys],
                     key = kv_key[!id_keys], value = kv_value[!id_keys],
                     stringsAsFactors = FALSE, row.names = "id")
    idx <- kv$stanza_id == ".__Root__" & kv$key == "subsetdef"
    # Variables that define the file thus all sets
    # data-version, format-version, remark, subsetdef, ontology, deault-namespace, synonymtypedef
    # remove obselete terms
    obsolete_ontologies <- kv$stanza_id[kv$key == "is_obsolete" & kv$value == "true"]
    kv <- kv[!kv$stanza_id %in% obsolete_ontologies, ]
    # unique per GO
    # comment, data-version, def, default-namespace, format-version, name, namespace, ontology,
    relations <- kv[kv$key == "relationship" | kv$key == "is_a", ]
    val <- lapply(strsplit(relations$value, split = " "), function(x) {
        if (length(x) == 1) {
            c("is_a", x)
        } else {
            x
        }
    })
    rels <- t(simplify2array(val, higher = FALSE))
    relations <- cbind.data.frame(relations, rels, stringsAsFactors = FALSE)
    relations <- relations[, -c(2, 3), drop = FALSE]
    colnames(relations) <- c("elements", "type", "sets")
    relations <- relations[!(relations$sets %in% obsolete_ontologies), ]
    relations <- relations[!(relations$elements %in% obsolete_ontologies), ]
    relations$fuzzy <- 1

    elements <- data.frame(
        elements = unique(kv$stanza_id[kv$stanza_id != ".__Root__"]),
        stringsAsFactors = FALSE)
    sets <- data.frame(sets = unique(c(elements$elements, relations$sets)),
                       stringsAsFactors = FALSE)
    root <- kv[kv$stanza_id == ".__Root__", 2:3]
    files_info <- t(root[root$key %in% c("data-version", "date", "saved-by",
                                         "ontology", "default-namespace"), ])
    colnames(files_info) <- files_info[1, ]
    files_info <- files_info[-1, , drop = FALSE]
    sets <- cbind(sets, files_info[rep(1, nrow(sets)), ])
    new("TidySet", elements = elements, relations = relations, sets = sets)
}

# Using data downloaded from http://geneontology.org/gene-associations/goa_human_rna.gaf.gz on 20190711
# About the format: http://geneontology.org/docs/go-annotation-file-gaf-format-2.1/
#' Read a GAF file
#'
#' Read a GAF formatted file, see \url{http://geneontology.org/docs/go-annotation-file-gaf-format-2.1/}
#'
#' @param x A file in GAF format
#' @return A TidySet object
#' @export
#' @family IO functions
#' @importFrom utils read.delim
#' @examples
#' gafFile <- system.file(package = "BaseSet", "extdata",
#'                                   "go_human_rna_valid_subset.gaf")
#' gs <- getGAF(gafFile)
#' head(gs)
getGAF <- function(x) {
    df <- read.delim(x, header = FALSE, comment.char = "!",
                     stringsAsFactors = FALSE)
    gaf_columns <- c("DB", "DB_Object_ID", "DB_Object_Symbol", "Qualifier",
                     "O_ID", "DB_Reference", "Evidence_Code", "With_From",
                     "Aspect", "DB_Object_Name", "DB_Object_Synonym",
                     "DB_Object_Type", "Taxon", "Date", "Assigned_By",
                     "Annotation_Extension", "Gene_Product_Form_ID")
    colnames(df) <- gaf_columns

        # Check which optional columns are missing
    optional_columns <- c(4, 8, 10, 11, 16, 17)
    remove <- apply(df[, optional_columns], 2, function(x){all(is.na(x))})
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

    # Check that the columns really have information that allows them to be moved
    # to the new slot.
    columns_gaf <- function(names, originals) { # Check just in case there is a missing column
        names[names %in% originals]
    }
    sets_columns <- columns_gaf(gaf_columns[sets], colnames(df))
    nColm <- vapply(sets_columns, function(x){
        nrow(unique(df[, c("sets", x)]))
    }, numeric(1))
    sets_columns <- sets_columns[nColm <= length(unique(df$sets))]
    elements_columns <- columns_gaf(gaf_columns[elements], colnames(df))
    nColm <- vapply(sets_columns, function(x){
        nrow(unique(df[, c("elements", x)]))
    }, numeric(1))
    elements_columns <- elements_columns[nColm <= length(unique(df$elements))]

    TS <- move_to(TS, "relations", "sets", sets_columns)
    TS <- move_to(TS, "relations", "elements",  elements_columns)
    TS
}
