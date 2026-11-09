# Remove a relation

Given a TidySet removes relations between elements and sets

## Usage

``` r
remove_relation(object, elements, sets, ...)

# S4 method for class 'TidySet,characterORfactor,characterORfactor'
remove_relation(object, elements, sets)
```

## Arguments

- object:

  A TidySet object

- elements:

  The elements of the sets.

- sets:

  The name of the new set.

- ...:

  Placeholder for other arguments that could be passed to the method.
  Currently not used.

## Value

A `TidySet` object.

## Methods (by class)

- `remove_relation( object = TidySet, elements = characterORfactor, sets = characterORfactor )`:
  Removes a relation between elements and sets.

## See also

Other remove functions:
[`remove_element()`](https://docs.ropensci.org/BaseSet/reference/remove_element.md),
[`remove_set()`](https://docs.ropensci.org/BaseSet/reference/remove_set.md)

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
    sets = c(rep("A", 5), "B"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
TS <- tidySet(relations)
remove_relation(TS, "A", "a")
#>   elements sets     fuzzy
#> 1        a    A 0.5898376
#> 2        b    A 0.7591584
#> 3        c    A 0.8360753
#> 4        d    A 0.7628195
#> 5        e    A 0.4172699
#> 6        f    B 0.1380748
```
