
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

A new way mixing S4 but following tidyverse style:

``` r
relations <- data.frame(sets = c(rep("a", 5), "b"), 
                        elements = letters[seq_len(6)],
                        fuzzy = runif(6))
a <- tidySet(relations = relations)
a
#>   elements sets     fuzzy
#> 1        a    a 0.1114163
#> 2        b    a 0.9514007
#> 3        c    a 0.7440293
#> 4        d    a 0.7995760
#> 5        e    a 0.5791431
#> 6        f    b 0.3420518
```
