context("test-fuzzification")

test_that("fuzzification works", {
  fuz <- function(x){
    y <- ifelse(x > 0.5, "high", "low")
    out <- cbind.data.frame(x, y)
    colnames(out) <- c("fuzzy", "elements")
    out
  }
  a <- fuzzification("fuzzy", fuz, runif(50))
  expect_s4_class(a, "TidySet")
})
