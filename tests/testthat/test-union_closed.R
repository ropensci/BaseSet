test_that("union_closed works", {
    l <- list(A = "1",
         B = c("1", "2"),
         C = c("2", "3", "4"),
         D = c("1", "2", "3", "4")
    )
    TS <- tidySet(l)
    expect_true(union_closed(TS))
    expect_false(union_closed(TS, sets = c("A", "C")))
    expect_false(union_closed(TS, sets = c("A", "B", "C")))
    expect_true(union_closed(TS, sets = c("A", "B", "C", "D")))
})
