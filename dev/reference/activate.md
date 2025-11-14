# Determine the context of subsequent manipulations.

Functions to help to perform some action to just some type of data:
elements, sets or relations. `activate`: To table the focus of future
manipulations: elements, sets or relations. `active`: To check the focus
on the `TidySet`. `deactivate`: To remove the focus on a specific
`TidySet`-

## Usage

``` r
activate(.data, what)

active(.data)

deactivate(.data)
```

## Arguments

- .data:

  A `TidySet` object.

- what:

  Either "elements", "sets" or "relations"

## Value

A `TidySet` object.

## See also

Other methods:
[`TidySet-class`](https://docs.ropensci.org/BaseSet/dev/reference/TidySet-class.md),
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
    fuzzy = runif(12)
)
a <- tidySet(relations)
elements(a) <- cbind(elements(a),
    type = c(rep("Gene", 4), rep("lncRNA", 2))
)
# Filter in the whole TidySet
filter(a, elements == "a")
#>   elements sets      fuzzy type
#> 1        a    a 0.49777739 Gene
#> 2        a   a2 0.03424133 Gene
filter(a, elements == "a", type == "Gene")
#>   elements sets      fuzzy type
#> 1        a    a 0.49777739 Gene
#> 2        a   a2 0.03424133 Gene
# Equivalent to filter_elements
filter_element(a, type == "Gene")
#>   elements sets      fuzzy type
#> 1        a    a 0.49777739 Gene
#> 2        b    a 0.28976724 Gene
#> 3        c    a 0.73288199 Gene
#> 4        d    a 0.77252151 Gene
#> 5        a   a2 0.03424133 Gene
#> 6        b   a2 0.32038573 Gene
#> 7        c   a2 0.40232824 Gene
#> 8        d   a2 0.19566983 Gene
a <- activate(a, "elements")
active(a)
#> [1] "elements"
filter(a, type == "Gene")
#>   elements sets      fuzzy type
#> 1        a    a 0.49777739 Gene
#> 2        b    a 0.28976724 Gene
#> 3        c    a 0.73288199 Gene
#> 4        d    a 0.77252151 Gene
#> 5        a   a2 0.03424133 Gene
#> 6        b   a2 0.32038573 Gene
#> 7        c   a2 0.40232824 Gene
#> 8        d   a2 0.19566983 Gene
a <- deactivate(a)
active(a)
#> NULL
filter(a, type == "Gene")
#>   elements sets      fuzzy type
#> 1        a    a 0.49777739 Gene
#> 2        b    a 0.28976724 Gene
#> 3        c    a 0.73288199 Gene
#> 4        d    a 0.77252151 Gene
#> 5        a   a2 0.03424133 Gene
#> 6        b   a2 0.32038573 Gene
#> 7        c   a2 0.40232824 Gene
#> 8        d   a2 0.19566983 Gene
```
