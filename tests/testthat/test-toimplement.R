context("test-toimplement")

relations <- data.frame(sets = c(rep("a", 5), "b"),
                        elements = letters[seq_len(6)],
                        fuzzy = runif(6))
a <- tidySet(relations = relations)

test_that("it doesn't work", {
  expect_error(head(a))
  expect_error(tail(a))
  expect_error(seq_len(a))
  expect_null(dim(a))
})
