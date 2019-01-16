context("test-set")

relations <- data.frame(sets = c(rep("a", 5), "b"),
                        elements = letters[seq_len(6)],
                        fuzzy = runif(6))
a <- tidySet(relations = relations)

test_that("set works", {
  expect_s3_class(sets(a), "data.frame")
  expect_equal(nrow(sets(a)), 2L)
  expect_equal(ncol(sets(a)), 1L)
})

test_that("nSet works", {
  expect_equal(nrow(sets(a)), nSets(a))
})

test_that("set<- works", {
  sets(a) <- cbind(sets(a), test = "1")
  expect_equal(ncol(sets(a)), 2L)
})
