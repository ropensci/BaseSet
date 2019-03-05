context("test-group")

test_that("group works", {
  relations <- data.frame(sets = c(rep("a", 5), "b"),
                          elements = letters[seq_len(6)],
                          fuzzy = runif(6))
  a <- tidySet(relations = relations)
  b <- group(a, "c", c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE))
  expect_equal(nSets(b), nSets(a) + 1)
  expect_equal(name_sets(b), letters[1:3])
})
