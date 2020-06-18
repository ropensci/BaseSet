context("test-power_set")

relations <- data.frame(
    sets = c(rep("a", 5), "b"),
    elements = letters[seq_len(6)]
)
TS <- tidySet(relations)
test_that("works without keep", {
    out <- power_set(TS, "a", "power_set", keep = FALSE)
    expect_equal(nElements(out), nElements(TS))
    expect_equal(nSets(out), 56)
})

test_that("works with keep", {
    out <- power_set(TS, "a", "power_set", keep = TRUE)
    expect_equal(nElements(out), nElements(TS))
    expect_equal(nSets(out), 58)
})
