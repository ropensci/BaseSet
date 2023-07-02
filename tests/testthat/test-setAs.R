context("test-setAs")

relations <- data.frame(
    sets = c(rep("a", 5), "b"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
a <- tidySet(relations = relations)

test_that("setAs works", {
    b <- as(a, "list")

    expect_true(is.list(b))
    expect_true(!is.null(names(b)))
    expect_true(is.character(names(b[[1]])))
    expect_true(is.numeric(b[[1]]))
})

test_that("TidySet with two relations to list", {
    r <- data.frame(sets = c("A", "A", "A", "B", "C"),
                 elements = c(letters[1:3], letters[2:3]),
                 fuzzy = runif(5),
                 info = rep(c("important", "very important"), 5))
    TS <- tidySet(r)
    expect_warning(l <- as.list(TS), "the coercion.")
    expect_length(l, 3L)
})

test_that("as.list works", {
    b <- as.list(a)

    expect_true(is.list(b))
    expect_true(!is.null(names(b)))
    expect_true(is.character(names(b[[1]])))
    expect_true(is.numeric(b[[1]]))

    expect_true(is.list(lapply(a, identity)))
})
