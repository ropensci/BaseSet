
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis build status](https://travis-ci.org/llrs/BaseSet.svg?branch=master)](https://travis-ci.org/llrs/BaseSet) [![Coverage status](https://codecov.io/gh/llrs/BaseSet/branch/master/graph/badge.svg)](https://codecov.io/github/llrs/BaseSet?branch=master) [![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

BaseSet
=======

The goal of BaseSet is to facilitate working with sets

Installation
------------

You can install the released version of BaseSet from [Github](https://github.com/llrs/BaseSet) with:

``` r
remotes::install_github("llrs/BaseSet")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
library("BaseSet")
set(c("a", "b", "c"))
#> Fuzzy set with 3 elements.
set(c("a", "b", "a"))
#> Fuzzy set with 3 elements.
```

``` r
a <- set(c("a" = 0.5, "b" = 0.2, "c" = 0.3, "d" = 0.5))
b <- set(letters[1:4])
a
#> Fuzzy set with 4 elements.
b
#> Fuzzy set with 4 elements.
length(a)
#> [1] 4
length(b)
#> [1] 4
set_size(a)
#>     1     2     3     4 
#> 0.125 0.345 0.375 0.140
set_size(b)
#> [1] 4
```
