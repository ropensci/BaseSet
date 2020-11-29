context("test-pull")

test_that("pull works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
        elements = rep(letters[seq_len(6)], 2),
        fuzzy = runif(12),
        stringsAsFactors = FALSE
    )
    a <- tidySet(relations)
    a <- mutate_element(a, type = c(rep("Gene", 4), rep("lncRNA", 2)))

    # Pull on the data.frame
    expect_length(pull(a, type), 12)

    # Pull relations
    out <- pull_relation(a, elements)
    expect_length(out, nRelations(a))

    # Pull element
    out <- pull_element(a, elements)
    expect_length(out, nElements(a))
    out <- pull_element(a, type)
    expect_length(out, nElements(a))
    expect_equal(out, c("Gene", "Gene", "Gene", "Gene", "lncRNA", "lncRNA"))

    # Pull sets
    out <- pull_set(a, sets)
    expect_equal(out, c("a", "b", "a2", "b2"))
})

test_that("pull uses active", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
        elements = rep(letters[seq_len(6)], 2),
        fuzzy = runif(12),
        stringsAsFactors = FALSE
    )
    a <- tidySet(relations)
    a <- mutate_element(a, type = c(rep("Gene", 4), rep("lncRNA", 2)))

    # Pull relations
    b <- activate(a, "relations")
    out <- pull_relation(b, elements)
    out2 <- pull(b, "elements")
    expect_error(pull(b, elements), NA)
    expect_equal(out, out2)

    # Pull element
    b <- activate(a, "elements")
    out <- pull(b, elements)
    expect_length(out, nElements(b))
    out <- pull(b, type)
    expect_length(out, nElements(b))
    expect_equal(out, c("Gene", "Gene", "Gene", "Gene", "lncRNA", "lncRNA"))

    # Pull sets
    a <- activate(a, "sets")
    out <- pull(a, sets)
    expect_equal(out, c("a", "b", "a2", "b2"))
    })
