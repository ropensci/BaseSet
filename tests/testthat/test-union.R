context("test-union")

test_that("union works", {
  relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
                          elements = letters[seq_len(7)])
  a <- tidySet(relations)
  b <- union(a, "c", "b", "d") # Simple case without merging fuzzy (just renaming)
  expect_s4_class(b, "TidySet")
  expect_equal(name_sets(b), c("a", "d"))

  # Simple case with duplicate relations
  relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
                          elements = c(letters[seq_len(6)], letters[6]))
  a <- tidySet(relations)
  b <- union(a, "c", "b", "d")
  expect_s4_class(b, "TidySet")
})

test_that("union works", {

  relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
                          elements = c(letters[seq_len(6)], letters[6]),
                          fuzzy = runif(7))
  a <- tidySet(relations)
  b <- union(a, "c", "b", "d") # Simple case without merging fuzzy (just renaming)
  expect_s4_class(b, "TidySet")
  expect_equal(relations(b)$fuzzy[6], max(relations(a)[6:7, "fuzzy"]))

  d <- union(a, "a", "c", "d")
  expect_s4_class(d, "TidySet")
})
