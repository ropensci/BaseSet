context("test-head")

relations <- data.frame(
    sets = c(rep("a", 5), "b"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
a <- tidySet(relations = relations)

test_that("head", {
    expect_equal(head(a), head(as.data.frame(a)))
})

test_that("tail", {
    expect_equal(tail(a), tail(as.data.frame(a)))
})

test_that("dim", {
    expect_equal(dim(a), c(nElements(a), nRelations(a), nSets(a)))
})
