# Combine Values into a Vector or List

This method combines TidySets. It only works if the first element is a
TidySet.

## Usage

``` r
# S4 method for class 'TidySet'
c(x, ...)
```

## Arguments

- x:

  A TidySet object.

- ...:

  Objects to be concatenated. All NULL entries are dropped.

## Examples

``` r
TS <- tidySet(list(A = letters[1:5], B = letters[6]))
TS2 <- c(TS, data.frame(sets = "C", elements = "gg"))
```
