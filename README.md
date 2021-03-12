
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/ropensci/BaseSet.svg?branch=master)](https://travis-ci.org/ropensci/BaseSet)
[![R build
status](https://github.com/ropensci/BaseSet/workflows/R-CMD-check/badge.svg)](https://github.com/ropensci/BaseSet/actions)
[![Coverage
status](https://codecov.io/gh/ropensci/BaseSet/branch/master/graph/badge.svg)](https://codecov.io/github/ropensci/BaseSet?branch=master)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#maturing)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![rOpenSci](https://badges.ropensci.org/359_status.svg)](https://github.com/ropensci/software-review/issues/359)

<!-- badges: end -->

# BaseSet

The goal of BaseSet is to facilitate working with sets in an efficient
way. The package implements methods to work on sets, doing intersection,
union, complementary, power sets, cartesian product and other set
operations in a tidy way.

The package supports
[classical](https://en.wikipedia.org/wiki/Set_(mathematics)) and
[fuzzy](https://en.wikipedia.org/wiki/Fuzzy_set) sets. Fuzzy sets are
similar to classical sets but there is some vagueness on the
relationship between the element and the set.

It also allows to import from several formats used in the life science
world. Like the
[GMT](https://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Data_formats#GMT:_Gene_Matrix_Transposed_file_format_.28.2A.gmt.29)
and the
[GAF](http://geneontology.org/docs/go-annotation-file-gaf-format-2.1/)
or the [OBO format](http://www.obofoundry.org/) file for ontologies.

You can save information about the elements, sets and their relationship
on the object itself. For instance origin of the set, categorical or
numeric data associated with sets…

Watch BaseSet working on the [examples](#Examples) below and in the
vignettes. You can also find [related packages](#Related-packages) and
the differences with BaseSet. If you have some questions or bugs [open
an issue](https://github.com/ropensci/BaseSet/issues) (remember the
[Code of Conduct](#Code-of-Conduct))

# Installation

The package depends on some packages from Bioconductor. In order to
install some of its dependencies you’ll need first to install
`{BiocManager}`:

``` r
if (!require("BiocManager")) {
  install.packages("BiocManager")
}
```

You can install the latest version of BaseSet from
[Github](https://github.com/ropensci/BaseSet) with:

``` r
BiocManager::install("ropensci/BaseSet", 
                     dependencies = TRUE, build_vignettes = TRUE, force = TRUE)
```

# Examples

## Sets

We can create a set like this:

``` r
sets <- list(A = letters[1:5], B = c("a", "f"))
sets_analysis <- tidySet(sets)
sets_analysis
#>   elements sets fuzzy
#> 1        a    A     1
#> 2        b    A     1
#> 3        c    A     1
#> 4        d    A     1
#> 5        e    A     1
#> 6        a    B     1
#> 7        f    B     1
```

Perform typical operations like union, intersection. You can name the
resulting set or let the default name:

``` r
union(sets_analysis, sets = c("A", "B")) 
#>   elements sets fuzzy
#> 1        a  A∪B     1
#> 2        b  A∪B     1
#> 3        c  A∪B     1
#> 4        d  A∪B     1
#> 5        e  A∪B     1
#> 6        f  A∪B     1
# Or we can give a name to the new set
union(sets_analysis, sets = c("A", "B"), name = "D")
#>   elements sets fuzzy
#> 1        a    D     1
#> 2        b    D     1
#> 3        c    D     1
#> 4        d    D     1
#> 5        e    D     1
#> 6        f    D     1
# Or the intersection
intersection(sets_analysis, sets = c("A", "B"))
#>   elements sets fuzzy
#> 1        a  A∩B     1
# Keeping the other sets:
intersection(sets_analysis, sets = c("A", "B"), name = "D", keep = TRUE) 
#>   elements sets fuzzy
#> 1        a    A     1
#> 2        b    A     1
#> 3        c    A     1
#> 4        d    A     1
#> 5        e    A     1
#> 6        a    B     1
#> 7        f    B     1
#> 8        a    D     1
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
[dplyr](https://cran.r-project.org/package=dplyr). We can add columns,
filter, remove them and add information about the sets:

``` r
library("magrittr")
#> 
#> Attaching package: 'magrittr'
#> The following object is masked from 'package:BaseSet':
#> 
#>     subtract
set.seed(4673) # To make it reproducible in your machine
sets_enriched <- sets_analysis %>% 
  mutate(Keep = sample(c(TRUE, FALSE), 7, replace = TRUE)) %>% 
  filter(Keep == TRUE) %>% 
  select(-Keep) %>% 
  activate("sets") %>% 
  mutate(sets_origin = c("Reactome", "KEGG"))
sets_enriched
#>   elements sets fuzzy sets_origin
#> 1        a    A     1    Reactome
#> 2        b    A     1    Reactome
#> 3        c    A     1    Reactome
#> 4        d    A     1    Reactome
#> 5        e    A     1    Reactome
#> 6        f    B     1        KEGG

# Activating sets makes the verb affect only them:
elements(sets_enriched)
#>   elements
#> 1        a
#> 2        b
#> 3        c
#> 4        d
#> 5        e
#> 6        f
relations(sets_enriched)
#>   elements sets fuzzy
#> 1        a    A     1
#> 2        b    A     1
#> 3        c    A     1
#> 4        d    A     1
#> 5        e    A     1
#> 6        f    B     1
sets(sets_enriched)
#>   sets sets_origin
#> 1    A    Reactome
#> 6    B        KEGG
```

## Fuzzy sets

In [fuzzy sets](https://en.wikipedia.org/wiki/Fuzzy_set) the elements
are vaguely related to the set by a numeric value usually between 0 and
1. This implies that the association is not guaranteed.

``` r
relations <- data.frame(sets = c(rep("A", 5), "B", "B"), 
                        elements = c("a", "b", "c", "d", "e", "a", "f"),
                        fuzzy = runif(7))
fuzzy_set <- tidySet(relations)
fuzzy_set
#>   elements sets     fuzzy
#> 1        a    A 0.1837246
#> 2        b    A 0.4567009
#> 3        c    A 0.8152075
#> 4        d    A 0.5800610
#> 5        e    A 0.5724973
#> 6        a    B 0.9381182
#> 7        f    B 0.9460158
```

The equivalent operations performed on classical sets are possible with
fuzzy sets:

``` r
union(fuzzy_set, sets = c("A", "B")) 
#>   elements sets     fuzzy
#> 1        a  A∪B 0.9381182
#> 2        b  A∪B 0.4567009
#> 3        c  A∪B 0.8152075
#> 4        d  A∪B 0.5800610
#> 5        e  A∪B 0.5724973
#> 6        f  A∪B 0.9460158
# Or we can give a name to the new set
union(fuzzy_set, sets = c("A", "B"), name = "D")
#>   elements sets     fuzzy
#> 1        a    D 0.9381182
#> 2        b    D 0.4567009
#> 3        c    D 0.8152075
#> 4        d    D 0.5800610
#> 5        e    D 0.5724973
#> 6        f    D 0.9460158
# Or the intersection
intersection(fuzzy_set, sets = c("A", "B"))
#>   elements sets     fuzzy
#> 1        a  A∩B 0.1837246
# Keeping the other sets:
intersection(fuzzy_set, sets = c("A", "B"), name = "D", keep = TRUE) 
#>   elements sets     fuzzy
#> 1        a    A 0.1837246
#> 2        b    A 0.4567009
#> 3        c    A 0.8152075
#> 4        d    A 0.5800610
#> 5        e    A 0.5724973
#> 6        a    B 0.9381182
#> 7        f    B 0.9460158
#> 8        a    D 0.1837246
```

Assuming that the fuzzy value is a probability, we can calculate which
is the probability of having several elements:

``` r
# A set could be empty
set_size(fuzzy_set)
#>   sets size probability
#> 1    A    0 0.014712455
#> 2    A    1 0.120607154
#> 3    A    2 0.318386944
#> 4    A    3 0.357078627
#> 5    A    4 0.166499731
#> 6    A    5 0.022715089
#> 7    B    0 0.003340637
#> 8    B    1 0.109184679
#> 9    B    2 0.887474684
# The more probable size of the sets:
set_size(fuzzy_set) %>% 
  group_by(sets) %>% 
  filter(probability == max(probability))
#> # A tibble: 2 x 3
#> # Groups:   sets [2]
#>   sets   size probability
#>   <chr> <dbl>       <dbl>
#> 1 A         3       0.357
#> 2 B         2       0.887
# Probability of belonging to several sets:
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
```

With fuzzy sets we can filter at certain levels (called alpha cut):

``` r
fuzzy_set %>% 
  filter(fuzzy > 0.5) %>% 
  activate("sets") %>% 
  mutate(sets_origin = c("Reactome", "KEGG"))
#>   elements sets     fuzzy sets_origin
#> 1        c    A 0.8152075    Reactome
#> 2        d    A 0.5800610    Reactome
#> 3        e    A 0.5724973    Reactome
#> 4        a    B 0.9381182        KEGG
#> 5        f    B 0.9460158        KEGG
```

# Related packages

There are several other packages related to sets, which partially
overlap with BaseSet functionality:

-   [sets](https://CRAN.R-project.org/package=sets)  
    Implements a more generalized approach, that can store functions or
    lists as an element of a set (while BaseSet only allows to store a
    character or factor), but it is harder to operate in a tidy/long
    way. Also the operations of intersection and union need to happen
    between two different objects, while a single TidySet object (the
    class implemented in BaseSet) can store one or thousands of sets.

-   [`{GSEABase}`](https://bioconductor.org/packages/GSEABase/)  
    Implements a class to store sets and related information, but it
    doesn’t allow to store fuzzy sets and it is also quite slow as it
    creates several classes for annotating each set.

-   [`{BiocSet}`](https://bioconductor.org/packages/BiocSet/)  
    Implements a tidy class for sets but does not handle fuzzy sets. It
    also has less functionality to operate with sets, like power sets
    and cartesian product. BiocSet was influenced by the development of
    this package.

-   [`{hierarchicalSets}`](https://CRAN.R-project.org/package=hierarchicalSets)  
    This package is focused on clustering of sets that are inside other
    sets and visualizations. However, BaseSet is focused on storing and
    manipulate sets including hierarchical sets.

-   [`{set6}`](https://cran.r-project.org/package=set6) This package
    implements different classes for different type of sets including
    fuzzy sets, conditional sets. However, it doesn’t handle information
    associated to elements, sets or relationship.

# Why this package?

On bioinformatics when looking for the impact of an experiment
enrichment methods are applied. This involves obtaining several sets of
genes from several resources and methods. Usually these curated sets of
genes are taken at face value. However, there are several resources of
sets and they [do not agree between
them](https://doi.org/10.1186/1471-2105-14-112), regardless they are
used without considering any uncertainty on sets composition.

Fuzzy theory has long studied sets whose elements have degrees of
membership and/or uncertainty. Therefore one way to improve the methods
involve using fuzzy methods and logic on this field. As I couldn’t find
any package that provided methods for this I set on creating it (after
trying to [expand](https://github.com/llrs/GSEAdv) the existing one I
knew).

This package is intended to be easy to use for someone who is working
with collections of sets but flexible about the methods and logic it can
use. To be consistent, the standard fuzzy logic is the default but it
might not be the right one for your data. Consider changing the defaults
to match with the framework the data was obtained with.

# Code of Conduct

Please note that the BaseSet project is released with a [Contributor
Code of
Conduct](https://docs.ropensci.org/BaseSet/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
