test_that("name_sets works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = relations)
    out <- name_sets(a)
    expect_length(out, 2L)
    expect_equal(out, c("a", "b"))
})

test_that("name_sets<- works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = relations)
    name_sets(a) <- LETTERS[1:2]
    out <- name_sets(a)
    expect_equal(out, LETTERS[1:2])
    b <- add_column(a, "sets", data.frame(Ha = c("a", "b")))
    expect_error(name_sets(b) <- c("A2", "A2"), "Duplicated sets")
    expect_error(name_sets(b) <- "A2", "Less names")
    expect_error(name_sets(a) <- as.factor(letters[1:2]), NA)
})

test_that("name_elements works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = relations)
    out <- name_elements(a)
    expect_length(out, 6L)
    expect_equal(out, letters[1:6])
})

test_that("name_elements<- works", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = relations)
    expect_error(name_elements(a)[1:2] <- LETTERS[1:2], NA)
    name_elements(a) <- LETTERS[1:6]
    out <- name_elements(a)
    expect_length(out, 6L)
    expect_equal(out, LETTERS[1:6])

    b <- add_column(a, "elements", data.frame(Ha = paste0(letters[1:6], "2")))
    expect_error(name_elements(b) <- rep("A2", nElements(b)),
                 "Duplicated elements")
    expect_error(name_elements(b) <- "A2", "Less names")
})


test_that("names and dimnames work", {
    relations <- data.frame(
        sets = c(rep("a", 5), "b"),
        elements = letters[seq_len(6)],
        fuzzy = runif(6)
    )
    a <- tidySet(relations = relations)
    expect_length(names(a), 3L)
    expect_equal(names(a), c("sets", "elements", "fuzzy"))
    expect_length(dimnames(a), 3L)
    expect_equal(names(activate(a, "relations")), c("sets", "elements", "fuzzy"))
    expect_equal(names(activate(a, "sets")), c("sets"))
    expect_equal(names(activate(a, "elements")), c("elements"))
})
