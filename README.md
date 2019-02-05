
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

Examples
--------

To work with sets we need to have the relations between the elements and the sets:

``` r
relations <- data.frame(sets = c(rep("A", 5), "B", "B"), 
                        elements = c("a", "b", "c", "d", "e", "a", "f"),
                        fuzzy = runif(7))
a <- tidySet(relations = relations)
nSets(a)
#> [1] 2
a
#>   elements sets     fuzzy
#> 1        a    A 0.9795321
#> 2        a    B 0.9226033
#> 3        b    A 0.6597881
#> 4        c    A 0.1205940
#> 5        d    A 0.9194211
#> 6        e    A 0.9135108
#> 7        f    B 0.2401249
```

``` r
b <- union(a, "A", "B", "C")
nSets(b)
#> [1] 1
```
