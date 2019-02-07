
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
#> 1        a    A 0.4544156
#> 2        a    B 0.8551648
#> 3        b    A 0.1158045
#> 4        c    A 0.9864490
#> 5        d    A 0.2647327
#> 6        e    A 0.6119693
#> 7        f    B 0.9619136
```

``` r
b <- union(a, "A", "B", "C")
nSets(b)
#> [1] 1
b
#>   elements sets     fuzzy
#> 1        a    C 0.8551648
#> 2        b    C 0.1158045
#> 3        c    C 0.9864490
#> 4        d    C 0.2647327
#> 5        e    C 0.6119693
#> 6        f    C 0.9619136
d <- union(a, "A", "B", "C", keep = TRUE)
nSets(d)
#> [1] 3
d
#>    elements sets     fuzzy
#> 1         a    A 0.4544156
#> 2         a    B 0.8551648
#> 3         a    C 0.8551648
#> 4         b    C 0.1158045
#> 5         b    A 0.1158045
#> 6         c    A 0.9864490
#> 7         c    C 0.9864490
#> 8         d    C 0.2647327
#> 9         d    A 0.2647327
#> 10        e    A 0.6119693
#> 11        e    C 0.6119693
#> 12        f    B 0.9619136
#> 13        f    C 0.9619136
```
