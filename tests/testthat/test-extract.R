## $ ####
test_that("$ works", {
  TS <- tidySet(list(A = letters[1:5], B = letters[6]))
  expect_length(TS$elements, 6)
  expect_null(TS$adafd)
})

test_that("$<- works", {
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
test_that("[i, j, k] subset works", {
  TS <- tidySet(list(A = letters[1:5], B = letters[6]))

  expect_warning(TS$abcd <- sample(c("ha", "he"), size = 6, replace = TRUE))

  expect_error(TS[, c(TRUE, FALSE, TRUE)], "j only accepts:")
  expect_equal(ncol(relations(TS[1, ])), 4)

  first_element <- TS[1, "elements", ]
  expect_equal(nElements(first_element), 1)
  expect_equal(nSets(first_element), 2)
  expect_equal(nSets(first_element), nSets(TS))

  first_set <- TS[1, "sets", ]
  expect_equal(nElements(first_set), 6)
  expect_equal(nSets(first_set), 1)
  expect_equal(nRelations(first_set), 5)

  out_v <- TS[c(1, 2, 2), "relations"]
  # Six relations even if the rows are duplicated!
  expect_equal(nRelations(out_v), 2)
  expect_equal(nElements(out_v), 6)
  expect_equal(nSets(out_v), 2)

  expect_error(TS[c("A", "B", "B"), ])
})

test_that("add_column works as [<-", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations)

    df <- data.frame(well = c("GOOD", "BAD", "WORSE", "UGLY", "FOE", "HEY"))
    b <- add_column(a, "relations", df)
    a[, "relations", "well"] <- df$well
    expect_equal(a, b)

    set_data <- data.frame(
        Group     = c( 100 ,  200 ),
        Column     = c("abc", "def")
    )
    a[, "sets", c("Group", "Column")] <- set_data
    b <- add_column(b, "sets", set_data)
    expect_equal(a, b)
    # Reset and test with automatic merging.
    a$Group <- NULL
    a$Column <- NULL
    expect_error(a[, "sets", ] <- set_data,
                 "Assigning multiple columns to a single position!")
})

test_that("[i] subset works", {
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
test_that("[[i]] subset works", {
  TS <- tidySet(list(A = letters[1:5], B = letters[6]))
  expect_equal(TS[[1]], TS[["A"]])
  expect_equal(dim(TS[["C"]]), c(Elements = 6, Relations = 0, Sets = 0))
})

test_that("[[i]]<- subset works", {
  TS <- tidySet(list(A = letters[1:5], B = letters[6]))
  TS[["A"]] <- data.frame(sets = "C")
  expect_equal(nSets(TS), 2)
  expect_equal(name_sets(TS), c("B", "C"))
  TS[["B"]] <- NULL
  expect_equal(nSets(TS), 1)
  expect_equal(name_sets(TS), c("C"))
  expect_equal(nElements(TS), 0)


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
