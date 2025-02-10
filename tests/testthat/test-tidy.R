test_that("tidy works in GeneSet", {
    skip_if_not_installed("GSEABase")
    gs1 <- GSEABase::GeneSet(
        setName = "set1", setIdentifier = "101",
        geneIds = c("a", "b")
    )
    gs2 <- GSEABase::GeneSet(
        setName = "set2", setIdentifier = "102",
        geneIds = c("b", "c")
    )
    expect_error(TS <- tidySet(gs1), NA)
    expect_equal(ncol(sets(TS)), 5L)
    expect_equal(nElements(TS), 2L)
    expect_error(TS2 <- tidySet(gs2), NA)
    expect_equal(ncol(sets(TS2)), 5L)
    expect_equal(nElements(TS2), 2L)
    TST <- merge_tidySets(TS, TS2)
    expect_equal(nSets(TST), 2L)
    expect_equal(nElements(TST), 3L)
})

test_that("tidy works in GeneSetCollection", {
    skip_if_not_installed("GSEABase")
    gs1 <- GSEABase::GeneSet(
        setName = "set1", setIdentifier = "101",
        geneIds = c("a", "b")
    )
    gs2 <- GSEABase::GeneSet(
        setName = "set2", setIdentifier = "102",
        geneIds = c("b", "c")
    )
    gsc <- GSEABase::GeneSetCollection(gs1, gs2)

    expect_error(TS <- tidySet(gsc), NA)
    expect_equal(nSets(TS), 2L)
    expect_equal(nElements(TS), 3L)
    expect_equal(ncol(sets(TS)), 5L)
})

test_that("tidy works in GeneColorSet", {
    skip_if_not_installed("GSEABase")
    skip_if_not_installed("Biobase")
    library("GSEABase") # Needed otherwise experimentData is not imported
    data("sample.ExpressionSet", package = "Biobase")
    gcs1 <- GSEABase::GeneColorSet(sample.ExpressionSet[100:109],
        phenotype = "imaginary"
    )

    expect_error(TS <- tidySet(gcs1), NA)
    expect_equal(nSets(TS), 1L)
    expect_equal(nElements(TS), 10L)
    expect_equal(ncol(sets(TS)), 1L)
})
