# Filter TidySet

Use filter to subset the TidySet object. You can use activate with
filter or use the specific function. The S3 method filters using all the
information on the TidySet.

## Usage

``` r
# S3 method for class 'TidySet'
filter(.data, ...)

filter_set(.data, ...)

filter_element(.data, ...)

filter_relation(.data, ...)
```

## Arguments

- .data:

  The TidySet object.

- ...:

  The logical predicates in terms of the variables of the sets.

## Value

A TidySet object.

## See also

[`dplyr::filter()`](https://dplyr.tidyverse.org/reference/filter.html)
and
[`activate()`](https://docs.ropensci.org/BaseSet/reference/activate.md)

Other methods:
[`TidySet-class`](https://docs.ropensci.org/BaseSet/reference/TidySet-class.md),
[`activate()`](https://docs.ropensci.org/BaseSet/reference/activate.md),
[`add_column()`](https://docs.ropensci.org/BaseSet/reference/add_column.md),
[`add_relation()`](https://docs.ropensci.org/BaseSet/reference/add_relation.md),
[`arrange.TidySet()`](https://docs.ropensci.org/BaseSet/reference/arrange_.md),
[`cartesian()`](https://docs.ropensci.org/BaseSet/reference/cartesian.md),
[`complement()`](https://docs.ropensci.org/BaseSet/reference/complement.md),
[`complement_element()`](https://docs.ropensci.org/BaseSet/reference/complement_element.md),
[`complement_set()`](https://docs.ropensci.org/BaseSet/reference/complement_set.md),
[`element_size()`](https://docs.ropensci.org/BaseSet/reference/element_size.md),
[`elements()`](https://docs.ropensci.org/BaseSet/reference/elements.md),
[`group()`](https://docs.ropensci.org/BaseSet/reference/group.md),
[`group_by.TidySet()`](https://docs.ropensci.org/BaseSet/reference/group_by_.md),
[`incidence()`](https://docs.ropensci.org/BaseSet/reference/incidence.md),
[`intersection()`](https://docs.ropensci.org/BaseSet/reference/intersection.md),
[`is.fuzzy()`](https://docs.ropensci.org/BaseSet/reference/is.fuzzy.md),
[`is_nested()`](https://docs.ropensci.org/BaseSet/reference/is_nested.md),
[`move_to()`](https://docs.ropensci.org/BaseSet/reference/move_to.md),
[`mutate.TidySet()`](https://docs.ropensci.org/BaseSet/reference/mutate_.md),
[`nElements()`](https://docs.ropensci.org/BaseSet/reference/nElements.md),
[`nRelations()`](https://docs.ropensci.org/BaseSet/reference/nRelations.md),
[`nSets()`](https://docs.ropensci.org/BaseSet/reference/nSets.md),
[`name_elements<-()`](https://docs.ropensci.org/BaseSet/reference/name_elements-set.md),
[`name_sets()`](https://docs.ropensci.org/BaseSet/reference/name_sets.md),
[`name_sets<-()`](https://docs.ropensci.org/BaseSet/reference/name_sets-set.md),
[`power_set()`](https://docs.ropensci.org/BaseSet/reference/power_set.md),
[`pull.TidySet()`](https://docs.ropensci.org/BaseSet/reference/pull_.md),
[`relations()`](https://docs.ropensci.org/BaseSet/reference/relations.md),
[`remove_column()`](https://docs.ropensci.org/BaseSet/reference/remove_column.md),
[`remove_element()`](https://docs.ropensci.org/BaseSet/reference/remove_element.md),
[`remove_relation()`](https://docs.ropensci.org/BaseSet/reference/remove_relation.md),
[`remove_set()`](https://docs.ropensci.org/BaseSet/reference/remove_set.md),
[`rename_elements()`](https://docs.ropensci.org/BaseSet/reference/rename_elements.md),
[`rename_set()`](https://docs.ropensci.org/BaseSet/reference/rename_set.md),
[`select.TidySet()`](https://docs.ropensci.org/BaseSet/reference/select_.md),
[`set_size()`](https://docs.ropensci.org/BaseSet/reference/set_size.md),
[`sets()`](https://docs.ropensci.org/BaseSet/reference/sets.md),
[`subtract()`](https://docs.ropensci.org/BaseSet/reference/subtract.md),
[`union()`](https://docs.ropensci.org/BaseSet/reference/union.md)

## Examples

``` r
relations <- data.frame(
    sets = c(rep("a", 5), "b", rep("a2", 5), "b2"),
    elements = rep(letters[seq_len(6)], 2),
    fuzzy = runif(12),
    type = c(rep("Gene", 4), rep("lncRNA", 2))
)
TS <- tidySet(relations)
TS <- move_to(TS, from = "relations", to = "elements", column = "type")
filter(TS, elements == "a")
#>   elements sets     fuzzy type
#> 1        a    a 0.4007202 Gene
#> 2        a   a2 0.5185566 Gene
# Equivalent to filter_relation
filter(TS, elements == "a", sets == "a")
#>   elements sets     fuzzy type
#> 1        a    a 0.4007202 Gene
filter_relation(TS, elements == "a", sets == "a")
#>   elements sets     fuzzy type
#> 1        a    a 0.4007202 Gene
# Filter element
filter_element(TS, type == "Gene")
#>   elements sets      fuzzy type
#> 1        a    a 0.40072018 Gene
#> 2        b    a 0.21317271 Gene
#> 3        c    a 0.67176682 Gene
#> 4        d    a 0.05861411 Gene
#> 5        a   a2 0.51855664 Gene
#> 6        b   a2 0.84612005 Gene
#> 7        c   a2 0.71826972 Gene
#> 8        d   a2 0.24131402 Gene
# Filter sets and by property of elements simultaneously
filter(TS, sets == "b", type == "lncRNA")
#>   elements sets     fuzzy   type
#> 1        f    b 0.1490355 lncRNA
# Filter sets
filter_set(TS, sets == "b")
#>   elements sets     fuzzy   type
#> 1        f    b 0.1490355 lncRNA
```
