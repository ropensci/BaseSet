# Independence of the sets

Checks if the elements of the sets are present in more than one set.

## Usage

``` r
independent(object, sets)
```

## Arguments

- object:

  A
  [`TidySet`](https://docs.ropensci.org/BaseSet/dev/reference/TidySet-class.md)
  object.

- sets:

  A character vector with the names of the sets to analyze.

## Value

A logical value indicating if the sets are independent (TRUE) or not.

## Examples

``` r
x <- list("A" = letters[1:5], "B" = letters[3:7], "C" = letters[6:10])
TS <- tidySet(x)
independent(TS)
#> [1] FALSE
independent(TS, c("A", "B"))
#> [1] FALSE
independent(TS, c("A", "C"))
#> [1] TRUE
independent(TS, c("B", "C"))
#> [1] FALSE
```
