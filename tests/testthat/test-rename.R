context("test-rename")

test_that("rename_elements works", {
  x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
  a <- tidySet(x)
  b <- rename_elements(a, "a", "gh")
})

test_that("rename_elements works", {
  x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
  a <- tidySet(x)
  b <- rename_set(a, "a", "gh")
})
