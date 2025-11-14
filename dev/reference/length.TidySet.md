# Length of the TidySet

Returns the number of sets in the object.

## Usage

``` r
# S3 method for class 'TidySet'
length(x)
```

## Arguments

- x:

  A TidySet object.

  No replacement function is available, either delete sets or add them.

## Value

A numeric value.

## See also

[`dim()`](https://rdrr.io/r/base/dim.html),
[`ncol()`](https://rdrr.io/r/base/nrow.html) and
[`nrow()`](https://rdrr.io/r/base/nrow.html). Also look at
[`lengths()`](https://rdrr.io/r/base/lengths.html) for the number of
relations of sets.

## Examples

``` r
TS <- tidySet(list(A = letters[1:5], B = letters[6]))
length(TS)
#> [1] 2
```
