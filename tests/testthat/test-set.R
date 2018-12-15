context("test-set")

test_that("set works", {
  x <- set("a")
  expect_s4_class(x, "Set")
})
