test_that("prod2 works", {
  expect_equal(prod2(1:10), prod(1:10))
  expect_equal(prod2(1:10), 3628800)
})
