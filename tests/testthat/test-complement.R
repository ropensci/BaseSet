context("test-complement")

test_that("complement works", {
  relations <- data.frame(sets = c(rep("a", 5), "b"),
                          elements = letters[seq_len(6)],
                          fuzzy = runif(6))
  a <- tidySet(relations = relations)
  b <- complement_set(a, "b")
  expect_equal(nSets(b), 1L)
  expect_equal(nElements(b), 5L)
})
