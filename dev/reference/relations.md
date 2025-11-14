# Relations of the TidySet

Given TidySet retrieve the relations or substitute them.
[`TidySet()`](https://docs.ropensci.org/BaseSet/dev/reference/TidySet-class.md)
object

## Usage

``` r
relations(object)

relations(object) <- value

# S4 method for class 'TidySet'
relations(object)

replace_relations(object, value)

# S4 method for class 'TidySet'
relations(object) <- value

# S4 method for class 'TidySet'
nRelations(object)
```

## Arguments

- object:

  Object to be coerced or tested.

- value:

  Modification of the relations.

## Value

A `data.frame` with information about the relations between elements and
sets.

## Methods (by class)

- `relations(TidySet)`: Retrieve the relations

- `relations(TidySet) <- value`: Modify the relations

- `nRelations(TidySet)`: Return the number of unique relations

## See also

[`nRelations()`](https://docs.ropensci.org/BaseSet/dev/reference/nRelations.md)

Other slots:
[`elements()`](https://docs.ropensci.org/BaseSet/dev/reference/elements.md),
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
TS <- tidySet(list(A = letters[1:2], B = letters[5:7]))
relations(TS)
#>   elements sets fuzzy
#> 1        a    A     1
#> 2        b    A     1
#> 3        e    B     1
#> 4        f    B     1
#> 5        g    B     1
```
