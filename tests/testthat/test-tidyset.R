context("test-tidyset")

test_that("tidySet works", {
  relations <- data.frame(sets = c(rep("a", 5), "b"),
                          elements = letters[seq_len(6)],
                          fuzzy = runif(6))
  a <- tidySet(relations = relations)
  expect_s4_class(a, "TidySet")

  expect_error(tidySet(relations[0, ]), "must have")

  colnames(relations) <- c("a", "b")
  expect_error(tidySet(relations), "Unable to create a TidySet")


  m <- matrix(runif(6), ncol = 2, nrow = 3)
  colnames(m) <- LETTERS[1:2]
  rownames(m) <- letters[1:3]
  expect_s4_class(tidySet(m), "TidySet")
  m2 <- m
  colnames(m2) <- c("A", "A")
  expect_error(tidySet(m2), "duplicate")
  rownames(m) <- c("a", "a", "b")
  expect_error(tidySet(m), "duplicate")
})

test_that("tidySet works", {
  a <- new("TidySet")
  expect_s4_class(a, "TidySet")
  expect_error(validObject(a))
})
