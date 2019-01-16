context("test-elements")

relations <- data.frame(sets = c(rep("a", 5), "b"),
                        elements = letters[seq_len(6)],
                        fuzzy = runif(6))
a <- tidySet(relations = relations)

test_that("elements works", {
  expect_s3_class(elements(a), "data.frame")
  expect_equal(ncol(elements(a)), 1L)
  expect_equal(nrow(elements(a)), 6L)
})

test_that("nElements works", {
  expect_equal(nrow(elements(a)), nElements(a))
})
test_that("elements<- works", {
  elements(a) <- cbind(elements(a), P = "b")
  expect_equal(ncol(elements(a)), 2L)
})
