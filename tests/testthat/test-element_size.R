context("test-element_size")

test_that("element_size works", {
  relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
                          elements = c(letters[seq_len(6)], letters[6]),
                          fuzzy = runif(7))
  a <- tidySet(relations)
  df <- element_size(a)
  expect_equal(colnames(df), c("element", "size", "probability"))
})
