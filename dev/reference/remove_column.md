# Remove column

Removes column from a slot of the TidySet object.

## Usage

``` r
remove_column(object, slot, column_names)

# S4 method for class 'TidySet,character,character'
remove_column(object, slot, column_names)
```

## Arguments

- object:

  A TidySet object.

- slot:

  A TidySet slot.

- column_names:

  The name of the columns.

## Value

A `TidySet` object.

## Methods (by class)

- `remove_column(object = TidySet, slot = character, column_names = character)`:
  Remove columns to any slot

## See also

[`rename_set()`](https://docs.ropensci.org/BaseSet/dev/reference/rename_set.md)

Other column:
[`add_column()`](https://docs.ropensci.org/BaseSet/dev/reference/add_column.md)

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
x <- data.frame(sets = c(rep("A", 5), rep("B", 5)),
                elements = c(letters[1:5], letters[3:7]),
                extra = sample(c("YES", "NO"), 10, replace = TRUE))
TS <- tidySet(x)
TS
#>    elements sets extra fuzzy
#> 1         a    A    NO     1
#> 2         b    A    NO     1
#> 3         c    A    NO     1
#> 4         d    A    NO     1
#> 5         e    A    NO     1
#> 6         c    B    NO     1
#> 7         d    B    NO     1
#> 8         e    B   YES     1
#> 9         f    B    NO     1
#> 10        g    B   YES     1
remove_column(TS, "relations", "extra")
#>    elements sets fuzzy
#> 1         a    A     1
#> 2         b    A     1
#> 3         c    A     1
#> 4         d    A     1
#> 5         e    A     1
#> 6         c    B     1
#> 7         d    B     1
#> 8         e    B     1
#> 9         f    B     1
#> 10        g    B     1
```
