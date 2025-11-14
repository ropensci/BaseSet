# group_by TidySet

Use group_by to group the TidySet object. You can use activate with
group_by or with the whole data.

## Usage

``` r
# S3 method for class 'TidySet'
group_by(.data, ...)
```

## Arguments

- .data:

  The TidySet object

- ...:

  The logical predicates in terms of the variables of the sets

## Value

A grouped data.frame (See The dplyr help page)

## See also

[`dplyr::group_by()`](https://dplyr.tidyverse.org/reference/group_by.html)
and
[`activate()`](https://docs.ropensci.org/BaseSet/dev/reference/activate.md)

Other methods:
[`TidySet-class`](https://docs.ropensci.org/BaseSet/dev/reference/TidySet-class.md),
[`activate()`](https://docs.ropensci.org/BaseSet/dev/reference/activate.md),
[`add_column()`](https://docs.ropensci.org/BaseSet/dev/reference/add_column.md),
[`add_relation()`](https://docs.ropensci.org/BaseSet/dev/reference/add_relation.md),
[`arrange.TidySet()`](https://docs.ropensci.org/BaseSet/dev/reference/arrange_.md),
[`cartesian()`](https://docs.ropensci.org/BaseSet/dev/reference/cartesian.md),
[`complement()`](https://docs.ropensci.org/BaseSet/dev/reference/complement.md),
[`complement_element()`](https://docs.ropensci.org/BaseSet/dev/reference/complement_element.md),
[`complement_set()`](https://docs.ropensci.org/BaseSet/dev/reference/complement_set.md),
[`element_size()`](https://docs.ropensci.org/BaseSet/dev/reference/element_size.md),
[`elements()`](https://docs.ropensci.org/BaseSet/dev/reference/elements.md),
[`filter.TidySet()`](https://docs.ropensci.org/BaseSet/dev/reference/filter_.md),
[`group()`](https://docs.ropensci.org/BaseSet/dev/reference/group.md),
[`incidence()`](https://docs.ropensci.org/BaseSet/dev/reference/incidence.md),
[`intersection()`](https://docs.ropensci.org/BaseSet/dev/reference/intersection.md),
[`is.fuzzy()`](https://docs.ropensci.org/BaseSet/dev/reference/is.fuzzy.md),
[`is_nested()`](https://docs.ropensci.org/BaseSet/dev/reference/is_nested.md),
[`move_to()`](https://docs.ropensci.org/BaseSet/dev/reference/move_to.md),
[`mutate.TidySet()`](https://docs.ropensci.org/BaseSet/dev/reference/mutate_.md),
[`nElements()`](https://docs.ropensci.org/BaseSet/dev/reference/nElements.md),
[`nRelations()`](https://docs.ropensci.org/BaseSet/dev/reference/nRelations.md),
[`nSets()`](https://docs.ropensci.org/BaseSet/dev/reference/nSets.md),
`name_elements<-()`,
[`name_sets()`](https://docs.ropensci.org/BaseSet/dev/reference/name_sets.md),
`name_sets<-()`,
[`power_set()`](https://docs.ropensci.org/BaseSet/dev/reference/power_set.md),
[`pull.TidySet()`](https://docs.ropensci.org/BaseSet/dev/reference/pull_.md),
[`relations()`](https://docs.ropensci.org/BaseSet/dev/reference/relations.md),
[`remove_column()`](https://docs.ropensci.org/BaseSet/dev/reference/remove_column.md),
[`remove_element()`](https://docs.ropensci.org/BaseSet/dev/reference/remove_element.md),
[`remove_relation()`](https://docs.ropensci.org/BaseSet/dev/reference/remove_relation.md),
[`remove_set()`](https://docs.ropensci.org/BaseSet/dev/reference/remove_set.md),
[`rename_elements()`](https://docs.ropensci.org/BaseSet/dev/reference/rename_elements.md),
[`rename_set()`](https://docs.ropensci.org/BaseSet/dev/reference/rename_set.md),
[`select.TidySet()`](https://docs.ropensci.org/BaseSet/dev/reference/select_.md),
[`set_size()`](https://docs.ropensci.org/BaseSet/dev/reference/set_size.md),
[`sets()`](https://docs.ropensci.org/BaseSet/dev/reference/sets.md),
[`subtract()`](https://docs.ropensci.org/BaseSet/dev/reference/subtract.md),
[`union()`](https://docs.ropensci.org/BaseSet/dev/reference/union.md)

## Examples

``` r
relations <- data.frame(
    sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
    elements = rep(letters[seq_len(6)], 2),
    fuzzy = runif(12)
)
a <- tidySet(relations)
elements(a) <- cbind(elements(a),
    type = c(rep("Gene", 4), rep("lncRNA", 2))
)
group_by(a, elements)
#> # A tibble: 12 × 4
#> # Groups:   elements [6]
#>    elements sets    fuzzy type  
#>    <chr>    <chr>   <dbl> <chr> 
#>  1 a        a     0.711   Gene  
#>  2 b        a     0.215   Gene  
#>  3 c        a     0.292   Gene  
#>  4 d        a     0.722   Gene  
#>  5 e        a     0.867   lncRNA
#>  6 f        b     0.238   lncRNA
#>  7 a        a2    0.00450 Gene  
#>  8 b        a2    0.944   Gene  
#>  9 c        a2    0.438   Gene  
#> 10 d        a2    0.751   Gene  
#> 11 e        a2    0.668   lncRNA
#> 12 f        b2    0.408   lncRNA
```
