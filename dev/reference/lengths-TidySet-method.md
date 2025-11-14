# Lengths of the TidySet

Returns the number of relations of each set in the object.

## Usage

``` r
# S4 method for class 'TidySet'
lengths(x, use.names = TRUE)
```

## Arguments

- x:

  A TidySet object.

- use.names:

  A logical value whether to inherit names or not.

## Value

A vector with the number of different relations for each set.

## See also

[`length()`](https://rdrr.io/r/base/length.html), Use
[`set_size()`](https://docs.ropensci.org/BaseSet/dev/reference/set_size.md)
if you are using fuzzy sets.

## Examples

``` r
TS <- tidySet(list(A = letters[1:5], B = letters[6]))
lengths(TS)
#> A B 
#> 5 1 
```
