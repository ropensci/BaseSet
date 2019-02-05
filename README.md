
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
#>   elements sets      fuzzy
#> 1        a    A 0.40412957
#> 2        a    B 0.02451859
#> 3        b    A 0.47692173
#> 4        c    A 0.45645418
#> 5        d    A 0.62664432
#> 6        e    A 0.45369840
#> 7        f    B 0.11030636
```

``` r
b <- union(a, "A", "B", "C")
nSets(b)
#> [1] 1
b
#>   elements sets     fuzzy
#> 1        a    C 0.4041296
#> 2        b    C 0.4769217
#> 3        c    C 0.4564542
#> 4        d    C 0.6266443
#> 5        e    C 0.4536984
#> 6        f    C 0.1103064
d <- union(a, "A", "B", "C", keep = TRUE)
nSets(d)
#> [1] 3
d
#>    elements sets      fuzzy
#> 1         a    A 0.40412957
#> 2         a    B 0.02451859
#> 3         a    C 0.40412957
#> 4         b    C 0.47692173
#> 5         b    A 0.47692173
#> 6         c    A 0.45645418
#> 7         c    C 0.45645418
#> 8         d    C 0.62664432
#> 9         d    A 0.62664432
#> 10        e    A 0.45369840
#> 11        e    C 0.45369840
#> 12        f    B 0.11030636
#> 13        f    C 0.11030636
```
