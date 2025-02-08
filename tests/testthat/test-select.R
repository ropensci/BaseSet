test_that("select works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
        elements = rep(letters[seq_len(6)], 2),
        fuzzy = runif(12)
    )
    a <- tidySet(relations)
    a <- mutate_element(a,
        type = c(rep("Gene", 4), rep("lncRNA", 2))
    )

    b <- select(a, -type)
    expect_equal(dim(elements(b)), c(6, 1))
    b <- select_element(a, elements)
    expect_equal(dim(elements(b)), c(6, 1))
    # Select sets
    b <- select_set(a, sets)
    expect_equal(dim(sets(b)), c(4, 1))
    a <- mutate_relation(a, random = sample(c("A", "B", "C"), nRelations(a),
        replace = TRUE
    ))
    b <- select_relation(a, random, sets, elements, fuzzy)
    expect_equal(dim(relations(b)), c(12, 4))
    expect_equal(colnames(relations(b)),
                 c("random", "sets", "elements", "fuzzy"))

    b <- select(a, sets, elements, fuzzy)
    expect_equal(nRelations(b), 12L)
})
