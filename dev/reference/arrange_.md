# Arrange the order of a TidySet

Use arrange to extract the columns of a TidySet object. You can use
activate with filter or use the specific function. The S3 method filters
using all the information on the TidySet.

## Usage

``` r
# S3 method for class 'TidySet'
arrange(.data, ...)

arrange_set(.data, ...)

arrange_element(.data, ...)

arrange_relation(.data, ...)
```

## Arguments

- .data:

  The TidySet object

- ...:

  Comma separated list of variables names or expressions integer column
  position to be used to reorder the TidySet.

## Value

A TidySet object

## See also

[`dplyr::arrange()`](https://dplyr.tidyverse.org/reference/arrange.html)
and
[`activate()`](https://docs.ropensci.org/BaseSet/dev/reference/activate.md)

Other methods:
[`TidySet-class`](https://docs.ropensci.org/BaseSet/dev/reference/TidySet-class.md),
[`activate()`](https://docs.ropensci.org/BaseSet/dev/reference/activate.md),
[`add_column()`](https://docs.ropensci.org/BaseSet/dev/reference/add_column.md),
[`add_relation()`](https://docs.ropensci.org/BaseSet/dev/reference/add_relation.md),
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
    sets = c(rep("A", 5), "B", rep("A2", 5), "B2"),
    elements = rep(letters[seq_len(6)], 2),
    fuzzy = runif(12)
)
a <- tidySet(relations)
a <- mutate_element(a,
    type = c(rep("Gene", 4), rep("lncRNA", 2))
)

b <- arrange(a, desc(type))
elements(b)
#>   elements   type
#> 1        e lncRNA
#> 2        f lncRNA
#> 5        a   Gene
#> 6        b   Gene
#> 7        c   Gene
#> 8        d   Gene
b <- arrange_element(a, elements)
elements(b)
#>   elements   type
#> 1        a   Gene
#> 2        b   Gene
#> 3        c   Gene
#> 4        d   Gene
#> 5        e lncRNA
#> 6        f lncRNA
# Arrange sets
arrange_set(a, sets)
#>    elements sets      fuzzy   type
#> 1         a    A 0.20417834   Gene
#> 2         b    A 0.71339728   Gene
#> 3         c    A 0.06521611   Gene
#> 4         d    A 0.35420680   Gene
#> 5         e    A 0.82519942 lncRNA
#> 6         f    B 0.27381825 lncRNA
#> 7         a   A2 0.57004495   Gene
#> 8         b   A2 0.33571908   Gene
#> 9         c   A2 0.59626279   Gene
#> 10        d   A2 0.19151803   Gene
#> 11        e   A2 0.94776394 lncRNA
#> 12        f   B2 0.54248041 lncRNA
```
