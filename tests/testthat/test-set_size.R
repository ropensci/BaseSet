context("test-set_size")

test_that("set_size works", {
  x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
  a <- tidySet(x)
  out <- set_size(a, "a")
  expect_equal(nrow(out), 1L)
  expect_error(set_size(a, "z"), "valid set")

  a1 <- add_sets(a, set = "c")
  expect_equal(set_size(a1, "c")$size, 0)
})

test_that("set_size works with fuzzy sets", {
  x <- list("a" = c("A" = 0.1, "B" = 0.5),
            "b" = c("A" = 0.2, "B" = 1))
  a <- tidySet(x)
  out <- set_size(a, "a")
  expect_equal(nrow(out), 3L)
  out <- set_size(a)
  expect_equal(max(out$size), length(name_elements(a)))
  expect_equal(out$probability,
               c(0.9*0.5,
                 0.5*0.1 + 0.5*0.9,
                 0.5*0.1,
                 1*0.8 + 0*0.2,
                 1*0.2))
  checking <- rowsum(out$probability, out$set, reorder = FALSE)
  expect_true(all(checking[, 1] == 1))
})

