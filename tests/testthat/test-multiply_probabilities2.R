test_that("multiply_probabilities c++ works", {
    expect_equal(
        multiply_probabilities2(c(0.5, 0.1, 0.3, 0.85, 0.25, 0.23), c(1, 2)),
        multiply_probabilities(c(0.5, 0.1, 0.3, 0.85, 0.25, 0.23), c(1, 2)))
})
