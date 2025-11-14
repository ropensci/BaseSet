# Probability of a vector of probabilities

Calculates the probability that all probabilities happened
simultaneously. `independent_probabilities()` just multiply the
probabilities of the index passed.

## Usage

``` r
multiply_probabilities(p, i)

independent_probabilities(p, i)
```

## Arguments

- p:

  Numeric vector of probabilities.

- i:

  Numeric integer index of the complementary probability.

## Value

A numeric value of the probability.

## See also

[`length_probability()`](https://docs.ropensci.org/BaseSet/dev/reference/length_probability.md)

## Examples

``` r
multiply_probabilities(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23), c(1, 3))
#> [1] 0.03898125
independent_probabilities(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23), c(1, 3))
#> [1] 0.15
```
