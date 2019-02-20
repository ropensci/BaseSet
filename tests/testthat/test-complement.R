context("test-complement")

test_that("complement set works", {
  relations <- data.frame(sets = c(rep("a", 5), "b"),
                          elements = letters[seq_len(6)],
                          fuzzy = runif(6))
  a <- tidySet(relations = relations)
  b <- complement_set(a, "b")
  expect_equal(nSets(b), 1L)
  expect_equal(nElements(b), 5L)
  expect_equal(complement_set(a, "b"), remove_set(a, "b"))
})


test_that("complement set works for several sets", {
  relations <- data.frame(sets = c(rep("A", 5), "B", "C"),
                          elements = c(letters[seq_len(6)], letters[6]),
                          fuzzy = runif(7))
  fuzzy_set <- tidySet(relations)
  b <- complement_set(fuzzy_set, c("A", "C"))
  expect_equal(nSets(b), 1L)
  expect_equal(nElements(b), 0)
})

test_that("complement element works", {
  relations <- data.frame(sets = c(rep("a", 5), "b"),
                          elements = letters[seq_len(6)],
                          fuzzy = runif(6))
  a <- tidySet(relations = relations)
  b <- complement_element(a, "b")
  expect_equal(nSets(b), 1L)
  expect_equal(nElements(b), 5L)
  expect_equal(nRelations(b), 1L)
})
