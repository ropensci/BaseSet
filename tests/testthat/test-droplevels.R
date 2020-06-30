test_that("droplevels sets works", {
    rel <- list(A = letters[1:3], B = character())
    TS <- tidySet(rel)
    expect_equal(nrow(sets(TS)), 2)
    TS2 <- droplevels(TS)
    expect_equal(nrow(sets(TS2)), 1)
})

test_that("droplevels elements works", {
    rel <- list(A = letters[1:3])
    TS <- tidySet(rel)
    TS <- add_elements(TS, letters[4])
    expect_equal(nrow(elements(TS)), 4)
    TS2 <- droplevels(TS)
    expect_equal(nrow(elements(TS2)), 3)
})

test_that("droplevels relations works", {
    rel <- list(A = letters[1:3], B = letters[1])
    TS <- tidySet(rel)
    TS <- filter(TS, sets == "A") # Used droplevels internally
    expect_equal(nrow(relations(TS)), 3)
})
