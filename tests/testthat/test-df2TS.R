test_that("df2TS works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
        elements = rep(letters[seq_len(6)], 2),
        fuzzy = runif(12)
    )
    a <- tidySet(relations)
    a <- mutate_element(a,
        type = c(rep("Gene", 4), rep("lncRNA", 2))
    )
    a <- mutate_set(a, Group = c("UFM", "UAB", "UPF", "MIT"))
    b <- select(a, -type)
    expect_equal(colnames(sets(a)), colnames(sets(b)))
    expect_equivalent(sort(colnames(relations(a))),
                      sort(colnames(relations(b))))
    df_a <- as.data.frame(a)
    d <- df2TS(a, df_a)
    expect_equal(as.data.frame(d), as.data.frame(a))

    expect_equal(relations(a), df_a[, c("sets", "elements", "fuzzy")])
})
