context("test-mutate")

relations <- data.frame(
    sets = c(rep("a", 5), "b"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
a <- tidySet(relations = relations)

test_that("mutate_set works", {
    b <- mutate_set(a, Type = ifelse(sets == "b", "B", "D"))
    expect_equal(ncol(sets(b)), ncol(sets(a)) + 1)
    expect_equal(nSets(b), 2L)
})

test_that("mutate_element works", {
    b <- mutate_element(a, Type = ifelse(elements == "b", "B", "D"))
    expect_equal(ncol(elements(b)), ncol(elements(a)) + 1)
    expect_equal(nElements(b), 6L)
})

test_that("mutate_relation works", {
    b <- mutate_relation(a, Type = ifelse(elements == "b", "B", "D"))
    expect_equal(ncol(relations(b)), ncol(relations(a)) + 1)
    expect_equal(nRelations(b), 6L)
    expect_error(mutate_relation(a, fuzzy = fuzzy * 2), "is restricted")
})

test_that("mutate works", {
    a <- activate(a, "relations")
    b <- mutate(a, Type = ifelse(elements == "b", "B", "D"))
    expect_equal(ncol(relations(b)), ncol(relations(a)) + 1)
    expect_equal(nRelations(b), 6L)
    b <- deactivate(b)
    d <- mutate(b, Type2 = ifelse(elements == "b", "B2", "D2"))
    expect_length(colnames(relations(d)), 5L)

    a_df <- as.data.frame(a)
    a <- deactivate(a)
    expect_error(
        mutate(a, elements = ifelse(elements == "b", "B", "D")),
        "must have a single fuzzy value"
    )
    b <- mutate(a, sets = ifelse(sets == "a", "A", "B"))
    b_df <- as.data.frame(b)
    expect_equal(name_sets(b), c("A", "B"))
    # Check by fuzzy number
    expect_equal(
        b_df$fuzzy[b_df$sets == "B"],
        a_df$fuzzy[a_df$sets == "b"]
    )
})

test_that("mutate allows changing the name of elements", {
    a_df <- as.data.frame(a)
    b <- mutate(a, sets = ifelse(sets == "a", "A", "B"))
    b_df <- as.data.frame(b)
    expect_equal(name_sets(b), c("A", "B"))
    # Check by fuzzy number
    expect_equal(
        b_df$fuzzy[b_df$sets == "B"],
        a_df$fuzzy[a_df$sets == "b"]
    )
})

test_that("mutate allows changing the name of sets", {
    a_df <- as.data.frame(a)
    b <- mutate(a, sets = ifelse(sets == "b", "B", "D"))
    expect_true(all(name_sets(b) %in% c("B", "D")))
    b_df <- as.data.frame(b)
    expect_equal(
        a_df$fuzzy[a_df$sets == "b"],
        b_df$fuzzy[b_df$sets == "B"]
    )
})

test_that("mutate sets works", {
    b <- mutate_set(a, sets = paste0(sets, "2"))
    expect_equal(name_sets(b), c("a2", "b2"))
})
