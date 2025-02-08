test_that("tidySet data.frame", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = relations)
    expect_s4_class(a, "TidySet")
    expect_true(is_valid(a))
    expect_equal(
        check_colnames_slot(a, "relations", "abc"),
        "abc column is not present on slot relations."
    )

    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = letters[seq_len(6)]
    )
    expect_error(
        tidySet(relations),
        "between 0 and 1."
    )

    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = rep(2, 6)
    )

    expect_error(
        tidySet(relations),
        "is restricted to a number between 0 and 1."
    )

    expect_error(tidySet(relations[0, ]), NA)

    colnames(relations) <- c("a", "b")
    expect_error(tidySet(relations), "sets and elements columns.")
})

test_that("tidySet matrix", {
    m <- matrix(runif(6), ncol = 2, nrow = 3)
    colnames(m) <- LETTERS[1:2]
    rownames(m) <- letters[1:3]
    expect_s4_class(tidySet(m), "TidySet")
    m2 <- m
    colnames(m2) <- c("A", "A")
    expect_error(tidySet(m2), "duplicate")
    rownames(m) <- c("a", "a", "b")
    expect_error(tidySet(m), "duplicate")
})

test_that("tidySet list", {
    relations <- list(
        "A" = letters[1:5],
        "B" = letters[1:7]
    )
    expect_s4_class(tidySet(relations), "TidySet")

    relations <- list(
        "A" = letters[1:5],
        "B" = c(letters[1:7], "a")
    )
    expect_s4_class(tidySet(relations), "TidySet")

    # Mix of character and factors (just in case)
    relations <- list(
        "A" = as.factor(letters[1:5]),
        "B" = c(letters[1:7], "a")
    )
    expect_s4_class(tidySet(relations), "TidySet")
})

test_that("tidySet.list keeps empty set", {
    x <- list(a = c("A", "B"), b = character(0))
    TS <- tidySet(x)
    expect_equal(nSets(TS), 2L)

    x <- list(a = c("A", "B"), b = character(0), c = character(0),
              d = character(0))
    TS <- tidySet(x)
    expect_equal(nSets(TS), 4L)
})

test_that("TidySet  allows filtering to 0 elements or sets", {
    rel <- data.frame(elements = "a", sets = "B")
    TS <- tidySet(rel)
    expect_error(filter_element(TS, elements != "a"), NA)
})

test_that("Empty list to tidySet", {
    expect_error(tidySet(list()), NA)

    expect_error(TS <- tidySet(list("a" = character(0))), NA)
    expect_equal(name_sets(TS), "a")
    expect_equal(nSets(TS), 1)
    expect_equal(nElements(TS), 0)

    TS <- tidySet(list("a"))
    expect_s4_class(TS, "TidySet")
    expect_equal(nElements(TS), 1)
    expect_equal(nSets(TS), 1)
    expect_equal(name_elements(TS), "a")
})
test_that("tidySet fails", {
    a <- new("TidySet")
    expect_s4_class(a, "TidySet")
    expect_true(any(grepl("colnames for elements", is.valid(a))))
    expect_true(any(grepl("colnames for sets", is.valid(a))))
    expect_true(any(grepl("colnames for relations", is.valid(a))))
    expect_true(any(grepl("Sets must be characters or factors", is.valid(a))))
    expect_true(any(grepl("Elements must be characters or factors",
                          is.valid(a))))
    expect_true(any(grepl("A fuzzy column must be present", is.valid(a))))
    expect_false(is_valid(a))

    expect_error(any(grepl(
        "Set on the sets slot must be unique",
        new("TidySet", sets = data.frame(
            sets = c("A", "A")
        ))
    )))
    expect_error(any(grepl(
        "Elements on the elements slot must be unique",
        new("TidySet",
            elements = data.frame(elements = c("A", "A"))
        )
    )))

    expect_error(any(
        grepl(
            "fuzzy column is restricted to a number between 0 and 1",
            new("TidySet",
                elements = data.frame(elements = "a"),
                relations = data.frame(
                    elements = "a",
                    sets = "A",
                    fuzzy = "a"
                ),
                sets = data.frame(sets = "A")
            )
        )
    ))
    expect_error(
        new("TidySet",
            elements = data.frame(elements = "a"),
            relations = data.frame(elements = "a", sets = "A", fuzzy = 3),
            sets = data.frame(sets = "A")
        ),
        "fuzzy column is restricted to a number between 0 and 1"
    )
    expect_error(
        new("TidySet",
            elements = data.frame(elements = "a", colnames = "b"),
            relations = data.frame(
                elements = "a", sets = "A",
                fuzzy = 3
            ),
            sets = data.frame(sets = "A", colnames = "b")
        ),
        "share a column name."
    )

    expect_error(
        new("TidySet",
            elements = data.frame(elements = "a"),
            relations = data.frame(
                elements = c("a", "a"), sets = c("A", "A"),
                fuzzy = c(0.1, 0.2)
            ),
            sets = data.frame(sets = "A")
        ),
        "must have a single fuzzy value"
    )

    df <- data.frame(elements = c("a", letters[1:4]), sets = sample(LETTERS[3]))
    expect_s4_class(tidySet(df), "TidySet")
})

test_that("tidySet long", {
    df <- data.frame(
        DB = c(
            "RNAcentral", "RNAcentral", "RNAcentral",
            "RNAcentral", "RNAcentral"
        ),
        DB_Object_ID = c(
            "URS000003E1A9_9606", "URS000003E1A9_9606",
            "URS000003E1A9_9606", "URS000003E1A9_9606",
            "URS000003E1A9_9606"
        ),
        elements = c(
            "URS000003E1A9_9606", "URS000003E1A9_9606",
            "URS000003E1A9_9606", "URS000003E1A9_9606",
            "URS000003E1A9_9606"
        ),
        Qualifier = c("", "", "", "", ""),
        sets = c(
            "GO:0035195", "GO:0035195", "GO:0035195",
            "GO:0035195", "GO:0035195"
        ),
        DB_Reference = c(
            "PMID:15131085", "PMID:16762633",
            "PMID:23874542", "PMID:26371161", "PMID:28008308"
        ),
        Evidence_Code = c("IDA", "IMP", "IDA", "IDA", "IGI"),
        With_From = c("", "", "", "", "RNAcentral:URS000008DA94_10090"),
        Aspect = c("BP", "BP", "BP", "BP", "BP"),
        DB_Object_Name = c(
            "Homo sapiens (human) hsa-miR-141-3p",
            "Homo sapiens (human) hsa-miR-141-3p",
            "Homo sapiens (human) hsa-miR-141-3p",
            "Homo sapiens (human) hsa-miR-141-3p",
            "Homo sapiens (human) hsa-miR-141-3p"
        ),
        DB_Object_Type = c("miRNA", "miRNA", "miRNA", "miRNA", "miRNA"),
        Taxon = c(
            "taxon:9606", "taxon:9606", "taxon:9606",
            "taxon:9606", "taxon:9606"
        ),
        Date = c(20171020L, 20150925L, 20160616L, 20160622L, 20190307L),
        Assigned_By = c(
            "BHF-UCL", "BHF-UCL", "BHF-UCL", "BHF-UCL",
            "ARUK-UCL"
        ),
        Annotation_Extension = c(
            "regulates_expression_of(ENSEMBL:ENSG00000134852)",
            "regulates_expression_of(ENSEMBL:ENSG00000134852)",
            "regulates_expression_of(ENSEMBL:ENSG00000128513)",
    "occurs_in(CL:0002618),regulates_expression_of(ENSEMBL:ENSG00000090339)",
            "regulates_expression_of(ENSEMBL:ENSG00000171862)"
        ),
        stringsAsFactors = FALSE
    )
    expect_s4_class(tidySet(df), "TidySet")
})


test_that("Empty raw creation of TidySets", {
    expect_error(new("TidySet", sets = data.frame(sets = character()),
                     elements = data.frame(elements = character()),
                     relations = data.frame(sets = character(),
                                            elements = character(),
                                            fuzzy = numeric())),
                 NA)
})
