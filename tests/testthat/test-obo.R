test_that("getOBO works", {
    skip_if_not_installed("GSEABase")
    fl <- system.file("extdata", "goslim_plant.obo", package = "GSEABase",
                      mustWork = TRUE)
    y <- getOBO(fl)
    expect_true(is(y, "TidySet"))
})

test_that("getGAF works", {
    fl <- system.file("extdata", "go_human_rna_valid_subset.gaf",
        package = "BaseSet", mustWork = TRUE)
    y <- getGAF(fl)
    expect_true(is(y, "TidySet"))
})
