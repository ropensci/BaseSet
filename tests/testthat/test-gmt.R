context("test-gmt")

test_that("multiplication works", {
  gmtText <- c(
    "KEGG_GLYCOLYSIS_GLUCONEOGENESIS\thttp://www.broadinstitute.org/gsea/msigdb/cards/KEGG_GLYCOLYSIS_GLUCONEOGENESIS\tACSS2\tGCK\tPGK2\tPGK1",
    "KEGG_CITRATE_CYCLE_TCA_CYCLE\thttp://www.broadinstitute.org/gsea/msigdb/cards/KEGG_CITRATE_CYCLE_TCA_CYCLE\tIDH3B\tDLST\tPCK2" )
  gs <- getGMT(textConnection(gmtText))
  expect_s4_class(gs, "TidySet")
})
