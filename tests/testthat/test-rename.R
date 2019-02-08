context("test-rename")

test_that("rename_elements works", {
  x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
  a <- tidySet(x)
  expect_warning(b <- rename_elements(a, "a", "gh"), NA)
  expect_true(any(grepl("gh", name_elements(b))))
  expect_error(rename_elements(a, "z"), "must be found")
})

test_that("rename_set works", {
  x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
  a <- tidySet(x)
  b <- rename_set(a, "a", "gh")
  expect_true(any(grepl("gh", name_sets(b))))
  expect_error(rename_set(a, "z"), "must be found")
})
