test_that("size works", {
    set.seed(163973)
    r <- data.frame(
        sets = c(rep("A", 5), "B", "C"),
        elements = c(letters[seq_len(6)], letters[6]),
        fuzzy = runif(7)
    )
    a <- tidySet(r)
    expect_warning(size(expect_s4_class(a, "TidySet")))
    a <- activate(a, "elements")
    size_e <- size(a)
    expect_length(size_e, 3)
    expect_equal(nrow(size_e), 13)
    a <- activate(a, "sets")
    size_s <- size(a)
    expect_length(size_s, 3)
    expect_equal(nrow(size_s), 10)
})
