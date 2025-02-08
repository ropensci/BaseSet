test_that("element_size works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", "c"),
        elements = c(letters[seq_len(6)], letters[6]),
        fuzzy = runif(7),
        stringsAsFactors = FALSE
    )
    a <- tidySet(relations)
    df <- element_size(a)
    expect_equal(colnames(df), c("elements", "size", "probability"))
    expect_error(element_size(a, "z"))
    out <- element_size(a, "b")
    expect_error(set_size(a, c("a", "b")), NA)
    b <- activate(a, "elements")
    out2 <- size(b, "b")
    expect_equal(out, out2)
    expect_equal(nrow(out), 2L)
    expect_equal(out$size, c(0, 1))

    a1 <- add_elements(a, element = "g")
    expect_equal(element_size(a1, "g")$size, 0)
})

test_that("element_size and filter work well together", {
    set.seed(4567)
    relations <- data.frame(sets = c(rep("A", 5), "B", "C"),
                            elements = c(letters[seq_len(6)], letters[6]),
                            fuzzy = runif(7),
                            stringsAsFactors = FALSE)
    fuzzy_set <- tidySet(relations)
    easy <- element_size(fuzzy_set, "f")
    filtered <- fuzzy_set %>%
        filter(sets %in% c("B", "C")) %>%
        element_size(element = "f")
    expect_equal(dim(easy), dim(filtered))
})
