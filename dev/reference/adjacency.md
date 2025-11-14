# Adjacency

Are two elements connected ?

## Usage

``` r
# S3 method for class 'TidySet'
adjacency(object)

adjacency_element(object)

adjacency_set(object)

# S3 method for class 'TidySet'
adjacency(object)
```

## Arguments

- object:

  A TidySet object

## Value

A square matrix, 1 if two nodes are connected, 0 otherwise.

## See also

[`incidence()`](https://docs.ropensci.org/BaseSet/dev/reference/incidence.md)

## Examples

``` r
x <- list("SET1" = letters[1:5], "SET2" = LETTERS[3:7])
a <- tidySet(x)
adjacency_element(a)
#>   a b c d e C D E F G
#> a 1 1 1 1 1 0 0 0 0 0
#> b 1 1 1 1 1 0 0 0 0 0
#> c 1 1 1 1 1 0 0 0 0 0
#> d 1 1 1 1 1 0 0 0 0 0
#> e 1 1 1 1 1 0 0 0 0 0
#> C 0 0 0 0 0 1 1 1 1 1
#> D 0 0 0 0 0 1 1 1 1 1
#> E 0 0 0 0 0 1 1 1 1 1
#> F 0 0 0 0 0 1 1 1 1 1
#> G 0 0 0 0 0 1 1 1 1 1
adjacency_set(a)
#>      SET1 SET2
#> SET1    1    0
#> SET2    0    1
```
