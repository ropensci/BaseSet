# The opposite of as.data.frame

Convert a data.frame to a TidySet by first using the relations. It
requires the original TidySet in order to convert it back to resemble
the position of the columns.

## Usage

``` r
df2TS(.data = NULL, df)
```

## Arguments

- .data:

  The original TidySet

- df:

  The flattened data.frame

## Value

A TidySet object

## See also

[`tidySet.data.frame()`](https://docs.ropensci.org/BaseSet/dev/reference/tidySet.md)
