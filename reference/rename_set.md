# Rename sets

Change the default names of sets and elements.

## Usage

``` r
rename_set(object, old, new)

# S4 method for class 'TidySet'
rename_set(object, old, new)
```

## Arguments

- object:

  A TidySet object.

- old:

  A character vector of to be renamed.

- new:

  A character vector of with new names.

## Value

A `TidySet` object.

## Methods (by class)

- `rename_set(TidySet)`: Rename sets

## See also

[`name_sets()`](https://docs.ropensci.org/BaseSet/reference/name_sets.md)

Other renames:
[`rename_elements()`](https://docs.ropensci.org/BaseSet/reference/rename_elements.md)

Other names:
[`name_elements()`](https://docs.ropensci.org/BaseSet/reference/name_elements.md),
[`name_elements<-()`](https://docs.ropensci.org/BaseSet/reference/name_elements-set.md),
[`name_sets()`](https://docs.ropensci.org/BaseSet/reference/name_sets.md),
[`name_sets<-()`](https://docs.ropensci.org/BaseSet/reference/name_sets-set.md),
[`rename_elements()`](https://docs.ropensci.org/BaseSet/reference/rename_elements.md)

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
[`filter.TidySet()`](https://docs.ropensci.org/BaseSet/reference/filter_.md),
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
[`select.TidySet()`](https://docs.ropensci.org/BaseSet/reference/select_.md),
[`set_size()`](https://docs.ropensci.org/BaseSet/reference/set_size.md),
[`sets()`](https://docs.ropensci.org/BaseSet/reference/sets.md),
[`subtract()`](https://docs.ropensci.org/BaseSet/reference/subtract.md),
[`union()`](https://docs.ropensci.org/BaseSet/reference/union.md)

## Examples

``` r
x <- list("A" = letters[1:5], "B" = letters[3:7])
TS <- tidySet(x)
name_sets(TS)
#> [1] "A" "B"
TS2 <- rename_set(TS, "A", "C")
name_sets(TS2)
#> [1] "C" "B"
```
