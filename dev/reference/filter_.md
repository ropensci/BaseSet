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
[`group()`](https://docs.ropensci.org/BaseSet/dev/reference/group.md),
[`group_by.TidySet()`](https://docs.ropensci.org/BaseSet/dev/reference/group_by_.md),
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
    fuzzy = runif(12),
    type = c(rep("Gene", 4), rep("lncRNA", 2))
)
TS <- tidySet(relations)
TS <- move_to(TS, from = "relations", to = "elements", column = "type")
filter(TS, elements == "a")
#>   elements sets      fuzzy type
#> 1        a    a 0.85657500 Gene
#> 2        a   a2 0.04461716 Gene
# Equivalent to filter_relation
filter(TS, elements == "a", sets == "a")
#>   elements sets    fuzzy type
#> 1        a    a 0.856575 Gene
filter_relation(TS, elements == "a", sets == "a")
#>   elements sets    fuzzy type
#> 1        a    a 0.856575 Gene
# Filter element
filter_element(TS, type == "Gene")
#>   elements sets      fuzzy type
#> 1        a    a 0.85657500 Gene
#> 2        b    a 0.92654645 Gene
#> 3        c    a 0.55237759 Gene
#> 4        d    a 0.57706569 Gene
#> 5        a   a2 0.04461716 Gene
#> 6        b   a2 0.90985456 Gene
#> 7        c   a2 0.07068122 Gene
#> 8        d   a2 0.99689147 Gene
# Filter sets and by property of elements simultaneously
filter(TS, sets == "b", type == "lncRNA")
#>   elements sets     fuzzy   type
#> 1        f    b 0.2447182 lncRNA
# Filter sets
filter_set(TS, sets == "b")
#>   elements sets     fuzzy   type
#> 1        f    b 0.2447182 lncRNA
```
