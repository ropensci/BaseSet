# Calculates the probability of a single length

Creates all the possibilities and then add them up. `union_probability`
Assumes independence between the probabilities to calculate the final
size.

## Usage

``` r
union_probability(p)

length_probability(p, size)
```

## Arguments

- p:

  Numeric vector of probabilities.

- size:

  Integer value of the size of the selected values.

## Value

A numeric value of the probability of the given size.

## See also

[`multiply_probabilities()`](https://docs.ropensci.org/BaseSet/dev/reference/multiply_probabilities.md)
and
[`length_set()`](https://docs.ropensci.org/BaseSet/dev/reference/length_set.md)

## Examples

``` r
length_probability(c(0.5, 0.75), 2)
#> [1] 0.375
length_probability(c(0.5, 0.75, 0.66), 1)
#> [1] 0.2525
length_probability(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23), 2)
#> [1] 0.3485187
union_probability(c(0.5, 0.1, 0.3))
#> [1] 0.685
```
