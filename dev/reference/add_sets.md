# Add sets to a TidySet

Functions to add sets. If the sets are new they are added, otherwise
they are omitted.

## Usage

``` r
add_sets(object, sets, ...)
```

## Arguments

- object:

  A
  [`TidySet`](https://docs.ropensci.org/BaseSet/dev/reference/TidySet-class.md)
  object

- sets:

  A character vector of sets to be added.

- ...:

  Placeholder for other arguments that could be passed to the method.
  Currently not used.

## Value

A
[`TidySet`](https://docs.ropensci.org/BaseSet/dev/reference/TidySet-class.md)
object with the new sets.

## Note

`add_sets` doesn't set up any other information about the sets. Remember
to add/modify them if needed with
[`mutate`](https://dplyr.tidyverse.org/reference/mutate.html) or
[`mutate_set`](https://docs.ropensci.org/BaseSet/dev/reference/mutate_.md)

## See also

Other add\_\*:
[`add_elements()`](https://docs.ropensci.org/BaseSet/dev/reference/add_elements.md),
[`add_relations()`](https://docs.ropensci.org/BaseSet/dev/reference/add_relations.md)

## Examples

``` r
x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
a <- tidySet(x)
b <- add_sets(a, "fg")
sets(b)
#>   sets
#> 1    a
#> 2    b
#> 3   fg
```
