context("test-filter")

relations <- data.frame(sets = c(rep("a", 5), "b"),
                        elements = letters[seq_len(6)],
                        fuzzy = runif(6))
a <- tidySet(relations = relations)

test_that("filter_set works", {
  b <- filter_set(a, sets == "b")
  expect_equal(nSets(b), 1L)
  expect_error(filter_set(a, sets == "c"), "must be")
  expect_error(filter_set(a, elements == "hi"))
})

test_that("filter_element works", {
  b <- filter_element(a, elements == "b")
  expect_equal(nElements(b), 1L)

  expect_error(filter_element(a, elements == "hi"), "must be")
  expect_error(filter_element(a, sets == "hi"))
})

test_that("filter_relation works", {
  b <- filter_relation(a, sets == "b")
  expect_equal(nSets(b), 2L)

  # Allow TidySets without relations but elements and sets
  expect_error(filter_relation(a, sets == "c"), NA)
})

test_that("filter works", {
  b <- filter(a, sets == "b")
  expect_equal(nSets(b), 1L)

  expect_error(filter(a, sets == "c"), "must have")
})
