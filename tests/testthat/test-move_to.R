test_that("move_to works", {
    x <- list("a" = c("A" = 0.1, "B" = 0.5), "b" = c("A" = 0.2, "B" = 1))
    a <- tidySet(x)
    a <- mutate_element(a, b = runif(2))
    b <- move_to(a, from = "elements", to = "relations", "b")

    expect_equal(as.data.frame(a), as.data.frame(b))
    expect_equal(ncol(elements(a)), 2)
    expect_equal(ncol(relations(a)), 3)
    expect_equal(ncol(elements(b)), 1)
    expect_equal(ncol(relations(b)), 4)
})
