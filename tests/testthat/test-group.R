context("test-group")

test_that("group works", {
    r <- data.frame(
        sets = c(rep("A", 5), "B"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = r)
    b <- group(a, "C", c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE))
    expect_equal(nSets(b), nSets(a) + 1)
    expect_equal(name_sets(b), LETTERS[1:3])
})

test_that("group creates empty sets", {
    r <- data.frame(
        sets = c(rep("A", 5), "B"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = r)
    b <- group(a, "C", rep(FALSE, 6))
    expect_equal(nSets(b), nSets(a) + 1)
    expect_equal(name_sets(b), LETTERS[1:3])
})
