context("test-tidyset")

test_that("tidySet data.frame", {
  relations <- data.frame(sets = c(rep("a", 5), "b"),
                          elements = letters[seq_len(6)],
                          fuzzy = runif(6))
  a <- tidySet(relations = relations)
  expect_s4_class(a, "TidySet")

  expect_error(tidySet(relations[0, ]), "must have")

  colnames(relations) <- c("a", "b")
  expect_error(tidySet(relations), "Unable to create a TidySet")

})

test_that("tidySet matrix", {

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

test_that("tidySet list", {

  relations <- list("A" = letters[1:5],
                    "B" = letters[1:7])
  expect_s4_class(tidySet(relations), "TidySet")

  relations <- list("A" = letters[1:5],
                    "B" = c(letters[1:7], "a"))
  expect_s4_class(tidySet(relations), "TidySet")
})

test_that("tidySet fails", {
  a <- new("TidySet")
  expect_s4_class(a, "TidySet")
  expect_true(any(grepl("must have", is.valid(a))))
  expect_true(any(grepl("colnames for elements", is.valid(a))))
  expect_true(any(grepl("colnames for sets", is.valid(a))))
  expect_true(any(grepl("colnames for relations", is.valid(a))))
  expect_true(any(grepl("Sets must be characters or factors", is.valid(a))))
  expect_true(any(grepl("Elements must be characters or factors", is.valid(a))))
  expect_true(any(grepl("A fuzzy column must be present", is.valid(a))))
})
