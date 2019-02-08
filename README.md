
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
#> 1        a    A 0.9119767
#> 2        a    B 0.5891482
#> 3        b    A 0.6323319
#> 4        c    A 0.3443222
#> 5        d    A 0.1266282
#> 6        e    A 0.7497792
#> 7        f    B 0.6135288
```

Perform typical operations like union, intersection:

``` r
b <- union(a, "A", "B", "AuB")
nSets(b)
#> [1] 1
b
#>   elements sets     fuzzy
#> 1        a  AuB 0.9119767
#> 2        b  AuB 0.6323319
#> 3        c  AuB 0.3443222
#> 4        d  AuB 0.1266282
#> 5        e  AuB 0.7497792
#> 6        f  AuB 0.6135288
d <- intersection(a, "A", "B", "D")
nSets(d)
#> [1] 1
d
#>   elements sets     fuzzy
#> 1        a    D 0.5891482
#> 2        b    D 0.6323319
#> 3        c    D 0.3443222
#> 4        d    D 0.1266282
#> 5        e    D 0.7497792
#> 6        f    D 0.6135288
```

And compute size of sets among other things:

``` r
set_size(a)
#>   set size probability
#> 1   A    0 0.004637313
#> 2   A    1 0.184996371
#> 3   A    2 0.420788192
#> 4   A    3 0.297701998
#> 5   A    4 0.073024123
#> 6   A    5 0.018852004
#> 7   B    0 0.158782388
#> 8   B    1 0.479758221
#> 9   B    2 0.361459391
```
