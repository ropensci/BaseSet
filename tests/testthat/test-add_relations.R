context("test-add_relations")

test_that("add_relations works", {
    relations <- data.frame(
        sets = c(rep("A", 5), "B", "B"),
        elements = c("a", "b", "c", "d", "e", "a", "f")
    )
    a <- tidySet(relations)
    b <- add_relations(a, elements = letters[7:15], sets = "DF")
    expect_s4_class(b, "TidySet")
    expect_equal(nSets(b), nSets(a) + 1)

    expect_error(add_relations(a,
        elements = letters[7:15],
        sets = c("ha", "he")
    ))

    elements(a) <- cbind(elements(a),
        Ha = c("bla", "ble", "bli", "blo", "blu", NA)
    )
    d <- add_relations(a, elements = letters[1:2], sets = "DF2")
    expect_equal(nSets(d), nSets(a) + 1)
    b <- add_relations(a,
        elements = letters[1:2],
        sets = c("DF2", "df2")
    )
})

test_that("add_relations fuzzy works", {
    relations <- data.frame(
        sets = c(rep("A", 5), "B", "B"),
        elements = c("a", "b", "c", "d", "e", "a", "f")
    )
    a <- tidySet(relations)
    b <- add_relations(a, elements = letters[7:15], sets = "ha", fuzzy = 0.5)
    expect_s4_class(b, "TidySet")
    expect_equal(nSets(b), nSets(a) + 1)

    elements(a) <- cbind(elements(a),
        Ha = c("bla", "ble", "bli", "blo", "blu", NA)
    )
    d <- add_relations(a, elements = letters[7:15], sets = "ha", fuzzy = 0.5)
    expect_s4_class(d, "TidySet")
    expect_equal(nSets(d), nSets(a) + 1)
    expect_error(add_relations(a,
        elements = letters[7:15], sets = "ha",
        fuzzy = -1
    ))
    expect_error(add_relations(a,
        elements = letters[7:15], sets = c("ha", "he"),
        fuzzy = 1
    ))
})
