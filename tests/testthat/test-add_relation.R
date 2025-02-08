test_that("multiplication works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations)
    relations <- data.frame(
        sets = c(rep("a2", 5), "b2"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6),
        new = runif(6)
    )
    out <- add_relation(a, relations)
    expect_equal(nRelations(out), nRelations(a) * 2)
    expect_equal(nSets(out), nSets(a) * 2)
    expect_equal(nElements(out), nElements(a))
    expect_length(name_sets(a), 2L)
    expect_length(name_sets(out), 4L)
    expect_length(name_elements(a), 6L)
    expect_length(name_elements(out), 6L)
})
