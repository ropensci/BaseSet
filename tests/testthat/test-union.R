context("test-union")

test_that("union works", {
  relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
                          elements = letters[seq_len(7)])
  a <- tidySet(relations)
  b <- union(a, "c", "b", "d") # Simple case without merging fuzzy (just renaming)
  expect_s4_class(b, "TidySet")
  expect_equal(name_sets(b), "d")
  expect_equal(name_elements(b), c("f", "g"))

  # Simple case with duplicate relations
  relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
                          elements = c(letters[seq_len(6)], letters[6]))
  a <- tidySet(relations)
  b <- union(a, "c", "b", "d")
  expect_s4_class(b, "TidySet")
  expect_equal(name_sets(b), "d")
  expect_equal(name_elements(b), "f")
})

test_that("union works fuzzy", {
  relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
                          elements = c(letters[seq_len(6)], letters[6]),
                          fuzzy = runif(7))
  a <- tidySet(relations)
  b <- union(a, "c", "b", "d") # Simple case without merging fuzzy (just renaming)
  expect_s4_class(b, "TidySet")
  expect_equal(name_sets(b), "d")
  expect_equal(name_elements(b), "f")
  expect_equal(b@relations$fuzzy, max(a@relations$fuzzy[6:7]))

  d <- union(a, "a", "c", "d")
  expect_s4_class(d, "TidySet")
  expect_equal(name_sets(d), "d")
  expect_equal(name_elements(d), letters[1:6])
})

test_that("union several sets", {
  relations <- data.frame(sets = c(rep("A", 4), "B", "C", "D"),
                          elements = letters[seq_len(7)])
  a <- tidySet(relations)
  b <- union(a, c("A", "B"), c("C", "D"), c("E", "F"))
  expect_s4_class(b, "TidySet")
  expect_length(name_sets(b), 2L)
  as_list <- as(b, "list")
  expect_named(as_list, c("E", "F"))
  expect_named(as_list$E, c("a", "b", "c", "d", "f"))
  expect_named(as_list$F, c("e", "g"))

  expect_error(union(a, c("A", "B"), c("C", "D"), "E"), "same length ")

})

test_that("union keep", {
  relations <- data.frame(sets = c(rep("A", 4), "B", "C", "D"),
                          elements = letters[seq_len(7)])
  a <- tidySet(relations)
  b <- union(a, "A", "C", "E", keep = TRUE)
  expect_s4_class(b, "TidySet")
  expect_length(name_sets(b), 5L)
  expect_equal(nSets(b), nSets(a) + 1)
})


test_that("union works fuzzy keep", {
  relations <- data.frame(sets = c(rep("a", 5), "b", "c"),
                          elements = c(letters[seq_len(6)], letters[6]),
                          fuzzy = runif(7))
  a <- tidySet(relations)
  b <- union(a, "c", "b", "d", keep = TRUE) # Simple case without merging fuzzy (just renaming)
  expect_s4_class(b, "TidySet")
  expect_equal(nSets(b), nSets(a) + 1)
  expect_equal(b@relations$fuzzy[8], max(a@relations$fuzzy[6:7]))

  d <- union(a, "a", "c", "d", keep = TRUE)
  expect_s4_class(d, "TidySet")
  expect_equal(nSets(d), nSets(a) + 1 )
  expect_equal(name_sets(d), name_sets(b))
  expect_equal(name_elements(d), letters[1:6])
})
