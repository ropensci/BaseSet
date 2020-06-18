context("group_by")

test_that("group_by works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
        elements = rep(letters[seq_len(6)], 2),
        fuzzy = runif(12)
    )
    a <- tidySet(relations)
    elements(a) <- cbind(elements(a),
        type = c(rep("Gene", 4), rep("lncRNA", 2))
    )
    out <- group_by(a, elements)
    expect_s3_class(out, "grouped_df")
    b <- activate(a, "elements")
    out <- group_by(b, elements)
    expect_s3_class(out, "grouped_df")
})
