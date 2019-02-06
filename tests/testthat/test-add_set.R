context("test-add_set")

test_that("add_set works", {
  relations <- data.frame(sets = c(rep("A", 5), "B", "B"),
                          elements = c("a", "b", "c", "d", "e", "a", "f"))
  a <- tidySet(relations)
  b <- add_set(a, elements = letters[7:15], setName = "DF")
  expect_s4_class(b, "TidySet")
  expect_equal(nSets(b), nSets(a) + 1)

  expect_error(add_set(a, elements = letters[7:15], setName = c("ha", "he")))

  elements(a) <- cbind(elements(a), Ha = c("bla", "ble", "bli", "blo", "blu", NA))
  d <- add_set(a, elements = letters[1:2], setName = "DF2")
  expect_equal(nSets(d), nSets(a) + 1)
  expect_error(add_set(a, elements = letters[1:2], setName = c("DF2", "df2")))
})

test_that("add_set fuzzy works", {
  relations <- data.frame(sets = c(rep("A", 5), "B", "B"),
                          elements = c("a", "b", "c", "d", "e", "a", "f"))
  a <- tidySet(relations)
  b <- add_set(a, elements = letters[7:15], setName = "ha", fuzzy = 0.5)
  expect_s4_class(b, "TidySet")
  expect_equal(nSets(b), nSets(a) + 1)

  elements(a) <- cbind(elements(a), Ha = c("bla", "ble", "bli", "blo", "blu", NA))
  d <- add_set(a, elements = letters[7:15], setName = "ha", fuzzy = 0.5)
  expect_s4_class(d, "TidySet")
  expect_equal(nSets(d), nSets(a) + 1)
  expect_error(add_set(a, elements = letters[7:15], setName = "ha", fuzzy = -1))
  expect_error(add_set(a, elements = letters[7:15], setName = c("ha", "he"), fuzzy = 1))
})
