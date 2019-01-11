context("test-tidyset")

test_that("tidySet works", {
  relations <- data.frame(sets = c(rep("a", 5), "b"),
                          elements = letters[seq_len(6)],
                          fuzzy = runif(6))
  a <- tidySet(relations = relations)
  expect_s4_class(a, "TidySet")
})
