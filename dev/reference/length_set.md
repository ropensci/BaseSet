# Calculates the probability

Given several probabilities it looks for how probable is to have a
vector of each length

## Usage

``` r
length_set(probability)
```

## Arguments

- probability:

  A numeric vector of probabilities.

## Value

A vector with the probability of each set.

## See also

[`length_probability()`](https://docs.ropensci.org/BaseSet/dev/reference/length_probability.md)
to calculate the probability of a specific length.

## Examples

``` r
length_set(c(0.5, 0.1, 0.3, 0.5, 0.25, 0.23))
#>          0          1          2          3          4          5          6 
#> 0.09095625 0.28848750 0.34851875 0.20302500 0.06009375 0.00848750 0.00043125 
```
