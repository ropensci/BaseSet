context("test-subtract")

test_that("subtract works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", "c"),
        elements = c(letters[seq_len(6)], letters[6]),
        fuzzy = runif(7)
    )
    a <- tidySet(relations)
    b <- subtract(a, set_in = c("a", "b"), "c", "D")
    expect_s4_class(b, "TidySet")
    expect_equal(nElements(b), 6L)
    expect_equal(nRelations(b), 12L)
    expect_equal(nSets(b), 4L)

    b <- subtract(a, set_in = c("a", "b"), "c")
    expect_equal(name_sets(b)[4], "(a∪b)∖c")
})

test_that("error", {
    TS <- tidySet(data.frame(
        elements = c("c", "c", "a", "b", "b"),
        sets = c("A", "B", "B", "B", "C")
    ))
    expect_error(subtract(TS,
        set_in = "A", not_in = "B", name = "A-B",
        keep_elements = TRUE, keep_sets = TRUE,
        keep_relations = FALSE
    ), NA)
})
