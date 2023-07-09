test_that("add_column works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations)

    df <- data.frame(well = c("GOOD", "BAD", "WORSE", "UGLY", "FOE", "HEY"))
    b <- add_column(a, "relations", df)
    expect_true(ncol(relations(a)) < ncol(relations(b)))
    expect_error(add_column(a, "relations", df[1:5, , drop = FALSE]))
})
