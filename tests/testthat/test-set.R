context("test-set")

test_that("set works", {
  x <- set("a")
  y <- set(c("a" = 0.2, "b" = 0.5))
  expect_s4_class(x, "Set")
  expect_s4_class(y, "Set")
})

test_that("is.fuzzy", {
  x <- set(c("a", "b"))
  y <- set(c("a" = 0.2, "b" = 0.5))
  expect_false(is.fuzzy(x))
  expect_true(is.fuzzy(y))
})

test_that("length", {
  x <- set(c("a", "b"))
  y <- set(c("a" = 0.2, "b" = 0.5))
  expect_length(x, 2L)
  expect_length(y, 2L)
})

test_that("set_size", {
  x <- set(c("a", "b"))
  x_out <- set_size(x)
  expect_equal(x_out, 2L)
  expect_equal(x_out, length(x))

  y <- set(c("a" = 0.2, "b" = 0.5))
  y_out <- set_size(y)
  expect_length(y_out, 2L)
  expect_equal(y_out, c("1" = 0.8*0.5+0.5*0.2,
                        "2" = 0.8*0.5))
})
