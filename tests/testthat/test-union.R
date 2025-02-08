test_that("union works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", "c"),
        elements = letters[seq_len(7)]
    )
    a <- tidySet(relations)
    b <- union(a, c("c", "b"), "d")
    expect_s4_class(b, "TidySet")
    expect_equal(name_sets(b), "d")
    expect_equal(name_elements(b), c("f", "g"))

    # Simple case with duplicate relations
    relations <- data.frame(
        sets = c(rep("a", 5), "b", "c"),
        elements = c(letters[seq_len(6)], letters[6])
    )
    a <- tidySet(relations)
    b <- union(a, c("c", "b"), "d")
    expect_s4_class(b, "TidySet")
    expect_equal(name_sets(b), "d")
    expect_equal(name_elements(b), "f")
})

test_that("union works fuzzy", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", "c"),
        elements = c(letters[seq_len(6)], letters[6]),
        fuzzy = runif(7)
    )
    a <- tidySet(relations)
    b <- union(a, c("c", "b"), "d")
    expect_s4_class(b, "TidySet")
    expect_equal(name_sets(b), "d")
    expect_equal(name_elements(b), "f")
    expect_equal(b@relations$fuzzy, max(a@relations$fuzzy[6:7]))

    d <- union(a, c("a", "c"), "d")
    expect_s4_class(d, "TidySet")
    expect_equal(name_sets(d), "d")
    expect_equal(name_elements(d), letters[1:6])
})

test_that("union keep", {
    relations <- data.frame(
        sets = c(rep("A", 4), "B", "C", "D"),
        elements = letters[seq_len(7)]
    )
    a <- tidySet(relations)
    b <- union(a, c("A", "C"), "E", keep = TRUE)
    expect_s4_class(b, "TidySet")
    expect_length(name_sets(b), 5L)
    expect_equal(nSets(b), nSets(a) + 1)
})

test_that("union works fuzzy keep", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b", "c"),
        elements = c(letters[seq_len(6)], letters[6]),
        fuzzy = runif(7)
    )
    a <- tidySet(relations)
    b <- union(a, c("c", "b"), "d", keep = TRUE)
    expect_s4_class(b, "TidySet")
    expect_equal(nSets(b), nSets(a) + 1)
    expect_equal(b@relations$fuzzy[8], max(a@relations$fuzzy[6:7]))

    d <- union(a, c("a", "c"), "d", keep = TRUE)
    expect_s4_class(d, "TidySet")
    expect_equal(nSets(d), nSets(a) + 1)
    expect_equal(name_sets(d), name_sets(b))
    expect_equal(name_elements(d), letters[1:6])
})

test_that("check coherence", {
    relations <- data.frame(
        sets = c("A", "A", "A", "A", "B", "C", "D"),
        elements = c("a", "b", "c", "d", "e", "f", "g")
    )
    a <- tidySet(relations = relations)
    b <- union(a, c("A", "B"), "AuB")
    d <- union(a, c("A", "B"), "AuB", keep = TRUE)
    expect_equal(nSets(b) + 4, nSets(d))
})

test_that("fapply works in order", {
    fuzzy_set <- new("TidySet",
        elements = structure(
            list(elements = structure(1:6,
                .Label = c("a", "b", "c", "d", "e", "f"),
                class = "factor"
            )),
            class = "data.frame", row.names = c(NA, -6L)
        ),
        sets = structure(list(sets = structure(1:2,
            .Label = c("A", "B"),
            class = "factor"
        )),
        class = "data.frame",
        row.names = c(NA, -2L)
        ),
        relations = structure(list(
            sets = structure(c(1L, 1L, 1L, 1L, 1L, 2L, 2L),
                .Label = c("A", "B"), class = "factor"
            ),
            elements = structure(c(1L, 2L, 3L, 4L, 5L, 1L, 6L),
                .Label = c("a", "b", "c", "d", "e", "f"),
                class = "factor"
            ),
            fuzzy = c(
                0.183724598027766, 0.45670090126805, 0.815207473235205,
                0.580061004729941, 0.572497315471992, 0.938118239864707,
                0.946015807567164
            )
        ),
        class = "data.frame", row.names = c(NA, -7L)
        )
    )
    df <- as.data.frame(union(fuzzy_set, c("A", "B"), "D", keep = TRUE))
    expect_equal(df$fuzzy[df$elements == "b" & df$sets == "A"],
                 df$fuzzy[df$elements == "b" & df$sets == "D"])
})


test_that("union pass other arguments to FUN",  {
    set.seed(98632187)
    relations <- data.frame(
        sets = c(rep("A", 5), rep("B", 5)),
        elements = c(letters[1:5], letters[2:6]),
        fuzzy = runif(10)
    )
    a <- tidySet(relations)
    q <- function(x, quantile) {quantile(x, probs = quantile)}
    r <- union(a, c("A", "B"), "C", FUN = q, quantile = 0.5)
    expect_equal(relations(r)$fuzzy[relations(r)$elements == "b"],
                 unname(q(relations$fuzzy[relations$elements == "b"], 0.5)))
})
