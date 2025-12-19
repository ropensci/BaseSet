# Fuzzy sets

Abstract

Describes the fuzzy sets, interpretation and how to work with them.

## Getting started

This vignettes supposes that you already read the “About BaseSet”
vignette. This vignette explains what are the fuzzy sets and how to use
them. As all methods for “normal” sets are available for fuzzy sets this
vignette focuses on how to create, use them.

## What are fuzzy sets and why/when use them ?

Fuzzy sets are generalizations of classical sets where there is some
vagueness, one doesn’t know for sure something on this relationship
between the set and the element. This vagueness can be on the assignment
to a set and/or on the membership on the set. One way these vagueness
arise is when classifying a continuous scale on a categorical scale, for
example: when the temperature is 20ºC is it hot or not? If the
temperature drops to 15ºC is it warm? When does the switch happen from
warm to hot?

In fuzzy set theories the step from a continuous scale to a categorical
scale is performed by the [membership
function](https://en.wikipedia.org/wiki/Membership_function_(mathematics))
and is called
[fuzzification](https://en.wikipedia.org/wiki/Fuzzy_logic#Fuzzification).

When there is a degree of membership and uncertainty on the membership
it is considered a [type-2 fuzzy
set](https://en.wikipedia.org/wiki/Type-2_fuzzy_sets_and_systems). We
can understand it with using as example a paddle ball, it can be used
for tennis or paddle (membership), but until we don’t test it bouncing
on the court we won’t be sure (assignment) if it is a paddle ball or a
tennis ball. We could think about a ball equally good for tennis and
paddle (membership) but which two people thought it is for tennis and
the other for paddle.

These voting/rating system is also a common scenario where fuzzy sets
arise. When several graders/people need to agree but compromise on a
middle ground. One modern example of this is ratting apps where several
people vote between 1 and 5 an app and the displayed value takes into
consideration all the votes.

As you can see when one does have some vagueness or uncertainty then
fuzzy logic is a good choice. There have been developed several logic
and methods.

## Creating a fuzzy set

To create a fuzzy set you need to have a column named “fuzzy” if you
create it from a `data.frame` or have a named numeric vector if you
create it from a `list`. These values are restricted to a numeric value
between 0 and 1. The value indicates the strength, membership, truth
value (or probability) of the relationship between the element and the
set.

``` r
set.seed(4567) # To be able to have exact replicates
relations <- data.frame(sets = c(rep("A", 5), "B", "C"),
                        elements = c(letters[seq_len(6)], letters[6]),
                        fuzzy = runif(7))
fuzzy_set <- tidySet(relations)
```

## Working with fuzzy sets

We can work with fuzzy sets as we do with normal sets. But if you
remember that at the end of the previous vignette we used an Important
column, now it is already included as fuzzy. This allows us to use this
information for union and intersection methods and other operations:

### Union

You can make a union of two sets present on the same object.

``` r
BaseSet::union(fuzzy_set, sets = c("A", "B"))
#>   elements sets     fuzzy
#> 1        a  A∪B 0.2309186
#> 2        b  A∪B 0.7412554
#> 3        c  A∪B 0.1833834
#> 4        d  A∪B 0.4221682
#> 5        e  A∪B 0.5996399
#> 6        f  A∪B 0.2773313
BaseSet::union(fuzzy_set, sets = c("A", "B"), name = "D")
#>   elements sets     fuzzy
#> 1        a    D 0.2309186
#> 2        b    D 0.7412554
#> 3        c    D 0.1833834
#> 4        d    D 0.4221682
#> 5        e    D 0.5996399
#> 6        f    D 0.2773313
```

We get a new set with all the elements on both sets. There isn’t an
element in both sets A and B, so the fuzzy values here do not change.

If we wanted to use other logic we can with provide it with the FUN
argument.

``` r

BaseSet::union(fuzzy_set, sets = c("A", "B"), FUN = function(x){sqrt(sum(x))})
#>   elements sets     fuzzy
#> 1        a  A∪B 0.4805399
#> 2        b  A∪B 0.8609619
#> 3        c  A∪B 0.4282329
#> 4        d  A∪B 0.6497448
#> 5        e  A∪B 0.7743642
#> 6        f  A∪B 0.5266226
```

There are several logic see for instance `?sets::fuzzy_logic`. You
should pick the operators that fit on the framework of your data. Make
sure that the defaults arguments of logic apply to your data obtaining
process.

### Intersection

However if we do the intersection between B and C we can see some
changes on the fuzzy value:

``` r
intersection(fuzzy_set, sets = c("B", "C"), keep = FALSE)
#>   elements sets     fuzzy
#> 1        f  B∩C 0.2773313
intersection(fuzzy_set, sets = c("B", "C"), keep = FALSE, FUN = "mean")
#>   elements sets     fuzzy
#> 1        f  B∩C 0.5040313
```

Different logic on the
[`union()`](https://docs.ropensci.org/BaseSet/dev/reference/union.md),
[`intersection()`](https://docs.ropensci.org/BaseSet/dev/reference/intersection.md),
[`complement()`](https://docs.ropensci.org/BaseSet/dev/reference/complement.md),
and
[`cardinality()`](https://docs.ropensci.org/BaseSet/dev/reference/cardinality.md),
we get different fuzzy values. Depending on the nature of our fuzziness
and the intended goal we might apply one or other rules.

### Complement

We can look for the complement of one or several sets:

``` r
complement_set(fuzzy_set, sets = "A", keep = FALSE)
#>   elements sets     fuzzy
#> 1        a   ∁A 0.7690814
#> 2        b   ∁A 0.2587446
#> 3        c   ∁A 0.8166166
#> 4        d   ∁A 0.5778318
#> 5        e   ∁A 0.4003601
```

Note that the values of the complement are `1-fuzzy` but can be changed:

``` r
filter(fuzzy_set, sets == "A")
#>   elements sets     fuzzy
#> 1        a    A 0.2309186
#> 2        b    A 0.7412554
#> 3        c    A 0.1833834
#> 4        d    A 0.4221682
#> 5        e    A 0.5996399
complement_set(fuzzy_set, sets = "A", keep = FALSE, FUN = function(x){1-x^2})
#>   elements sets     fuzzy
#> 1        a   ∁A 0.9466766
#> 2        b   ∁A 0.4505405
#> 3        c   ∁A 0.9663705
#> 4        d   ∁A 0.8217740
#> 5        e   ∁A 0.6404320
```

### Subtract

This is the equivalent of `setdiff`, but clearer:

``` r
subtract(fuzzy_set, set_in = "A", not_in = "B", keep = FALSE, name = "A-B")
#>   elements sets     fuzzy
#> 1        a  A-B 0.2309186
#> 2        b  A-B 0.7412554
#> 3        c  A-B 0.1833834
#> 4        d  A-B 0.4221682
#> 5        e  A-B 0.5996399
# Or the opposite B-A, but using the default name:
subtract(fuzzy_set, set_in = "B", not_in = "A", keep = FALSE)
#>   elements sets     fuzzy
#> 1        f  B∖A 0.2773313
```

Note that here there is also a subtraction of the fuzzy value.

## Sizes

If we consider the fuzzy values as probabilities then the size of a set
is not fixed. To calculate the size of a given set we have
[`set_size()`](https://docs.ropensci.org/BaseSet/dev/reference/set_size.md):

``` r
set_size(fuzzy_set)
#>    sets size probability
#> 1     A    0 0.037593610
#> 2     A    1 0.211200558
#> 3     A    2 0.384150899
#> 4     A    3 0.278302802
#> 5     A    4 0.080805868
#> 6     A    5 0.007946263
#> 7     B    0 0.722668660
#> 8     B    1 0.277331340
#> 9     C    0 0.269268826
#> 10    C    1 0.730731174
```

Or an element can be in 0 sets:

``` r
element_size(fuzzy_set)
#>    elements size probability
#> 1         a    0   0.7690814
#> 2         a    1   0.2309186
#> 3         b    0   0.2587446
#> 4         b    1   0.7412554
#> 5         c    0   0.8166166
#> 6         c    1   0.1833834
#> 7         d    0   0.5778318
#> 8         d    1   0.4221682
#> 9         e    0   0.4003601
#> 10        e    1   0.5996399
#> 11        f    0   0.1945921
#> 12        f    1   0.6027532
#> 13        f    2   0.2026547
```

In this example we can see that it is more probable that the element “a”
is not present than the element “f” being present in one set.

## Interpretation

Sometimes it can be a bit hard to understand what do the fuzzy sets mean
on your analysis. To better understand let’s dive a bit in the
interpretation with an example:

Imagine you have your experiment where you collected data from a sample
of cells for each cell (our elements). Then you used some program to
classify which type of cell it is (alpha, beta, delta, endothelial),
this are our sets. The software returns a probability for each type it
has: the higher, the more confident it is of the assignment:

``` r
sc_classification <- data.frame(
    elements = c("D2ex_1", "D2ex_10", "D2ex_11", "D2ex_12", "D2ex_13", "D2ex_14", 
                 "D2ex_15", "D2ex_16", "D2ex_17", "D2ex_18", "D2ex_1", "D2ex_10", 
                 "D2ex_11", "D2ex_12", "D2ex_13", "D2ex_14", "D2ex_15", "D2ex_16",
                 "D2ex_17", "D2ex_18", "D2ex_1", "D2ex_10", "D2ex_11", "D2ex_12", 
                 "D2ex_13", "D2ex_14", "D2ex_15", "D2ex_16", "D2ex_17", "D2ex_18", 
                 "D2ex_1", "D2ex_10", "D2ex_11", "D2ex_12", "D2ex_13", "D2ex_14", 
                 "D2ex_15", "D2ex_16", "D2ex_17", "D2ex_18"), 
    sets = c("alpha", "alpha", "alpha", "alpha", "alpha", "alpha", "alpha", 
             "alpha", "alpha", "alpha", "endothel", "endothel", "endothel", 
             "endothel", "endothel", "endothel", "endothel", "endothel", 
             "endothel", "endothel", "delta", "delta", "delta", "delta", "delta", 
             "delta", "delta", "delta", "delta", "delta", "beta", "beta", "beta", 
             "beta", "beta", "beta", "beta", "beta", "beta", "beta"), 
    fuzzy = c(0.18, 0.169, 0.149, 0.192, 0.154, 0.161, 0.169, 0.197, 0.162, 0.201, 
              0.215, 0.202, 0.17, 0.227, 0.196, 0.215, 0.161, 0.195, 0.178, 
              0.23, 0.184, 0.172, 0.153, 0.191, 0.156, 0.167, 0.165, 0.184, 
              0.162, 0.194, 0.197, 0.183, 0.151, 0.208, 0.16, 0.169, 0.169, 
              0.2, 0.154, 0.208), stringsAsFactors = FALSE)
head(sc_classification)
#>   elements  sets fuzzy
#> 1   D2ex_1 alpha 0.180
#> 2  D2ex_10 alpha 0.169
#> 3  D2ex_11 alpha 0.149
#> 4  D2ex_12 alpha 0.192
#> 5  D2ex_13 alpha 0.154
#> 6  D2ex_14 alpha 0.161
```

Our question is **which type of cells did we have on the original
sample?**

We can easily answer this by looking at the relations that have higher
confidence of the relationship for each cell.

``` r
sc_classification %>% 
    group_by(elements) %>% 
    filter(fuzzy == max(fuzzy)) %>% 
    group_by(sets) %>% 
    count()
#> # A tibble: 3 × 2
#> # Groups:   sets [3]
#>   sets         n
#>   <chr>    <int>
#> 1 alpha        1
#> 2 beta         2
#> 3 endothel     8
```

There is a cell that can be in two cell types, because we started with
10 cells and we have 11 elements here. However, how likely is that a
cell is placed to just a single set?

``` r
scTS <- tidySet(sc_classification) # Conversion of format
sample_cells <- scTS %>% 
    element_size() %>% 
    group_by(elements) %>% 
    filter(probability == max(probability))
sample_cells
#> # A tibble: 10 × 3
#> # Groups:   elements [10]
#>    elements  size probability
#>    <chr>    <dbl>       <dbl>
#>  1 D2ex_1       0       0.422
#>  2 D2ex_10      0       0.449
#>  3 D2ex_11      0       0.508
#>  4 D2ex_12      1       0.412
#>  5 D2ex_13      0       0.482
#>  6 D2ex_14      0       0.456
#>  7 D2ex_15      0       0.484
#>  8 D2ex_16      0       0.422
#>  9 D2ex_17      0       0.488
#> 10 D2ex_18      1       0.414
```

There must be some cell misclassification: we have 10 cells in this
example but there are 2 cells that the maximum probability predicted for
these types is a single cell type. Even the cell that had two equal
probabilities for two cell types is more probable to be in no one of
these cell types than in any of them.

Ideally the predicted number of cells per type and the cells with higher
confidence about the type should match.

We can also look the other way around: How good is the prediction of a
cell type for each cell?

``` r
scTS %>% 
    set_size() %>% 
    group_by(sets) %>% 
    filter(probability == max(probability))
#> # A tibble: 4 × 3
#> # Groups:   sets [4]
#>   sets      size probability
#>   <chr>    <dbl>       <dbl>
#> 1 alpha        1       0.313
#> 2 beta         1       0.302
#> 3 delta        1       0.313
#> 4 endothel     2       0.303
```

We can see that for each cell type it is probable to have at least one
cell and in the endothelial cell type two cells is the most probable
outcome. However, these probabilities are lower than the probabilities
of cells being assigned a cell type. This would mean that this method is
not a good method or that the cell types are not specific enough for the
cell.

In summary, the cells that we had most probable are not those 4 cell
types except in two cells were it might be.

## Session info

    #> R version 4.5.2 (2025-10-31)
    #> Platform: x86_64-pc-linux-gnu
    #> Running under: Ubuntu 24.04.3 LTS
    #> 
    #> Matrix products: default
    #> BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
    #> LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.26.so;  LAPACK version 3.12.0
    #> 
    #> locale:
    #>  [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8       
    #>  [4] LC_COLLATE=C.UTF-8     LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8   
    #>  [7] LC_PAPER=C.UTF-8       LC_NAME=C              LC_ADDRESS=C          
    #> [10] LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C   
    #> 
    #> time zone: UTC
    #> tzcode source: system (glibc)
    #> 
    #> attached base packages:
    #> [1] stats     graphics  grDevices utils     datasets  methods   base     
    #> 
    #> other attached packages:
    #> [1] dplyr_1.1.4        BaseSet_1.0.0.9001
    #> 
    #> loaded via a namespace (and not attached):
    #>  [1] vctrs_0.6.5       cli_3.6.5         knitr_1.50        rlang_1.1.6      
    #>  [5] xfun_0.55         generics_0.1.4    textshaping_1.0.4 jsonlite_2.0.0   
    #>  [9] glue_1.8.0        htmltools_0.5.9   ragg_1.5.0        sass_0.4.10      
    #> [13] rmarkdown_2.30    tibble_3.3.0      evaluate_1.0.5    jquerylib_0.1.4  
    #> [17] fastmap_1.2.0     yaml_2.3.12       lifecycle_1.0.4   compiler_4.5.2   
    #> [21] fs_1.6.6          pkgconfig_2.0.3   systemfonts_1.3.1 digest_0.6.39    
    #> [25] R6_2.6.1          utf8_1.2.6        tidyselect_1.2.1  pillar_1.11.1    
    #> [29] magrittr_2.0.4    bslib_0.9.0       tools_4.5.2       pkgdown_2.2.0    
    #> [33] cachem_1.1.0      desc_1.4.3
