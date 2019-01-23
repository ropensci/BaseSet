context("test-length")

test_that("length_set works", {
  out <- length_set(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23))
  expect_length(out, 6L)
  expect_equal(sum(out), 1L, tolerance = 0.0005)
})

test_that("multiply_probabilities works", {
  out <- multiply_probabilities(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23), c(1, 3))
  expect_length(out, 1L)
  expect_equal(out, log10(prod(c(0.5, 0.1, 0.7, 0.5, 0.25, 0.23))))
})

test_that("length_probability works", {
  out <- length_probability(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23), 2)
  expect_length(out, 1L)
  expect_equal(out, 0.06009375)
})


test_that("combn_indices works", {
  i <- combn_indices(5, 2)
  expect_length(i, choose(5, 2))
  expect_true(all(table(unlist(i)) == 4))
})
