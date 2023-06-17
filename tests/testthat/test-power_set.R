context("test-power_set")

test_that("works without keep", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)]
    )
    TS <- tidySet(relations)
    out <- power_set(TS, "a", "power_set", keep = FALSE)
    expect_equal(nElements(out), nElements(TS) - 1)
    r <- relations(out)
    expect_true(any(startsWith(r$sets, "power_set_1_1")))
    expect_false(any(startsWith(r$elements, "f")))

    expect_equal(nSets(out), 30)
    out2 <- power_set(TS, "a", keep = FALSE)
    expect_true(!any(startsWith(relations(out2)$sets, "P(b)")))
    out3 <- power_set(TS, "b", keep = FALSE)
    expect_equal(nSets(out3), 1)
    expect_equal(nSets(power_set(TS, "b")), nSets(TS) + 1)
})

test_that("works with keep", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)]
    )
    TS <- tidySet(relations)
    out <- power_set(TS, "a", "power_set", keep = TRUE)
    expect_equal(nElements(out), nElements(TS))
    expect_equal(nSets(out), 32)
})
