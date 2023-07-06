test_that("c works", {
  TS <- tidySet(list(a = letters[1:5], b = letters[6]))
  TS2 <- c(TS, TS)
  expect_equal(dim(TS2), dim(TS))
  expect_equal(TS2, TS)
  TS0 <- tidySet(list(A = letters[1:5], B = letters[6]))
  TS3 <- c(TS, TS0)
  expect_equal(nRelations(TS3)/2, nRelations(TS))
  expect_equal(nSets(TS3)/2, nSets(TS))
  expect_equal(nElements(TS3), nElements(TS))
})

test_that("c works with other types", {
    TS <- tidySet(list(A = letters[1:5], B = letters[6]))
    TS2 <- c(TS, data.frame(sets = "C", elements = "gg"))
    expect_equal(dim(TS2), dim(TS) + c(1, 1, 1))

    TS2 <- c(TS, list(C = "gg"))
    expect_equal(dim(TS2), dim(TS) + c(1, 1, 1))

    expect_error(c(TS, list(a = "C", fuzzy = NA)))
    TS3 <- c(TS, NULL, list(C = "gg"))
    expect_equal(TS2, TS3)
    TS4 <- c(TS, NULL, list(C = "gg"), list(D = "ge"))
    expect_equal(dim(TS4), c(Elements = 8, Relations = 8, Sets = 4))
})
