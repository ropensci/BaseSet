context("test-adjacency")

test_that("adjacency_element works", {
    x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
    a <- tidySet(x)
    expect_error(out <- adjacency_element(a), NA)
    expect_is(out, "matrix")
    expect_true(all(diag(out) == 1))
    expect_equal(out["a", "C"], 0)
})

test_that("adjacency_set works", {
    x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
    a <- tidySet(x)
    expect_error(out <- adjacency_set(a), NA)
    expect_is(out, "matrix")
    expect_true(all(diag(out) == 1))
    expect_equal(out["a", "b"], 0)
})
