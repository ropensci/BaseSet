test_that("remove_relation works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = relations)

    b <- remove_relation(a, "b", "b")
    expect_equal(a, b)
    expect_equal(nRelations(b), 6L)
})

test_that("remove_relation works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = relations)

    b <- remove_relation(a, "e", "a")
    expect_equal(nRelations(b), 5L)
})
