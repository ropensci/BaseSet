context("test-union")

test_that("union works", {
  relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
                          elements = letters[seq_len(7)])
  a <- tidySet(relations)
  b <- union(a, "c", "b", "d") # Simple case without merging fuzzy (just renaming)
  expect_s4_class(b, "TidySet")
})
