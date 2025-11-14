# Size

Calculate the size of the elements or sets, using the fuzzy values as
probabilities. First it must have active either sets or elements.

## Usage

``` r
size(object, ...)
```

## Arguments

- object:

  A TidySet object.

- ...:

  Character vector with the name of elements or sets you want to
  calculate the size of.

## Value

The size of the elements or sets. If there is no active slot or it is
the relations slot returns the TidySet object with a warning.

## See also

A related concept
[`cardinality()`](https://docs.ropensci.org/BaseSet/dev/reference/cardinality.md).
It is calculated using
[`length_set()`](https://docs.ropensci.org/BaseSet/dev/reference/length_set.md).

## Examples

``` r
rel <- data.frame(
    sets = c(rep("A", 5), "B", "C"),
    elements = c(letters[seq_len(6)], letters[6])
)
TS <- tidySet(rel)
TS <- activate(TS, "elements")
size(TS)
#>   elements size probability
#> 1        a    1           1
#> 2        b    1           1
#> 3        c    1           1
#> 4        d    1           1
#> 5        e    1           1
#> 6        f    2           1
TS <- activate(TS, "sets")
size(TS)
#>   sets size probability
#> 1    A    5           1
#> 2    B    1           1
#> 3    C    1           1
# With fuzzy sets
relations <- data.frame(
    sets = c(rep("A", 5), "B", "C"),
    elements = c(letters[seq_len(6)], letters[6]),
    fuzzy = runif(7)
)
TS <- tidySet(relations)
TS <- activate(TS, "elements")
size(TS)
#>    elements size probability
#> 1         a    0 0.023124683
#> 2         a    1 0.976875317
#> 3         b    0 0.965100356
#> 4         b    1 0.034899644
#> 5         c    0 0.561242731
#> 6         c    1 0.438757269
#> 7         d    0 0.355530239
#> 8         d    1 0.644469761
#> 9         e    0 0.005167595
#> 10        e    1 0.994832405
#> 11        f    0 0.098769476
#> 12        f    1 0.631916462
#> 13        f    2 0.269314062
TS <- activate(TS, "sets")
size(TS)
#>    sets size  probability
#> 1     A    0 2.301251e-05
#> 2     A    1 5.462896e-03
#> 3     A    2 2.013959e-01
#> 4     A    3 5.004835e-01
#> 5     A    4 2.830443e-01
#> 6     A    5 9.590404e-03
#> 7     B    0 6.853374e-01
#> 8     B    1 3.146626e-01
#> 9     C    0 1.441180e-01
#> 10    C    1 8.558820e-01
```
