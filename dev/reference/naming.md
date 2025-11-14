# Name an operation

Helps setting up the name of an operation.

## Usage

``` r
naming(
  start = NULL,
  sets1,
  middle = NULL,
  sets2 = NULL,
  collapse_symbol = "union"
)
```

## Arguments

- start, middle:

  Character used as a start symbol or to divide `sets1` and `sets2`.

- sets1, sets2:

  Character of sets

- collapse_symbol:

  Name of the symbol that joins the sets on `sets1` and `sets2`.

## Value

A character vector combining the sets

## See also

[`set_symbols()`](https://docs.ropensci.org/BaseSet/dev/reference/set_symbols.md)

## Examples

``` r
naming(sets1 = c("a", "b"))
#> [1] "a∪b"
naming(sets1 = "a", middle = "union", sets2 = "b")
#> [1] "a∪b"
naming(sets1 = "a", middle = "intersection", sets2 = c("b", "c"))
#> [1] "a∩(b∪c)"
naming(sets1 = "a", middle = "intersection", sets2 = c("b", "c"))
#> [1] "a∩(b∪c)"
naming(
    start = "complement", sets1 = "a", middle = "intersection",
    sets2 = c("b", "c"), collapse_symbol = "intersection"
)
#> [1] "∁a∩b∩c"
```
