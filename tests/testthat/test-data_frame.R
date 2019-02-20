context("test-data_frame")

test_that("as.data.frame works", {
  relations <- data.frame(sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
                          elements = rep(letters[seq_len(6)], 2),
                          fuzzy = runif(12))
  a <- tidySet(relations)
  b <- as.data.frame(a)
  expect_is(b, "data.frame")
})
