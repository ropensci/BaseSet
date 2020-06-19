context("test-arrange")

test_that("arrange works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
        elements = rep(letters[seq_len(6)], 2),
        fuzzy = runif(12)
    )
    a <- tidySet(relations)
    a <- mutate_element(a,
        type = c(rep("Gene", 4), rep("lncRNA", 2))
    )

    b <- arrange_element(a, desc(type))
    expect_equal(elements(b)[1, "type"], "lncRNA")
    # Arrange sets
    b <- arrange_set(a, sets)
    expect_equal(as.character(sets(b)[1, "sets"]), "a")
    b <- arrange_relation(a, desc(sets))
    expect_equal(as.character(relations(b)[1, "sets"]), "b2")
    b <- arrange(a, desc(sets))
    expect_equal(as.character(relations(b)[1, "sets"]), "b2")
})

test_that("check arrange by fuzzy values", {
    set.seed(4987951)
    r <- data.frame(
        sets = c(rep("A", 5), "B", rep("A2", 5), "B2"),
        elements = rep(letters[seq_len(6)], 2),
        fuzzy = runif(12),
        type = c(rep("Gene", 2), rep("Protein", 2), rep("lncRNA", 2))
    )
    TS <- tidySet(r)
    s <- arrange(TS, fuzzy)
    expect_equal(order(as.data.frame(s)$fuzzy), seq_len(12))
})
