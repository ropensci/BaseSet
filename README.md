
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis build status](https://travis-ci.org/llrs/BaseSet.svg?branch=master)](https://travis-ci.org/llrs/BaseSet) [![Coverage status](https://codecov.io/gh/llrs/BaseSet/branch/master/graph/badge.svg)](https://codecov.io/github/llrs/BaseSet?branch=master) [![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

BaseSet
=======

The goal of BaseSet is to facilitate working with sets while using the dplyr verbs.

Installation
------------

You can install the latest version of BaseSet from [Github](https://github.com/llrs/BaseSet) with:

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
#>   elements sets       fuzzy
#> 1        a    A 0.434828949
#> 2        a    B 0.501966667
#> 3        b    A 0.980737684
#> 4        c    A 0.447322056
#> 5        d    A 0.835097668
#> 6        e    A 0.692957164
#> 7        f    B 0.002152968
```

Perform typical operations like union, intersection:

``` r
b <- union(a, c("A", "B"), "AuB", keep = TRUE)
nSets(b)
#> [1] 3
b
#>    elements sets       fuzzy
#> 1         a    A 0.434828949
#> 2         a    B 0.447322056
#> 3         a  AuB 0.835097668
#> 4         b  AuB 0.835097668
#> 5         b    A 0.501966667
#> 6         c    A 0.501966667
#> 7         c  AuB 0.692957164
#> 8         d  AuB 0.692957164
#> 9         d    A 0.980737684
#> 10        e    A 0.980737684
#> 11        e  AuB 0.002152968
#> 12        f    B 0.447322056
#> 13        f  AuB 0.002152968
d <- intersection(a, c("A", "B"), "D")
nSets(d)
#> [1] 1
d
#>   elements sets     fuzzy
#> 1        a    D 0.4348289
```

And compute size of sets among other things:

``` r
set_size(a)
#>   set size  probability
#> 1   A    0 0.0003046396
#> 2   A    1 0.3527531823
#> 3   A    2 0.3730941124
#> 4   A    3 0.1452347438
#> 5   A    4 0.0182219108
#> 6   A    5 0.1103914111
#> 7   B    0 0.4969610828
#> 8   B    1 0.5019581990
#> 9   B    2 0.0010807182
```

``` r
subtract(a, "A", "B")
#>    elements sets       fuzzy
#> 1         a    A 0.434828949
#> 2         a    B 0.501966667
#> 3         b  A∖B 0.980737684
#> 4         b    A 0.980737684
#> 5         c    A 0.447322056
#> 6         c  A∖B 0.447322056
#> 7         d    A 0.835097668
#> 8         d  A∖B 0.835097668
#> 9         e  A∖B 0.692957164
#> 10        e    A 0.692957164
#> 11        f    B 0.002152968
```

``` r
mutate(b, Keep = ifelse(fuzzy > 0.5, TRUE, FALSE))
#>    elements sets       fuzzy  Keep
#> 1         a    A 0.434828949 FALSE
#> 2         a    B 0.447322056 FALSE
#> 3         a  AuB 0.835097668  TRUE
#> 4         c    A 0.501966667  TRUE
#> 5         c  AuB 0.692957164  TRUE
#> 6         b  AuB 0.835097668  TRUE
#> 7         b    A 0.501966667  TRUE
#> 8         e    A 0.980737684  TRUE
#> 9         e  AuB 0.002152968 FALSE
#> 10        d    A 0.980737684  TRUE
#> 11        d  AuB 0.692957164  TRUE
#> 12        f    B 0.447322056 FALSE
#> 13        f  AuB 0.002152968 FALSE
```
