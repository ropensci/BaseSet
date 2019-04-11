context("test-element_size")

test_that("element_size works", {
  relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
                          elements = c(letters[seq_len(6)], letters[6]),
                          fuzzy = runif(7))
  a <- tidySet(relations)
  df <- element_size(a)
  expect_equal(colnames(df), c("element", "size", "probability"))
  expect_error(element_size(a, "z"))
  out <- element_size(a, "b")
  expect_equal(nrow(out), 2L)
  expect_equal(out$size, c(0, 1))

  a1 <- add_elements(a, element = "g")
  expect_equal(element_size(a1, "g")$size, 0)
})
