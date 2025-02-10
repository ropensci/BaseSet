test_that("as.data.frame works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
        elements = rep(letters[seq_len(6)], 2),
        fuzzy = runif(12)
    )
    a <- tidySet(relations)
    b <- as.data.frame(a)
    expect_s3_class(b, "data.frame")
})

test_that("as.data.frame adds the fuzzy column", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
        elements = rep(letters[seq_len(6)], 2)
    )
    a <- tidySet(relations)
    b <- as.data.frame(a)
    expect_s3_class(b, "data.frame")
    expect_setequal(colnames(b), c("sets", "elements", "fuzzy"))
})
