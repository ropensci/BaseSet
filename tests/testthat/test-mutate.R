context("test-mutate")

relations <- data.frame(sets = c(rep("a", 5), "b"),
                        elements = letters[seq_len(6)],
                        fuzzy = runif(6))
a <- tidySet(relations = relations)

test_that("mutate_set works", {
  b <- mutate_set(a, Type = ifelse(sets == "b", "B", "D"))
  expect_equal(ncol(sets(b)), ncol(sets(a)) + 1)
  expect_equal(nSets(b), 2L)
})

test_that("mutate_element works", {
  b <- mutate_element(a, Type = ifelse(elements == "b", "B", "D"))
  expect_equal(ncol(elements(b)), ncol(elements(a)) + 1)
  expect_equal(nElements(b), 6L)

})

test_that("mutate_relation works", {
  b <- mutate_relation(a, Type = ifelse(elements == "b", "B", "D"))
  expect_equal(ncol(relations(b)), ncol(relations(a)) + 1)
  expect_equal(nRelations(b), 6L)
  b <- mutate_relation(a, fuzzy = fuzzy*2)

})
