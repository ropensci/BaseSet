context("test-rename")

test_that("rename_elements works", {
    x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
    a <- tidySet(x)
    expect_warning(b <- rename_elements(a, "a", "gh"), NA)
    expect_true("gh" %in% name_elements(b))
    expect_error(rename_elements(a, "z"), "must be found")
})

test_that("rename_set works", {
    x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
    a <- tidySet(x)
    b <- rename_set(a, "a", "gh")
    expect_true("gh" %in% name_sets(b))
    expect_error(rename_set(a, "z"), "must be found")
})

test_that("name_elements<- works well", {
    x <- data.frame(
        elements = c("a", "b", "c", "d", "e", "C", "D", "E", "F", "G"),
        sets = c("A", "A", "A", "A", "A", "B", "B", "B", "B", "B")
    )
    y <- tidySet(x)
    name_elements(y) <- letters[1:10]
    expect_equal(name_elements(y), letters[1:10])

    expect_error(name_elements(y) <- letters[1:11], "More elements provided")
})
