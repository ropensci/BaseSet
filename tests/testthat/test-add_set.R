context("test-add_set")

test_that("add_set works", {
  relations <- data.frame(sets = c(rep("A", 5), "B", "B"),
                          elements = c("a", "b", "c", "d", "e", "a", "f"))
  a <- tidySet(relations)
  b <- add_set(a, elements = letters[7:15], setName = "DF")
  expect_s4_class(b, "TidySet")
  expect_equal(nSets(b), nSets(a) + 1)

  elements(a) <- cbind(elements(a), Ha = c("bla", "ble", "bli", "blo", "blu", NA))

  d <- add_set(a, elements = letters[1:2], setName = "DF2")
})
