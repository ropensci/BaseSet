context("test-tidyset")

test_that("tidySet data.frame", {
  relations <- data.frame(sets = c(rep("a", 5), "b"),
                          elements = letters[seq_len(6)],
                          fuzzy = runif(6))
  a <- tidySet(relations = relations)
  expect_s4_class(a, "TidySet")

  expect_error(tidySet(relations[0, ]), "must have")

  colnames(relations) <- c("a", "b")
  expect_error(tidySet(relations), "Unable to create a TidySet")

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

  relations <- list("A" = letters[1:5],
                    "B" = letters[1:7])
  expect_s4_class(tidySet(relations), "TidySet")

  relations <- list("A" = letters[1:5],
                    "B" = c(letters[1:7], "a"))
  expect_s4_class(tidySet(relations), "TidySet")

  # Mix of character and factors (just in case)
  relations <- list("A" = as.factor(letters[1:5]),
                    "B" = c(letters[1:7], "a"))
  expect_s4_class(tidySet(relations), "TidySet")
})

test_that("tidySet fails", {
  a <- new("TidySet")
  expect_s4_class(a, "TidySet")
  expect_true(any(grepl("must have", is.valid(a))))
  expect_true(any(grepl("colnames for elements", is.valid(a))))
  expect_true(any(grepl("colnames for sets", is.valid(a))))
  expect_true(any(grepl("colnames for relations", is.valid(a))))
  expect_true(any(grepl("Sets must be characters or factors", is.valid(a))))
  expect_true(any(grepl("Elements must be characters or factors", is.valid(a))))
  expect_true(any(grepl("A fuzzy column must be present", is.valid(a))))

  df <- data.frame(elements = c("a", letters[1:4]), sets = sample(LETTERS[3]))
  expect_s4_class(tidySet(df), "TidySet")
})


test_that("tidySet long",  {
  df <- data.frame(
    DB = c("RNAcentral", "RNAcentral", "RNAcentral",
           "RNAcentral", "RNAcentral"),
    DB_Object_ID = c("URS000003E1A9_9606", "URS000003E1A9_9606",
                     "URS000003E1A9_9606", "URS000003E1A9_9606",
                     "URS000003E1A9_9606"),
    elements = c("URS000003E1A9_9606", "URS000003E1A9_9606",
                 "URS000003E1A9_9606", "URS000003E1A9_9606",
                 "URS000003E1A9_9606" ),
    Qualifier = c("", "", "", "", ""),
    sets = c("GO:0035195", "GO:0035195", "GO:0035195",
             "GO:0035195", "GO:0035195"),
    DB_Reference = c("PMID:15131085", "PMID:16762633",
                     "PMID:23874542", "PMID:26371161", "PMID:28008308"),
    Evidence_Code = c("IDA", "IMP", "IDA", "IDA", "IGI"),
    With_From = c("", "", "", "", "RNAcentral:URS000008DA94_10090"),
    Aspect = c("BP", "BP", "BP", "BP", "BP"),
    DB_Object_Name = c("Homo sapiens (human) hsa-miR-141-3p",
                       "Homo sapiens (human) hsa-miR-141-3p",
                       "Homo sapiens (human) hsa-miR-141-3p",
                       "Homo sapiens (human) hsa-miR-141-3p",
                       "Homo sapiens (human) hsa-miR-141-3p"),
    DB_Object_Type = c("miRNA", "miRNA", "miRNA", "miRNA", "miRNA"),
    Taxon = c("taxon:9606", "taxon:9606", "taxon:9606",
              "taxon:9606", "taxon:9606"),
    Date = c(20171020L, 20150925L, 20160616L, 20160622L, 20190307L),
    Assigned_By = c("BHF-UCL", "BHF-UCL", "BHF-UCL", "BHF-UCL",
                    "ARUK-UCL"),
    Annotation_Extension = c(
      "regulates_expression_of(ENSEMBL:ENSG00000134852)",
      "regulates_expression_of(ENSEMBL:ENSG00000134852)",
      "regulates_expression_of(ENSEMBL:ENSG00000128513)",
      "occurs_in(CL:0002618),regulates_expression_of(ENSEMBL:ENSG00000090339)",
      "regulates_expression_of(ENSEMBL:ENSG00000171862)"),
    stringsAsFactors = FALSE)
  expect_s4_class(tidySet(df), "TidySet")
})
