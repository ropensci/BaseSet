test_that("not_in works", {
  x <- seq(from = 0, to = 1, by = 0.1)
  expect_equal(not_in(x, c(1, 2)), x[-c(1, 2)])
  expect_equal(not_in(x, c(2, 3)), x[-c(2, 3)])
  expect_equal(not_in(x, 0), x[-1])
})
