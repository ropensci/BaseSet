context("test-remove_set")

test_that("remove_set works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = relations)
    b <- remove_set(a, "b")
    expect_equal(nSets(b), nSets(a) - 1)
})
