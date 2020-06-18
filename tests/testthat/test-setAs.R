context("test-setAs")

relations <- data.frame(
    sets = c(rep("a", 5), "b"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
a <- tidySet(relations = relations)

test_that("setAs works", {
    b <- as(a, "list")

    expect_true(is.list(b))
    expect_true(!is.null(names(b)))
    expect_true(is.character(names(b[[1]])))
    expect_true(is.numeric(b[[1]]))
})

test_that("as.list works", {
    b <- as.list(a)

    expect_true(is.list(b))
    expect_true(!is.null(names(b)))
    expect_true(is.character(names(b[[1]])))
    expect_true(is.numeric(b[[1]]))
})
