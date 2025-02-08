test_that("incidence works", {
    x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
    a <- tidySet(x)

    out <- incidence(a)
    expect_true(is(out, "matrix"))
    expect_equal(ncol(out), 2L)
    expect_equal(nrow(out), nElements(a))
})
