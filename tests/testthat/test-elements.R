relations <- data.frame(
    sets = c(rep("a", 5), "b"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
a <- tidySet(relations = relations)

test_that("elements works", {
    expect_s3_class(elements(a), "data.frame")
    expect_equal(ncol(elements(a)), 1L)
    expect_equal(nrow(elements(a)), 6L)
})

test_that("nElements works", {
    expect_equal(nrow(elements(a)), nElements(a))
})
test_that("elements<- works", {
    elements(a) <- cbind(elements(a), P = "b")
    expect_equal(ncol(elements(a)), 2L)
})

test_that("replace_elements", {
    TS <- tidySet(list(A = letters[1:5], B = letters[2:10]))
    TS2 <- replace_elements(TS, data.frame(elements = letters[1:11]))
    expect_s4_class(TS2, "TidySet")
    expect_equal(nrow(elements(TS2)), 11L)
    expect_length(name_elements(TS2), 11L)
    expect_equal(name_elements(TS2), letters[1:11])
})
