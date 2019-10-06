
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis build
status](https://travis-ci.org/llrs/BaseSet.svg?branch=master)](https://travis-ci.org/llrs/BaseSet)
[![Coverage
status](https://codecov.io/gh/llrs/BaseSet/branch/master/graph/badge.svg)](https://codecov.io/github/llrs/BaseSet?branch=master)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

# BaseSet

The goal of BaseSet is to facilitate working with sets in an efficient
way.

## Installation

You can install the latest version of BaseSet from
[Github](https://github.com/llrs/BaseSet) with:

``` r
remotes::install_github("llrs/BaseSet")
```

## Examples

To work with sets we need to have the relations between the elements and
the sets:

``` r
sets <- list(A = letters[1:5], B = c("a", "f"))
sets_analysis <- tidySet(sets)
sets_analysis
#>   elements sets fuzzy
#> 1        a    A     1
#> 2        a    B     1
#> 3        b    A     1
#> 4        c    A     1
#> 5        d    A     1
#> 6        e    A     1
#> 7        f    B     1
```

Perform typical operations like union, intersection:

``` r
union(sets_analysis, sets = c("A", "B")) 
#>   elements sets fuzzy
#> 1        a  A∪B     1
#> 2        b  A∪B     1
#> 3        c  A∪B     1
#> 4        d  A∪B     1
#> 5        e  A∪B     1
#> 6        f  A∪B     1
# Or we can give a name to the new set and keep the others sets
union(sets_analysis, sets = c("A", "B"), name = "D")
#>   elements sets fuzzy
#> 1        a    D     1
#> 2        b    D     1
#> 3        c    D     1
#> 4        d    D     1
#> 5        e    D     1
#> 6        f    D     1
# We can do the same in the intersection
intersection(sets_analysis, sets = c("A", "B"), name = "D") 
#>   elements sets fuzzy
#> 1        a    D     1
# Or we can omit the new name: 
intersection(sets_analysis, sets = c("A", "B"))
#>   elements sets fuzzy
#> 1        a  A∩B     1
```

And compute size of sets among other things:

``` r
set_size(sets_analysis)
#>   sets size probability
#> 1    A    5           1
#> 2    B    2           1
```

The elements in one set not present in other:

``` r
subtract(sets_analysis, set_in = "A", not_in = "B", keep = FALSE)
#>   elements sets fuzzy
#> 1        b  A∖B     1
#> 2        c  A∖B     1
#> 3        d  A∖B     1
#> 4        e  A∖B     1
```

Or any other verb from
[dplyr](https://cran.r-project.org/package=dplyr). Like mutate

``` r
library("magrittr")
#> 
#> Attaching package: 'magrittr'
#> The following object is masked from 'package:BaseSet':
#> 
#>     subtract
set.seed(4673) # To make it reproducible in your machine
sets_analysis %>% 
  mutate(Keep = sample(c(TRUE, FALSE), 7, replace = TRUE)) %>% 
  filter(Keep == TRUE) %>% 
  activate("sets") %>% 
  mutate(sets_origin = c("Reactome", "KEGG"))
#>   elements sets fuzzy Keep sets_origin
#> 1        a    A     1 TRUE    Reactome
#> 2        a    B     1 TRUE        KEGG
#> 3        b    A     1 TRUE    Reactome
#> 4        c    A     1 TRUE    Reactome
#> 5        d    A     1 TRUE    Reactome
#> 6        f    B     1 TRUE        KEGG
```

## Fuzzy sets

You can do the same operations with fuzzy sets:

``` r
relations <- data.frame(sets = c(rep("A", 5), "B", "B"), 
                        elements = c("a", "b", "c", "d", "e", "a", "f"),
                        fuzzy = runif(7))
fuzzy_set <- tidySet(relations)
fuzzy_set
#>   elements sets     fuzzy
#> 1        a    A 0.1837246
#> 2        a    B 0.9381182
#> 3        b    A 0.4567009
#> 4        c    A 0.8152075
#> 5        d    A 0.5800610
#> 6        e    A 0.5724973
#> 7        f    B 0.9460158
union(fuzzy_set, sets = c("A", "B"))
#>   elements sets     fuzzy
#> 1        a  A∪B 0.9381182
#> 2        b  A∪B 0.4567009
#> 3        c  A∪B 0.8152075
#> 4        d  A∪B 0.5800610
#> 5        e  A∪B 0.5724973
#> 6        f  A∪B 0.9460158
union(fuzzy_set, sets = c("A", "B"), name = "D", keep = TRUE)
#>    elements sets     fuzzy
#> 1         a    A 0.1837246
#> 2         a    B 0.9381182
#> 3         a    D 0.9381182
#> 4         b    D 0.4567009
#> 5         b    A 0.4567009
#> 6         c    A 0.8152075
#> 7         c    D 0.8152075
#> 8         d    D 0.5800610
#> 9         d    A 0.5800610
#> 10        e    A 0.5724973
#> 11        e    D 0.5724973
#> 12        f    B 0.9460158
#> 13        f    D 0.9460158
intersection(fuzzy_set, sets = c("A", "B"), name = "D") 
#>   elements sets     fuzzy
#> 1        a    D 0.1837246
intersection(fuzzy_set, sets = c("A", "B"), keep = TRUE)
#>   elements sets     fuzzy
#> 1        a    A 0.1837246
#> 2        a    B 0.9381182
#> 3        a  A∩B 0.1837246
#> 4        b    A 0.4567009
#> 5        c    A 0.8152075
#> 6        d    A 0.5800610
#> 7        e    A 0.5724973
#> 8        f    B 0.9460158
# Note here the difference:
set_size(fuzzy_set) # A set could be empty!
#>   sets size probability
#> 1    A    0 0.014712455
#> 2    A    1 0.166499731
#> 3    A    2 0.357078627
#> 4    A    3 0.318386944
#> 5    A    4 0.120607154
#> 6    A    5 0.022715089
#> 7    B    0 0.003340637
#> 8    B    1 0.109184679
#> 9    B    2 0.887474684
element_size(fuzzy_set)
#>    elements size probability
#> 1         a    0  0.05051256
#> 2         a    1  0.77713204
#> 3         a    2  0.17235540
#> 4         b    0  0.54329910
#> 5         b    1  0.45670090
#> 6         c    0  0.18479253
#> 7         c    1  0.81520747
#> 8         d    0  0.41993900
#> 9         d    1  0.58006100
#> 10        e    0  0.42750268
#> 11        e    1  0.57249732
#> 12        f    0  0.05398419
#> 13        f    1  0.94601581
fuzzy_set %>% 
  mutate(Keep = ifelse(fuzzy > 0.5, TRUE, FALSE)) %>% 
  filter(Keep == TRUE) %>% 
  activate("sets") %>% 
  mutate(sets_origin = c("Reactome", "KEGG"))
#>   elements sets     fuzzy Keep sets_origin
#> 1        a    B 0.9381182 TRUE    Reactome
#> 2        f    B 0.9460158 TRUE    Reactome
#> 3        c    A 0.8152075 TRUE        KEGG
#> 4        d    A 0.5800610 TRUE        KEGG
#> 5        e    A 0.5724973 TRUE        KEGG
```

Please note that the ‘BaseSet’ project is released with a [Contributor
Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project,
you agree to abide by its terms.
