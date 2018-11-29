context("test-set")

test_that("multiplication works", {
  x <- set("a")
  expect_s4_class(x, "Set")
})
