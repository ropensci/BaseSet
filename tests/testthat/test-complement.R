test_that("complement set works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = relations)
    b <- complement_set(a, "b", "b_set")
    expect_equal(nSets(b), 3L)
    expect_equal(nElements(b), 6L)
})

test_that("complement set works for several sets", {
    relations <- data.frame(
        sets = c(rep("A", 5), "B", "C"),
        elements = c(letters[seq_len(6)], letters[6]),
        fuzzy = runif(7)
    )
    fuzzy_set <- tidySet(relations)
    b <- complement_set(fuzzy_set, c("A", "C"))

    expect_equal(nSets(b), 4L)
    expect_equal(nElements(b), 6L)
    expect_equal(nRelations(b), 13L)
})

test_that("complement element works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = relations)
    b <- complement_element(a, "b", "b_set", keep = FALSE)
    expect_equal(nSets(b), 1L)
    expect_equal(nElements(b), 1L)
    expect_equal(nRelations(b), 1L)
    expect_equal(relations(b)$fuzzy, 1 - relations[2, "fuzzy"])
})

test_that("complement with custom function", {
    set.seed(927)
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = relations)
    b <- complement_element(a, "b", "b_set", FUN = function(x){x-0.2},
                            keep = FALSE)
    expect_equal(nSets(b), 1L)
    expect_equal(nElements(b), 1L)
    expect_equal(nRelations(b), 1L)
    expect_equal(relations(b)$fuzzy, relations[2, "fuzzy"] - 0.2)
})

test_that("complement element works without name", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = relations)
    b <- complement_element(a, "b", keep = FALSE)
    expect_equal(nSets(b), 1L)
    expect_equal(nElements(b), 1L)
    expect_equal(nRelations(b), 1L)
    expect_equal(relations(b)$fuzzy, 1 - relations[2, "fuzzy"])
})

# Not sure about this behavior
test_that("complement elements works for several elements", {
    relations <- data.frame(
        sets = c(rep("A", 5), "B", "C"),
        elements = c(letters[seq_len(6)], letters[6]),
        fuzzy = runif(7)
    )
    fuzzy_set <- tidySet(relations)
    b <- complement_element(fuzzy_set, c("a", "b"), "aUb")
    expect_equal(nSets(b), 4L)
    expect_equal(nElements(b), 6L)
    expect_equal(nRelations(b), 9L)
})

test_that("activate for complement", {
    relations <- data.frame(
        sets = c("a", "a", "b", "b", "c", "c"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations)
    ae <- activate(a, "elements")
    expect_equal(nSets(complement(ae, "a")), 4L)
    expect_equal(nSets(complement(ae, "a", "C_a", keep = FALSE)), 1L)
    as <- activate(a, "set")
    expect_equal(nSets(complement(as, "a")), 4L)
    expect_equal(nSets(complement(as, "a", keep = FALSE)), 1L)
})
