context("test-pull")

test_that("pull works", {
  relations <- data.frame(sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
                          elements = rep(letters[seq_len(6)], 2),
                          fuzzy = runif(12))
  a <- tidySet(relations)
  a <- mutate_element(a, type = c(rep("Gene", 4), rep("lncRNA", 2)))
  pull(a, type)
  # Equivalent to pull_relation
  b <- activate(a, "relations")
  out <- pull_relation(b, elements)
  expect_length(out, nRelations(b))
  out <- pull_element(b, elements)
  expect_length(out, nElements(b))
  # Filter element
  out <- pull_element(a, type)
  expect_length(out, nElements(a))
  expect_equal(out, c("Gene", "Gene", "Gene", "Gene", "lncRNA", "lncRNA"))
  # Filter sets
  out <- pull_set(a, sets)
  expect_equal(out, structure(c(1L, 3L, 2L, 4L),
                              .Label = c("a", "a2", "b", "b2"),
                              class = "factor"))
})
