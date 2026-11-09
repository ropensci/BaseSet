# Union closed sets

Tests if a given object is union-closed.

## Usage

``` r
union_closed(object, ...)

# S3 method for class 'TidySet'
union_closed(object, sets = NULL, ...)
```

## Arguments

- object:

  A TidySet object.

- ...:

  Other named arguments passed to `FUN`.

- sets:

  The name of the sets to be used.

## Value

A logical value: `TRUE` if the combinations of sets produce already
existing sets, `FALSE` otherwise.

## Examples

``` r
l <- list(A = "1",
     B = c("1", "2"),
     C = c("2", "3", "4"),
     D = c("1", "2", "3", "4")
)
TS <- tidySet(l)
union_closed(TS)
#> [1] TRUE
union_closed(TS, sets = c("A", "B", "C"))
#> [1] FALSE
union_closed(TS, sets = c("A", "B", "C", "D"))
#> [1] TRUE
```
