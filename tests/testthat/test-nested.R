context("nested")

test_that("nested works", {
    relations <- list(A = letters[1:3], B = c(letters[4:5], "A"))
    TS <- tidySet(relations)
    expect_true(is_nested(TS))
    TS2 <- remove_element(TS, "A")
    expect_false(is_nested(TS2))
})
