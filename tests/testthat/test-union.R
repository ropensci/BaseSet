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

test_that("union several sets", {
  relations <- data.frame(sets = c(rep("A", 4), "B", "C", "D"),
                          elements = letters[seq_len(7)])
  a <- tidySet(relations)
  b <- union(a, c("A", "B"), c("C", "D"), c("E", "F"))
  expect_s4_class(b, "TidySet")
  expect_length(name_sets(b), 2L)
  as_list <- as(b, "list")
  expect_named(as_list, c("E", "F"))
  expect_named(as_list$E, c("a", "b", "c", "d", "f"))
  expect_named(as_list$F, c("e", "g"))

  expect_error(union(a, c("A", "B"), c("C", "D"), "E"), "same length ")

})

test_that("union keep", {
  relations <- data.frame(sets = c(rep("A", 4), "B", "C", "D"),
                          elements = letters[seq_len(7)])
  a <- tidySet(relations)
  b <- union(a, "A", "C", "E", keep = TRUE)
  expect_s4_class(b, "TidySet")
  expect_length(name_sets(b), 5L)
  expect_equal(nSets(b), nSets(a) + 1)
})
