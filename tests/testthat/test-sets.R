relations <- data.frame(
    sets = c(rep("a", 5), "b"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
a <- tidySet(relations = relations)

test_that("sets works", {
    expect_s3_class(sets(a), "data.frame")
    expect_equal(nrow(sets(a)), 2L)
    expect_equal(ncol(sets(a)), 1L)
})

test_that("nSet works", {
    expect_equal(nrow(sets(a)), nSets(a))
})

test_that("sets<- works", {
    sets(a) <- cbind(sets(a), test = "1")
    expect_equal(ncol(sets(a)), 2L)
})

test_that("replace_sets", {
    TS <- tidySet(list(A = letters[1:5], B = letters[2:10]))
    TS2 <- replace_sets(TS, data.frame(sets = c("A", "B", "C")))
    expect_s4_class(TS2, "TidySet")
    expect_equal(nrow(sets(TS2)), 3L)
    expect_length(name_sets(TS2), 3L)
    expect_equal(name_sets(TS2), c("A", "B", "C"))
})
