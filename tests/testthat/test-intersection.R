context("test-intersection")

test_that("intersection works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", "c"),
        elements = letters[seq_len(7)]
    )
    a <- tidySet(relations)
    b <- intersection(a, c("c", "b"), "d", keep = TRUE)
    expect_s4_class(b, "TidySet")
    expect_length(name_sets(b), 4L)
    expect_equal(nSets(b), 4L)
    expect_equal(nRelations(b), 9L)
    expect_equal(nElements(b), 7L)

    # Simple case with duplicate relations
    relations <- data.frame(
        sets = c(rep("a", 5), "b", "c"),
        elements = c(letters[seq_len(6)], letters[6])
    )
    a <- tidySet(relations)
    b <- intersection(a, c("c", "b"), "d")
    expect_s4_class(b, "TidySet")
    expect_equal(nRelations(b), 1L)
    expect_equal(nSets(b), 1L)
    expect_equal(nElements(b), 1L)
})

test_that("intersection works with fuzzy", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", "c"),
        elements = c(letters[seq_len(6)], letters[6]),
        fuzzy = runif(7)
    )
    a <- tidySet(relations)
    # Without merging fuzzy, just renaming
    b <- intersection(a, c("c", "b"), "d")
    expect_s4_class(b, "TidySet")
    expect_equal(nRelations(b), 1L)
    expect_equal(nSets(b), 1L)
    expect_equal(relations(b)$fuzzy, min(relations(a)[6:7, "fuzzy"]))

    d <- intersection(a, c("a", "c"), "d", keep = TRUE)
    expect_s4_class(d, "TidySet")
    expect_equal(nRelations(d), 13L)
    expect_equal(nSets(d), 4L)
    expect_equal(nElements(d), 6L)
})

test_that("intersection keep", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", "c"),
        elements = c(letters[seq_len(6)], letters[6]),
        fuzzy = runif(7)
    )
    a <- tidySet(relations)
    expect_equal(nSets(a), 3L)
    b <- intersection(a, c("c", "b"), "d", keep = TRUE)
    expect_s4_class(b, "TidySet")
    expect_equal(nSets(b), 4L)
    expect_equal(nElements(b), 6L)
    expect_equal(nRelations(b), 8L)

    expect_error(intersection(a, c("a", "c"), c("c", "b"), c("e"), keep = TRUE))

    d1 <- intersection(a, c("a", "c"), "d", keep = TRUE)
    d2 <- intersection(d1, c("c", "b"), "e", keep = TRUE)
    expect_s4_class(d2, "TidySet")
    expect_equal(nSets(d2), 5L)
    expect_equal(nRelations(d2), 14L)
    expect_equal(nElements(d2), 6L)
})

test_that("intersection with three sets", {
    # Simple case with duplicate relations
    relations <- data.frame(
        sets = c(rep("a", 4), "b", "b", "c"),
        elements = c("a", "b", "c", "d", "a", "d", "d")
    )
    a <- tidySet(relations)
    b <- intersection(a, c("a", "c", "b"), "d")
    expect_s4_class(b, "TidySet")
    expect_equal(nRelations(b), 1L)
    expect_equal(nSets(b), 1L)
    expect_equal(nElements(b), 1L)
})

test_that("intersection without duplicated values", {
    df <- data.frame(
        elements = c("a", "b", "c", "d", "e", "f", "f"),
        sets = c("A", "A", "A", "A", "A", "B", "C"),
        fuzzy = c(
            0.230918602552265, 0.741255367407575, 0.18338343128562,
            0.422168243443593,
            0.599639905616641, 0.277331340359524, 0.730731174349785
        )
    )

    TS <- tidySet(df)
    out <- intersection(TS, sets = c("A", "B"), name = "D", keep = TRUE)
    expect_s4_class(out, "TidySet")
    expect_equal(nSets(out), 4L)
    expect_equal(nRelations(out), 13L)
})
