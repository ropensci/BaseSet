# Dimnames of a TidySet

Retrieve the column names of the slots of a TidySet.

## Usage

``` r
# S3 method for class 'TidySet'
dimnames(x)
```

## Arguments

- x:

  A TidySet object.

## Value

A list with the names of the columns of the sets, elements and
relations.

## See also

[`names()`](https://rdrr.io/r/base/names.html)

## Examples

``` r
relations <- data.frame(
    sets = c(rep("a", 5), "b"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
TS <- tidySet(relations)
dimnames(TS)
#> $sets
#> [1] "sets"
#> 
#> $elements
#> [1] "elements"
#> 
#> $relations
#> [1] "sets"     "elements" "fuzzy"   
#> 
```
