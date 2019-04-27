context("independent")

test_that("independent works", {
    x <- list("A" = letters[1:5], "B" = letters[3:7], "C" = letters[6:10])
    TS <- tidySet(x)
    expect_false(independent(TS))
    expect_false(independent(TS, c("A", "B")))
    expect_true(independent(TS, c("A", "C")))
    expect_false(independent(TS, c("B", "C")))
})
