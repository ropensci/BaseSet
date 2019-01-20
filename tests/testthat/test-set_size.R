context("test-set_size")

test_that("set_size works", {
  x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
  a <- tidySet(x)
  out <- set_size(a, "a")
  expect_equal(out$a, 5L)
})

test_that("set_size works with fuzzy sets", {
  x <- list("a" = c("A" = 0.1, "B" = 0.5),
            "b" = c("A" = 0.2, "B" = 1))
  a <- tidySet(x)
  out <- set_size(a, "a")
  expect_length(out$a, 2L)
})

