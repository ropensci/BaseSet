test_that("multiplication works", {
    gmtFile <- system.file(
        package = "BaseSet", "extdata",
        "hallmark.gene.symbol.gmt"
    )
    gs <- getGMT(gmtFile)
    expect_s4_class(gs, "TidySet")
})
