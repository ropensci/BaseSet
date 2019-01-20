context("test-name")

test_that("name_sets works", {
  relations <- data.frame(sets = c(rep("a", 5), "b"),
                         elements = letters[seq_len(6)],
                         fuzzy = runif(6))
  a <- tidySet(relations = relations)
  out <- name_sets(a)
  expect_length(out, 2L)
  expect_equal(out, c("a", "b"))
})

test_that("name_elements works", {
  relations <- data.frame(sets = c(rep("a", 5), "b"),
                         elements = letters[seq_len(6)],
                         fuzzy = runif(6))
  a <- tidySet(relations = relations)
  out <- name_elements(a)
  expect_length(out, 6L)
  expect_equal(out, letters[1:6])
})
