relations <- data.frame(
    sets = c(rep("a", 5), "b"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
a <- tidySet(relations = relations)

test_that("filter_set works", {
    b <- filter_set(a, sets == "b")
    expect_equal(nSets(b), 1L)
    # Check that it allows to filter and still keeps elements or sets
    expect_error(d <- filter_set(a, sets == "c"), NA)
    expect_equal(nSets(d), 0)
    expect_equal(nElements(d), 6)

    expect_error(filter_set(a, elements == "hi"))
})

test_that("filter_element works", {
    b <- filter_element(a, elements == "b")
    expect_equal(nElements(b), 1L)

    expect_error(d <- filter_element(a, elements == "hi"), NA)
    expect_equal(nElements(d), 0L)
    expect_equal(nElements(d), 0L)
    expect_error(filter_element(a, sets == "hi"))
})

test_that("filter_relation works", {
    b <- filter_relation(a, sets == "b")
    expect_equal(nSets(b), 2L)

    # Allow TidySet without relations but elements and sets
    expect_error(filter_relation(a, sets == "c"), NA)
})

test_that("filter works", {
    b <- filter(a, sets == "b")
    expect_equal(nSets(b), 1L)

    expect_error(ts <- filter(a, sets == "c"), NA)
    expect_equal(nSets(ts), 0L)
    expect_equal(nRelations(ts), 0L)
    expect_equal(nElements(ts), 0L)
})
