test_that("cartesian works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)]
    )
    TS <- tidySet(relations)
    out <- cartesian(TS, "a", "b")
    expect_s4_class(out, "TidySet")
    expect_equal(nSets(out), 8)
    expect_equal(nSets(TS), 2)
    expect_equal(nElements(out), nElements(TS))
})
