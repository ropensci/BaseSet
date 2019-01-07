
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
#> Set with 3 elements.
set(c("a", "b", "a"))
#> Error in validObject(.Object): invalid class "Set" object: All elements names should be unique
```

We can calculate the size of the sets, the length is reported when printing the object:

``` r
a <- set(c("a" = 0.5, "b" = 0.2, "c" = 0.3, "d" = 0.5))
b <- set(letters[1:4])
a
#> Fuzzy set with 4 elements.
b
#> Set with 4 elements.
length(a) # this is automatically reported
#> [1] 4
length(b) # this is automatically reported
#> [1] 4
set_size(a)
#>     1     2     3     4 
#> 0.125 0.345 0.375 0.140
set_size(b)
#> [1] 4
```

``` r
SC <- setCollection(c(a, b))
incidence(SC)
#>  
#> a
#> b
#> c
#> d
```

A new way mixing S4 but following tidyverse style:

``` r
relations <- data.frame(sets = c(rep("a", 5), "b"), 
                        elements = letters[seq_len(6)])
tidySet(relations = relations)
#> An object of class "TidySet"
#> Slot "elements":
#>   elements
#> 1        a
#> 2        b
#> 3        c
#> 4        d
#> 5        e
#> 6        f
#> 
#> Slot "sets":
#>   set
#> 1   a
#> 2   b
#> 
#> Slot "relations":
#>   sets elements
#> 1    a        a
#> 2    a        b
#> 3    a        c
#> 4    a        d
#> 5    a        e
#> 6    b        f
```
