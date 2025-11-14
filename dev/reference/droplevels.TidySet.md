# Drop unused elements and sets

Drop elements and sets without any relation.

## Usage

``` r
# S3 method for class 'TidySet'
droplevels(x, elements = TRUE, sets = TRUE, relations = TRUE, ...)
```

## Arguments

- x:

  A TidySet object.

- elements:

  Logical value: Should elements be dropped?

- sets:

  Logical value: Should sets be dropped?

- relations:

  Logical value: Should sets be dropped?

- ...:

  Other arguments, currently ignored.

## Value

A TidySet object.

## Examples

``` r
rel <- list(A = letters[1:3], B = character())
TS <- tidySet(rel)
TS
#>   elements sets fuzzy
#> 1        a    A     1
#> 2        b    A     1
#> 3        c    A     1
sets(TS)
#>   sets
#> 1    A
#> 2    B
TS2 <- droplevels(TS)
TS2
#>   elements sets fuzzy
#> 1        a    A     1
#> 2        b    A     1
#> 3        c    A     1
sets(TS2)
#>   sets
#> 1    A
```
