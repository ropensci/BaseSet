context("test-intersection")

test_that("intersection works", {
  relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
                          elements = letters[seq_len(7)])
  a <- tidySet(relations)
  b <- intersection(a, c("c", "b"), "d")
  expect_s4_class(b, "TidySet")
  expect_equal(name_sets(b), "d")
  expect_equal(nSets(b), 1L)
  expect_equal(nRelations(b), 0L)
  expect_equal(nElements(b), 0L)

  # Simple case with duplicate relations
  relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
                          elements = c(letters[seq_len(6)], letters[6]))
  a <- tidySet(relations)
  b <- intersection(a, c("c", "b"), "d")
  expect_s4_class(b, "TidySet")
  expect_equal(nRelations(b), 1L)
  expect_equal(nSets(b), 1L)
  expect_equal(nElements(b), 1L)
})

test_that("intersection works with fuzzy", {

  relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
                          elements = c(letters[seq_len(6)], letters[6]),
                          fuzzy = runif(7))
  a <- tidySet(relations)
  b <- intersection(a, c("c", "b"), "d") # Simple case without merging fuzzy (just renaming)
  expect_s4_class(b, "TidySet")
  expect_equal(nRelations(b), 1L)
  expect_equal(nSets(b), 1L)
  expect_equal(relations(b)$fuzzy, min(relations(a)[6:7, "fuzzy"]))


  d <- intersection(a, c("a", "c"), "d")
  expect_s4_class(d, "TidySet")
  expect_equal(nRelations(d), 0L)
  expect_equal(nSets(d), 1L)
  expect_equal(nElements(d), 0L)
})

test_that("intersection keep", {

  relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
                          elements = c(letters[seq_len(6)], letters[6]),
                          fuzzy = runif(7))
  a <- tidySet(relations)
  expect_equal(nSets(a), 3L)
  b <- intersection(a, c("c", "b"), "d", keep = TRUE) # Simple case without merging fuzzy (just renaming)
  expect_s4_class(b, "TidySet")
  expect_equal(nSets(b), 4L)
  expect_equal(nElements(b), 6L)
  expect_equal(nRelations(b), 8L)

  expect_error(intersection(a, c("a", "c"), c("c", "b"), c("e"), keep = TRUE))

  d1 <- intersection(a, c("a", "c"), "d", keep = TRUE)
  d2 <- intersection(d1, c("c", "b"), "e", keep = TRUE)
  expect_s4_class(d2, "TidySet")
  expect_equal(nSets(d2), 5L)
  expect_equal(nRelations(d2), 8L)
  expect_equal(nElements(d2), 6L)
})
