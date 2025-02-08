relations <- data.frame(
    sets = c(rep("a", 5), "b"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
a <- tidySet(relations = relations)
test_that("print works", {
    expect_output(show(a), "elements\\s+sets\\s+fuzzy")
})
