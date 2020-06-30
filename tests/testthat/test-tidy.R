context("test-tidy")

test_that("tidy works in GeneSet", {
    gs1 <- GSEABase::GeneSet(
        setName = "set1", setIdentifier = "101",
        geneIds = c("a", "b")
    )
    gs2 <- GSEABase::GeneSet(
        setName = "set2", setIdentifier = "102",
        geneIds = c("b", "c")
    )
    expect_error(TS <- tidy(gs1), NA)
    expect_equal(ncol(sets(TS)), 5)
    expect_equal(nElements(TS), 2)
    expect_error(TS2 <- tidy(gs2), NA)
    expect_equal(ncol(sets(TS2)), 5)
    expect_equal(nElements(TS2), 2)
    TST <- merge_tidySets(TS, TS2)
    expect_equal(nSets(TST), 2)
    expect_equal(nElements(TST), 3)
})

test_that("tidy works in GeneSetCollection", {
    gs1 <- GSEABase::GeneSet(
        setName = "set1", setIdentifier = "101",
        geneIds = c("a", "b")
    )
    gs2 <- GSEABase::GeneSet(
        setName = "set2", setIdentifier = "102",
        geneIds = c("b", "c")
    )
    gsc <- GSEABase::GeneSetCollection(gs1, gs2)

    expect_error(TS <- tidy(gsc), NA)
    expect_equal(nSets(TS), 2)
    expect_equal(nElements(TS), 3)
    expect_equal(ncol(sets(TS)), 5)
})

test_that("tidy works in GeneColorSet", {
    library("GSEABase") # Needed otherwise experimentData is not imported
    data("sample.ExpressionSet", package = "Biobase")
    gcs1 <- GSEABase::GeneColorSet(sample.ExpressionSet[100:109],
        phenotype = "imaginary"
    )

    expect_error(TS <- tidy(gcs1), NA)
    expect_equal(nSets(TS), 1)
    expect_equal(nElements(TS), 10)
    expect_equal(ncol(sets(TS)), 9)
})
