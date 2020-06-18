context("test-remove_element")

test_that("remove_element works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = relations)
    b <- remove_element(a, "a")
    expect_equal(nElements(b), nElements(a) - 1)
})
