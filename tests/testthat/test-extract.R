## $ ####
test_that("$ works in TidySet class", {
  TS <- tidySet(list(A = letters[1:5], B = letters[6]))
  expect_length(TS$elements, 6)
  expect_null(TS$adafd)
})

test_that("$<- works in TidySet class", {
  TS <- tidySet(list(A = letters[1:5], B = letters[6]))
  expect_length(TS$elements, 6)
  expect_warning(TS$adafd <- LETTERS[1:6])
  expect_equal(TS$adafd, LETTERS[1:6])
  expect_equal(ncol(relations(TS)), 4)

  TS$adafd <- LETTERS[1:6]
  expect_equal(TS$adafd, LETTERS[1:6])
  expect_equal(relations(TS)$adafd, LETTERS[1:6])

})

## [ ####
test_that("[i, j, k] subset works in TidySet class", {
  TS <- tidySet(list(A = letters[1:5], B = letters[6]))

  expect_warning(TS$abcd <- sample(c("ha", "he"), size = 6, replace = TRUE))

  expect_error(TS[, c(TRUE, FALSE, TRUE)], "j only accepts:")
  expect_equal(ncol(relations(TS[1, ])), 4)
  out <- TS[1, "elements", ]
  expect_s4_class(out, "TidySet")
  expect_equal(nElements(out), 1)

  out_v <- TS[c(1, 2, 2), "relations"]
  # Six relations even if the rows are duplicated!
  expect_equal(nRelations(out_v), 2)
  expect_equal(nElements(out_v), 2)

  expect_error(TS[c("A", "B", "B"), ])
})

test_that("[i] subset works in TidySet class", {
  TS <- tidySet(list(A = letters[1:5], B = letters[6]))
  out1 <- TS[c(1, 2, 2)]
  expect_equal(nRelations(out1), nRelations(TS[c(1, 2)]))
  out <- TS[c(1, NA, 2)]
  # NAs are ignored
  expect_equal(TS[c(1, 2)], out)
  # Watch out for the recycling vector rule!
  out_l <- TS[c(TRUE, TRUE)]
  expect_equal(out_l, TS)
})

## [[ ####
test_that("[[i]] subset works in TidySet class", {
  TS <- tidySet(list(A = letters[1:5], B = letters[6]))
  expect_equal(TS[[1]], TS[["A"]])
  expect_equal(dim(TS[["C"]]), c(Elements = 0, Relations = 0, Sets = 0))
})

# test_that("[i, j]<- subset works in TidySet class", {
#   TS <- tidySet(list(A = letters[1:5], B = letters[6]))
#   out <- TS[1, c("elements", "sets", "fuzzy")]
#   expect_equal(dim(relations(out)), dim(relations(TS[1, ])))
#   expect_error(TS[1, TS$elements], "undefined columns selected")
# })
#
# test_that("[i]<- subset works in TidySet class", {
#   TS <- tidySet(list(A = letters[1:5], B = letters[6]))
#   out <- TS[c(1, 2, 2)]
#   out <- TS[c(1, NA, 2)]
#   expect_equal(dim(relations(out)), dim(relations(TS[1, ])))
#   expect_error(TS[1, TS$elements], "undefined columns selected")
# })
#
# test_that("[[i]]<- subset works in TidySet class", {
#   TS <- tidySet(list(A = letters[1:5], B = letters[6]))
#   out <- TS[c(1, 2, 2)]
#   out <- TS[c(1, NA, 2)]
#   expect_equal(dim(relations(out)), dim(relations(TS[1, ])))
#   expect_error(TS[1, TS$elements], "undefined columns selected")
# })
