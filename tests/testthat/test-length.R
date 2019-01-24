context("test-length")

  p <- c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23)
test_that("multiply_probabilities works", {
  out <- multiply_probabilities(p, c(1, 3)) # Select 1 and 3
  expect_length(out, 1L)
  # Note the diffference from 0.3 to 0.7 on the third element
  # (1- 0.5 remains 0.5)
  expect_equal(out, prod(c(0.5, 0.1, 0.7, 0.5, 0.25, 0.23)))

  out <- multiply_probabilities(p, NULL) # Do not select anyone
  expect_length(out, 1L)
  expect_equal(out, prod((1 - p)))

  out <- multiply_probabilities(p, seq_along(p)) # Select all of them
  expect_length(out, 1L)
  expect_equal(out, prod(p))
})

test_that("length_probability works", {
  out <- length_probability(p, 2)
  expect_length(out, 1L)
  expect_equal(out, 0.06009375)

  out <- length_probability(p, 0)
  expect_length(out, 1L)
  expect_equal(out, 0.09095625)


  out <- length_probability(c(1, 0.2), 1)
  expect_length(out, 1L)
  expect_equal(out, 0.8)
})


test_that("length_set works", {
  out <- length_set(p)
  expect_length(out, 7L)
  expect_equal(sum(out), 1L, tolerance = 0.0005)
})

test_that("combn_indices works", {
  i <- combn_indices(5, 2)
  expect_length(i, choose(5, 2))
  expect_true(all(table(unlist(i)) == 4))
})
