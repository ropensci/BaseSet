# BaseSet

Abstract

Describes the background of the package, important functions defined in
the package and some of the applications and usages.

## Getting started

This vignette explains how to work with sets using this package. The
package provides a class to store the information efficiently and
functions to work with it.

## The TidySet class

To create a `TidySet` object, to store associations between elements and
sets image we have several genes associated with a characteristic.

``` r
library("BaseSet")
gene_lists <- list(
    geneset1 = c("A", "B"),
    geneset2 = c("B", "C", "D")
)
tidy_set <- tidySet(gene_lists)
tidy_set
#>   elements     sets fuzzy
#> 1        A geneset1     1
#> 2        B geneset1     1
#> 3        B geneset2     1
#> 4        C geneset2     1
#> 5        D geneset2     1
```

This is then stored internally in three slots
[`relations()`](https://docs.ropensci.org/BaseSet/dev/reference/relations.md),
[`elements()`](https://docs.ropensci.org/BaseSet/dev/reference/elements.md),
and [`sets()`](https://docs.ropensci.org/BaseSet/dev/reference/sets.md)
slots.

If you have more information for each element or set it can be added:

``` r
gene_data <- data.frame(
    stat1     = c( 1,   2,   3,   4 ),
    info1     = c("a", "b", "c", "d")
)

tidy_set <- add_column(tidy_set, "elements", gene_data)
set_data <- data.frame(
    Group     = c( 100 ,  200 ),
    Column     = c("abc", "def")
)
tidy_set <- add_column(tidy_set, "sets", set_data)
tidy_set
#>   elements     sets fuzzy Group Column stat1 info1
#> 1        A geneset1     1   100    abc     1     a
#> 2        B geneset1     1   100    abc     2     b
#> 3        B geneset2     1   200    def     2     b
#> 4        C geneset2     1   200    def     3     c
#> 5        D geneset2     1   200    def     4     d
```

This data is stored in one of the three slots, which can be directly
accessed using their getter methods:

``` r
relations(tidy_set)
#>   elements     sets fuzzy
#> 1        A geneset1     1
#> 2        B geneset1     1
#> 3        B geneset2     1
#> 4        C geneset2     1
#> 5        D geneset2     1
elements(tidy_set)
#>   elements stat1 info1
#> 1        A     1     a
#> 2        B     2     b
#> 3        C     3     c
#> 4        D     4     d
sets(tidy_set)
#>       sets Group Column
#> 1 geneset1   100    abc
#> 2 geneset2   200    def
```

You can add as much information as you want, with the only restriction
for a “fuzzy” column for the
[`relations()`](https://docs.ropensci.org/BaseSet/dev/reference/relations.md).
See the Fuzzy sets vignette: `vignette("Fuzzy sets", "BaseSet")`.

You can also use the standard R approach with `[`:

``` r
gene_data <- data.frame(
    stat2     = c( 4,   4,   3,   5 ),
    info2     = c("a", "b", "c", "d")
)

tidy_set$info1 <- NULL
tidy_set[, "elements", c("stat2", "info2")] <- gene_data
tidy_set[, "sets", "Group"] <- c("low", "high")
tidy_set
#>   elements     sets fuzzy Group Column stat1 stat2 info2
#> 1        A geneset1     1   low    abc     1     4     a
#> 2        B geneset1     1   low    abc     2     4     b
#> 3        B geneset2     1  high    def     2     4     b
#> 4        C geneset2     1  high    def     3     3     c
#> 5        D geneset2     1  high    def     4     5     d
```

Observe that one can add, replace or delete

## Creating a TidySet

As you can see it is possible to create a TidySet from a list. More
commonly you can create it from a data.frame:

``` r
relations <- data.frame(elements = c("a", "b", "c", "d", "e", "f"), 
                        sets = c("A", "A", "A", "A", "A", "B"), 
                        fuzzy = c(1, 1, 1, 1, 1, 1))
TS <- tidySet(relations)
TS
#>   elements sets fuzzy
#> 1        a    A     1
#> 2        b    A     1
#> 3        c    A     1
#> 4        d    A     1
#> 5        e    A     1
#> 6        f    B     1
```

It is also possible from a matrix:

``` r
m <- matrix(c(0, 0, 1, 1, 1, 1, 0, 1, 0), ncol = 3, nrow = 3,  
               dimnames = list(letters[1:3], LETTERS[1:3]))
m
#>   A B C
#> a 0 1 0
#> b 0 1 1
#> c 1 1 0
tidy_set <- tidySet(m)
tidy_set
#>   elements sets fuzzy
#> 1        c    A     1
#> 2        a    B     1
#> 3        b    B     1
#> 4        c    B     1
#> 5        b    C     1
```

Or they can be created from a GeneSet and GeneSetCollection objects.
Additionally it has several function to read files related to sets like
the OBO files (`getOBO`) and GAF (`getGAF`)

## Converting to other formats

It is possible to extract the gene sets as a `list`, for use with
functions such as `lapply`.

``` r
as.list(tidy_set)
#> $A
#> c 
#> 1 
#> 
#> $B
#> a b c 
#> 1 1 1 
#> 
#> $C
#> b 
#> 1
```

Or if you need to apply some network methods and you need a matrix, you
can create it with `incidence`:

``` r
incidence(tidy_set)
#>   A B C
#> c 1 1 0
#> a 0 1 0
#> b 0 1 1
```

## Operations with sets

To work with sets several methods are provided. In general you can
provide a new name for the resulting set of the operation, but if you
don’t one will be automatically provided using
[`naming()`](https://docs.ropensci.org/BaseSet/dev/reference/naming.md).
All methods work with fuzzy and non-fuzzy sets

### Union

You can make a union of two sets present on the same object.

``` r
BaseSet::union(tidy_set, sets = c("C", "B"), name = "D")
#>   elements sets fuzzy
#> 1        a    D     1
#> 2        b    D     1
#> 3        c    D     1
```

### Intersection

``` r
intersection(tidy_set, sets = c("A", "B"), name = "D", keep = TRUE)
#>   elements sets fuzzy
#> 1        c    A     1
#> 2        a    B     1
#> 3        b    B     1
#> 4        c    B     1
#> 5        b    C     1
#> 6        c    D     1
```

The keep argument used here is if you want to keep all the other
previous sets:

``` r
intersection(tidy_set, sets = c("A", "B"), name = "D", keep = FALSE)
#>   elements sets fuzzy
#> 1        c    D     1
```

### Complement

We can look for the complement of one or several sets:

``` r
complement_set(tidy_set, sets = c("A", "B"))
#>   elements sets fuzzy
#> 1        c    A     1
#> 2        a    B     1
#> 3        b    B     1
#> 4        c    B     1
#> 5        b    C     1
#> 6        c ∁A∪B     0
#> 7        a ∁A∪B     0
#> 8        b ∁A∪B     0
```

Observe that we haven’t provided a name for the resulting set but we can
provide one if we prefer to

``` r
complement_set(tidy_set, sets = c("A", "B"), name = "F")
#>   elements sets fuzzy
#> 1        c    A     1
#> 2        a    B     1
#> 3        b    B     1
#> 4        c    B     1
#> 5        b    C     1
#> 6        c    F     0
#> 7        a    F     0
#> 8        b    F     0
```

### Subtract

This is the equivalent of `setdiff`, but clearer:

``` r
out <- subtract(tidy_set, set_in = "A", not_in = "B", name = "A-B")
out
#>   elements sets fuzzy
#> 1        c    A     1
#> 2        a    B     1
#> 3        b    B     1
#> 4        c    B     1
#> 5        b    C     1
name_sets(out)
#> [1] "A"   "B"   "C"   "A-B"
subtract(tidy_set, set_in = "B", not_in = "A", keep = FALSE)
#>   elements sets fuzzy
#> 1        a  B∖A     1
#> 2        b  B∖A     1
```

See that in the first case there isn’t any element present in B not in
set A, but the new set is stored. In the second use case we focus just
on the elements that are present on B but not in A.

## Additional information

The number of unique elements and sets can be obtained using the
[`nElements()`](https://docs.ropensci.org/BaseSet/dev/reference/nElements.md)
and
[`nSets()`](https://docs.ropensci.org/BaseSet/dev/reference/nSets.md)
methods.

``` r
nElements(tidy_set)
#> [1] 3
nSets(tidy_set)
#> [1] 3
nRelations(tidy_set)
#> [1] 5
```

If you wish to know all in a single call you can use `dim(tidy_set)`: 3,
5, 3. This summary doesn’t provide the number of relations of each set.
You can quickly obtain that with `lengths(tidy_set)`: 1, 3, 1

The size of each set can be obtained using the
[`set_size()`](https://docs.ropensci.org/BaseSet/dev/reference/set_size.md)
method.

``` r
set_size(tidy_set)
#>   sets size probability
#> 1    A    1           1
#> 2    B    3           1
#> 3    C    1           1
```

Conversely, the number of sets associated with each gene is returned by
the
[`element_size()`](https://docs.ropensci.org/BaseSet/dev/reference/element_size.md)
function.

``` r
element_size(tidy_set)
#>   elements size probability
#> 1        c    2           1
#> 2        a    1           1
#> 3        b    2           1
```

The identifiers of elements and sets can be inspected and renamed using
`name_elements` and

``` r
name_elements(tidy_set)
#> [1] "c" "a" "b"
name_elements(tidy_set) <- paste0("Gene", seq_len(nElements(tidy_set)))
name_elements(tidy_set)
#> [1] "Gene1" "Gene2" "Gene3"
name_sets(tidy_set)
#> [1] "A" "B" "C"
name_sets(tidy_set) <- paste0("Geneset", seq_len(nSets(tidy_set)))
name_sets(tidy_set)
#> [1] "Geneset1" "Geneset2" "Geneset3"
```

## Using `dplyr` verbs

You can also use
[`mutate()`](https://dplyr.tidyverse.org/reference/mutate.html),
[`filter()`](https://dplyr.tidyverse.org/reference/filter.html),
[`select()`](https://dplyr.tidyverse.org/reference/select.html),
[`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html) and
other `dplyr` verbs with TidySets. You usually need to activate which
three slots you want to affect with
[`activate()`](https://docs.ropensci.org/BaseSet/dev/reference/activate.md):

``` r
library("dplyr")
#> 
#> Attaching package: 'dplyr'
#> The following object is masked from 'package:BaseSet':
#> 
#>     union
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
m_TS <- tidy_set %>% 
  activate("relations") %>% 
  mutate(Important = runif(nRelations(tidy_set)))
m_TS
#>   elements     sets fuzzy   Important
#> 1    Gene1 Geneset1     1 0.080750138
#> 2    Gene2 Geneset2     1 0.834333037
#> 3    Gene3 Geneset2     1 0.600760886
#> 4    Gene1 Geneset2     1 0.157208442
#> 5    Gene3 Geneset3     1 0.007399441
```

You can use activate to select what are the verbs modifying:

``` r
set_modified <- m_TS %>% 
  activate("elements") %>% 
  mutate(Pathway = if_else(elements %in% c("Gene1", "Gene2"), 
                           "pathway1", 
                           "pathway2"))
set_modified
#>   elements     sets fuzzy   Important  Pathway
#> 1    Gene1 Geneset1     1 0.080750138 pathway1
#> 2    Gene2 Geneset2     1 0.834333037 pathway1
#> 3    Gene3 Geneset2     1 0.600760886 pathway2
#> 4    Gene1 Geneset2     1 0.157208442 pathway1
#> 5    Gene3 Geneset3     1 0.007399441 pathway2
set_modified %>% 
  deactivate() %>% # To apply a filter independently of where it is
  filter(Pathway == "pathway1")
#>   elements     sets fuzzy  Important  Pathway
#> 1    Gene1 Geneset1     1 0.08075014 pathway1
#> 2    Gene2 Geneset2     1 0.83433304 pathway1
#> 3    Gene1 Geneset2     1 0.15720844 pathway1
```

If you think you need `group_by` usually this could mean that you need a
new set. You can create a new one with `group`.

``` r
# A new group of those elements in pathway1 and with Important == 1
set_modified %>% 
  deactivate() %>% 
  group(name = "new", Pathway == "pathway1")
#>   elements     sets fuzzy   Important  Pathway
#> 1    Gene1 Geneset1     1 0.080750138 pathway1
#> 2    Gene2 Geneset2     1 0.834333037 pathway1
#> 3    Gene3 Geneset2     1 0.600760886 pathway2
#> 4    Gene1 Geneset2     1 0.157208442 pathway1
#> 5    Gene3 Geneset3     1 0.007399441 pathway2
#> 6    Gene1      new     1          NA pathway1
#> 7    Gene2      new     1          NA pathway1
```

``` r
set_modified %>% 
  group("pathway1", elements %in% c("Gene1", "Gene2"))
#>   elements     sets fuzzy   Important  Pathway
#> 1    Gene1 Geneset1     1 0.080750138 pathway1
#> 2    Gene2 Geneset2     1 0.834333037 pathway1
#> 3    Gene3 Geneset2     1 0.600760886 pathway2
#> 4    Gene1 Geneset2     1 0.157208442 pathway1
#> 5    Gene3 Geneset3     1 0.007399441 pathway2
#> 6    Gene1 pathway1     1          NA pathway1
#> 7    Gene2 pathway1     1          NA pathway1
```

You can use
[`group_by()`](https://dplyr.tidyverse.org/reference/group_by.html) but
it won’t return a `TidySet`.

``` r
set_modified %>% 
    deactivate() %>% 
    group_by(Pathway, sets) %>%  
    count()
#> # A tibble: 4 × 3
#> # Groups:   Pathway, sets [4]
#>   Pathway  sets         n
#>   <chr>    <chr>    <int>
#> 1 pathway1 Geneset1     1
#> 2 pathway1 Geneset2     2
#> 3 pathway2 Geneset2     1
#> 4 pathway2 Geneset3     1
```

After grouping or mutating sometimes we might be interested in moving a
column describing something to other places. We can do by this with:

``` r
elements(set_modified)
#>   elements  Pathway
#> 1    Gene1 pathway1
#> 2    Gene2 pathway1
#> 3    Gene3 pathway2
out <- move_to(set_modified, "elements", "relations", "Pathway")
relations(out)
#>   elements     sets fuzzy   Important  Pathway
#> 1    Gene1 Geneset1     1 0.080750138 pathway1
#> 2    Gene2 Geneset2     1 0.834333037 pathway1
#> 3    Gene3 Geneset2     1 0.600760886 pathway2
#> 4    Gene1 Geneset2     1 0.157208442 pathway1
#> 5    Gene3 Geneset3     1 0.007399441 pathway2
```

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
