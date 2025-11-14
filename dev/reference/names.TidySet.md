# Names of a TidySet

Retrieve the column names of a slots of a TidySet.

## Usage

``` r
# S3 method for class 'TidySet'
names(x)
```

## Arguments

- x:

  A TidySet object.

## Value

A vector with the names of the present columns of the sets, elements and
relations. If a slot is active it only returns the names of that slot.

## See also

[`dimnames()`](https://rdrr.io/r/base/dimnames.html)

## Examples

``` r
relations <- data.frame(
    sets = c(rep("a", 5), "b"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
TS <- tidySet(relations)
names(TS)
#> [1] "sets"     "elements" "fuzzy"   
names(activate(TS, "sets"))
#> [1] "sets"
```
