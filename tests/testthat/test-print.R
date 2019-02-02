context("test-print")
relations <- data.frame(sets = c(rep("a", 5), "b"),
                        elements = letters[seq_len(6)],
                        fuzzy = runif(6))
a <- tidySet(relations = relations)
test_that("print works", {
  out <- show(a)
  expect_identical(colnames(out), c("elements", "sets", "fuzzy"))
})
