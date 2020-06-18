context("operations")

relations <- data.frame(
    sets = c(rep("a", 5), "b", "c"),
    elements = c(letters[seq_len(6)], letters[6]),
    fuzzy = runif(7)
)
TS <- tidySet(relations)
test_that("check_fuzziness works", {
    expect_true(check_fuzziness(TS))
})

test_that("sets_for_elements works", {
    expect_true(is.character(sets_for_elements(TS, c("a", "b"))))
})
