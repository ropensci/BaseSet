
test_that("test length", {
    TS <- tidySet(list(a = letters[1:5], b = letters[6]))
    expect_equal(length(TS), nSets(TS))
})

test_that("test lengths", {
    TS <- tidySet(list(A = letters[1:5], B = letters[6]))
    expect_equal(lengths(TS), c(A = 5, B = 1))
})


p <- c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23)
test_that("multiply_probabilities works", {
    out <- multiply_probabilities(p, c(1, 3)) # Select 1 and 3
    expect_length(out, 1L)
    # Note the diffference from 0.3 to 0.7 on the third element
    # (1- 0.5 remains 0.5)
    expect_equal(out, prod(c(0.5, 0.9, 0.3, 0.5, 0.75, 0.77)))

    out <- multiply_probabilities(p, NULL) # Do not select anyone
    expect_length(out, 1L)
    expect_equal(out, prod(p))

    out <- multiply_probabilities(p, seq_along(p)) # Select all of them
    expect_length(out, 1L)
    expect_equal(out, prod(p))
})

test_that("length_probability works", {
    out <- length_probability(p, 2)
    expect_length(out, 1L)
    expect_equal(out, 0.34851875)

    out <- length_probability(p, 0)
    expect_length(out, 1L)
    expect_equal(out, 0.00043125)

    out <- length_probability(c(1, 0.2), 1)
    expect_length(out, 1L)
    expect_equal(out, 0.8)

    out <- length_probability(c(
        a = 0, b = 0, c = 0, d = 0,
        e = 0, f = 0.0486625612247735
    ), 1)
    expect_equivalent(out, 0.04866256)
})

test_that("length_set works", {
    out <- length_set(p)
    expect_length(out, 7L)
    expect_equal(sum(out), 1L, tolerance = 0.0005)

    # Just one with P > 0
    p2 <- c(a = 0, b = 0, c = 0, d = 0, e = 0, f = 0.0486625612247735)
    o2 <- length_set(p2)
    expect_equivalent(o2["5"], 0L)
    expect_equivalent(o2["2"], 0L)
    expect_true(all(o2[-c(1, 2)] == 0L))
})

test_that("union_probabilities works", {
    # 3 probabilities
    out <- union_probability(p[1:3])
    manually <- sum(p[1:3]) - prod(p[c(1, 2)]) - prod(p[c(1, 3)]) -
        prod(p[c(2, 3)]) + prod(p[1:3])
    expect_equal(out, manually)

    # 4 probabilities
    out <- union_probability(p[1:4])
    manually <- sum(p[1:4]) - prod(p[c(1, 2)]) - prod(p[c(1, 3)]) -
        prod(p[c(1, 4)]) - prod(p[c(2, 3)]) - prod(p[c(2, 4)]) -
        prod(p[c(3, 4)]) + prod(p[c(1, 2, 3)]) + prod(p[c(1, 2, 4)]) +
        prod(p[c(1, 3, 4)]) + prod(p[c(2, 3, 4)]) - prod(p[1:4])
    expect_equal(out, manually)

})
