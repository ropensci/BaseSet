test_that("adjacency_element works", {
    x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
    a <- tidySet(x)
    expect_error(out <- adjacency_element(a), NA)
    expect_true(is.matrix(out))
    expect_true(all(diag(out) == 1))
    expect_equal(out["a", "C"], 0)
})

test_that("adjacency_set works", {
    x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
    a <- tidySet(x)
    expect_error(out <- adjacency_set(a), NA)
    expect_true(is.matrix(out))
    expect_true(all(diag(out) == 1))
    expect_equal(out["a", "b"], 0)
})

test_that("adjacency works", {
    x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
    a <- tidySet(x)
    expect_warning(expect_null(adjacency(a)))

    b <- activate(a, "relations")
    expect_true(is.null(adjacency(b)))
    b <- activate(a, "sets")
    expect_true(is.matrix(adjacency(b)))
    b <- activate(a, "elements")
    expect_true(is.matrix(adjacency(b)))
})
