# Cardinality or membership of sets

Calculates the membership of sets according to the logic defined in FUN.

## Usage

``` r
cardinality(object, sets = NULL, ...)

# S4 method for class 'TidySet'
cardinality(object, sets, FUN = "sum", ...)
```

## Arguments

- object:

  A TidySet object.

- sets:

  Character vector with the name of the sets.

- ...:

  Other arguments passed to `FUN`.

- FUN:

  Function that returns a single numeric value given a vector of fuzzy
  values.

## Methods (by class)

- `cardinality(TidySet)`: Cardinality of sets

## See also

[`size()`](https://docs.ropensci.org/BaseSet/dev/reference/size.md)

## Examples

``` r
rel <- list(A = letters[1:3], B = letters[1:2])
TS <- tidySet(rel)
cardinality(TS, "A")
#>   sets cardinality
#> 1    A           3
```
