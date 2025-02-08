test_that("collapse_sets works", {
    expect_true(is.character(collapse_sets(c("a", "b"))))
})

test_that("naming works", {
    n1 <- naming(sets1 = c("a", "b"))
    n2 <- naming(sets1 = "a", sets2 = "b", middle = "union")
    expect_equal(n1, n2)
    expect_equal(n1, "a∪b")

    expect_error(
        naming(sets1 = "a", sets2 = "b"),
        "should be separated by a symbol"
    )

    n3 <- naming(sets1 = "a", sets2 = c("b", "c"), middle = "union")
    expect_equal(n3, "a∪b∪c")
    n4 <- naming(sets1 = "a", sets2 = c("b", "c"), middle = "inter")
    expect_equal(n4, "a∩(b∪c)")

    expect_error(naming(sets1 = "a", start = c("a", "b")))
    expect_error(naming(sets1 = "a", middle = c("a", "b")))
    expect_error(naming(sets1 = "a", collase_symbol = c("a", "b")))
})
