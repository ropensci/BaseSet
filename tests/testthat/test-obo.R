test_that("getOBO works", {
    fl <- system.file("extdata", "goslim_plant.obo", package = "GSEABase")
    y <- getOBO(fl)
    expect_true(is(y, "TidySet"))
})

test_that("getGAF works", {
    fl <- system.file("extdata", "go_human_rna_valid_subset.gaf",
        package = "BaseSet"
    )
    y <- getGAF(fl)
    expect_true(is(y, "TidySet"))
})
