context("test-rename")

test_that("rename_elements works", {
  x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
  a <- tidySet(x)
  b <- rename_elements(a, "a", "gh")
  expect_equal(name_elements(b)[1], "gh")
})

test_that("rename_set works", {
  x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
  a <- tidySet(x)
  b <- rename_set(a, "a", "gh")
  expect_equal(name_sets(b), c("gh", "b"))
})
