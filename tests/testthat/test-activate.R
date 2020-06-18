context("test-activate")

test_that("activate works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
        elements = rep(letters[seq_len(6)], 2),
        fuzzy = runif(12)
    )
    a <- tidySet(relations)
    elements(a) <- cbind(elements(a),
        type = c(rep("Gene", 4), rep("lncRNA", 2))
    )
    expect_error(a <- activate(a, "elements"), NA)
    expect_equal(active(a), "elements")
    expect_error(filter(a, type == "Gene"), NA)
    a <- deactivate(a)
    expect_true(is.null(active(a)))
})
