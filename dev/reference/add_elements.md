# Add elements to a TidySet

Functions to add elements. If the elements are new they are added,
otherwise they are omitted.

## Usage

``` r
add_elements(object, elements, ...)
```

## Arguments

- object:

  A
  [`TidySet`](https://docs.ropensci.org/BaseSet/dev/reference/TidySet-class.md)
  object

- elements:

  A character vector of the elements.

- ...:

  Placeholder for other arguments that could be passed to the method.
  Currently not used.

## Value

A
[`TidySet`](https://docs.ropensci.org/BaseSet/dev/reference/TidySet-class.md)
object with the new elements.

## Note

`add_element` doesn't set up any other information about the elements.
Remember to add/modify them if needed with
[`mutate`](https://dplyr.tidyverse.org/reference/mutate.html) or
[`mutate_element`](https://docs.ropensci.org/BaseSet/dev/reference/mutate_.md)

## See also

Other add\_\*:
[`add_relations()`](https://docs.ropensci.org/BaseSet/dev/reference/add_relations.md),
[`add_sets()`](https://docs.ropensci.org/BaseSet/dev/reference/add_sets.md)

## Examples

``` r
x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
a <- tidySet(x)
b <- add_elements(a, "fg")
elements(b)
#>    elements
#> 1         a
#> 2         b
#> 3         c
#> 4         d
#> 5         e
#> 6         C
#> 7         D
#> 8         E
#> 9         F
#> 10        G
#> 11       fg
```
