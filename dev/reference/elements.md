# Elements of the TidySet

Given TidySet retrieve the elements or substitute them.

## Usage

``` r
elements(object)

elements(object) <- value

# S4 method for class 'TidySet'
elements(object)

# S4 method for class 'TidySet'
elements(object) <- value

replace_elements(object, value)

# S4 method for class 'TidySet,missing'
nElements(object)

# S4 method for class 'TidySet,logical'
nElements(object, all)
```

## Arguments

- object:

  A TidySet object.

- value:

  Modification of the elements.

- all:

  A logical value to count all elements or just those present.

## Value

A `data.frame` with information about the elements

## Methods (by class)

- `elements(TidySet)`: Retrieve the elements

- `elements(TidySet) <- value`: Modify the elements

- `nElements(object = TidySet, all = missing)`: Return the number of
  elements

- `nElements(object = TidySet, all = logical)`: Return the number of
  elements

## See also

[`nElements()`](https://docs.ropensci.org/BaseSet/dev/reference/nElements.md)

Other slots:
[`relations()`](https://docs.ropensci.org/BaseSet/dev/reference/relations.md),
[`sets()`](https://docs.ropensci.org/BaseSet/dev/reference/sets.md)

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
TS <- tidySet(list(A = letters[1:5], B = letters[2:10]))
elements(TS)
#>    elements
#> 1         a
#> 2         b
#> 3         c
#> 4         d
#> 5         e
#> 6         f
#> 7         g
#> 8         h
#> 9         i
#> 10        j
elements(TS) <- data.frame(elements = letters[10:1])
TS2 <- replace_elements(TS, data.frame(elements = letters[1:11]))
nElements(TS)
#> [1] 10
nElements(TS2)
#> [1] 11
```
