context("test-setcollection")

test_that("setCollection works", {
  a <- set(c("a", "b"))
  b <- set(c("a", "b"))
  d <- setCollection(c(a, b))
  expect_s4_class(d, "SetCollection")
})

test_that("is.fuzzy", {
  a <- set(c("a", "b"))
  b <- set(c("a", "b"))
  d <- setCollection(c(a, b))
  expect_false(is.fuzzy(d))

  a <- set(c("a", "b"))
  b <- set(c("a" = 1, "b" = 0.5))
  d2 <- setCollection(c(a, b))
  expect_true(is.fuzzy(d2))
})

test_that("elements", {
  a <- set(c("a", "b"))
  b <- set(c("a", "b"))
  d <- setCollection(c(a, b))
  out <- elements(d)
  expect_true(is(out, "list"))
  expect_length(out, 2L)
  expect_equal(lengths(out), c(2L, 2L))

})

test_that("sets", {
  a <- set(c("a", "b"))
  b <- set(c("a", "b"))
  d <- setCollection(c("a" = a, "b" = b))
  out <- sets(d)
  expect_true(is(out, "character"))
  expect_length(out, 2L)
  expect_equal(out, c("a", "b"))
})

test_that("sets", {
  a <- set(c("a", "b"))
  b <- set(c("a", "b"))
  d <- setCollection(c("a" = a, "b" = b))
  out <- n_sets(d)
  expect_true(is(out, "numeric"))
  expect_equal(out, 2L)
})
