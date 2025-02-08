relations <- data.frame(
    sets = c(rep("a", 5), "b"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
a <- tidySet(relations = relations)

test_that("relations works", {
    expect_s3_class(relations(a), "data.frame")
    expect_equal(ncol(relations(a)), 3L)
    expect_equal(nrow(relations(a)), 6L)
})

test_that("nRelations works", {
    expect_equal(nrow(relations(a)), nRelations(a))
})

test_that("relations<- works", {
    relations(a) <- cbind(relations(a), P = "b")
    expect_equal(ncol(relations(a)), 4L)
})

test_that("relations<- works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = relations)

    expect_true(is.fuzzy(a))

    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)]
    )
    b <- tidySet(relations = relations)
    expect_false(is.fuzzy(b))
})
