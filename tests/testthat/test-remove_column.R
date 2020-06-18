context("test-remove_column")

test_that("remove_column works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6),
        well = c(
            "GOOD", "BAD", "WORSE", "UGLY", "FOE",
            "HEY"
        )
    )
    a <- tidySet(relations)

    b <- remove_column(a, "relations", "well")
    expect_true(ncol(relations(a)) > ncol(relations(b)))
})
