# Complement of elements

Return the objects without the elements listed

## Usage

``` r
complement_element(object, elements, ...)

# S4 method for class 'TidySet,characterORfactor'
complement_element(
  object,
  elements,
  name = NULL,
  FUN = NULL,
  keep = TRUE,
  keep_relations = keep,
  keep_elements = keep,
  keep_sets = keep
)
```

## Arguments

- object:

  A TidySet object.

- elements:

  The set to look for the complement.

- ...:

  Placeholder for other arguments that could be passed to the method.
  Currently not used.

- name:

  Name of the new set. By default it adds a "C".

- FUN:

  A function to be applied when performing the union. The standard union
  is the "max" function, but you can provide any other function that
  given a numeric vector returns a single number.

- keep:

  Logical value to keep all the other sets.

- keep_relations:

  A logical value if you wan to keep old relations.

- keep_elements:

  A logical value if you wan to keep old elements.

- keep_sets:

  A logical value if you wan to keep old sets.

## Value

A `TidySet` object.

## Methods (by class)

- `complement_element(object = TidySet, elements = characterORfactor)`:
  Complement of the elements.

## See also

Other complements:
[`complement()`](https://docs.ropensci.org/BaseSet/reference/complement.md),
[`complement_set()`](https://docs.ropensci.org/BaseSet/reference/complement_set.md),
[`subtract()`](https://docs.ropensci.org/BaseSet/reference/subtract.md)

Other methods that create new sets:
[`complement_set()`](https://docs.ropensci.org/BaseSet/reference/complement_set.md),
[`intersection()`](https://docs.ropensci.org/BaseSet/reference/intersection.md),
[`subtract()`](https://docs.ropensci.org/BaseSet/reference/subtract.md),
[`union()`](https://docs.ropensci.org/BaseSet/reference/union.md)

Other methods:
[`TidySet-class`](https://docs.ropensci.org/BaseSet/reference/TidySet-class.md),
[`activate()`](https://docs.ropensci.org/BaseSet/reference/activate.md),
[`add_column()`](https://docs.ropensci.org/BaseSet/reference/add_column.md),
[`add_relation()`](https://docs.ropensci.org/BaseSet/reference/add_relation.md),
[`arrange.TidySet()`](https://docs.ropensci.org/BaseSet/reference/arrange_.md),
[`cartesian()`](https://docs.ropensci.org/BaseSet/reference/cartesian.md),
[`complement()`](https://docs.ropensci.org/BaseSet/reference/complement.md),
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
[`rename_set()`](https://docs.ropensci.org/BaseSet/reference/rename_set.md),
[`select.TidySet()`](https://docs.ropensci.org/BaseSet/reference/select_.md),
[`set_size()`](https://docs.ropensci.org/BaseSet/reference/set_size.md),
[`sets()`](https://docs.ropensci.org/BaseSet/reference/sets.md),
[`subtract()`](https://docs.ropensci.org/BaseSet/reference/subtract.md),
[`union()`](https://docs.ropensci.org/BaseSet/reference/union.md)

## Examples

``` r
relations <- data.frame(
    sets = c("A", "A", "B", "B", "C", "C"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
TS <- tidySet(relations)
complement_element(TS, "a", "C_a")
#>   elements sets     fuzzy
#> 1        a    A 0.3542068
#> 2        b    A 0.8251994
#> 3        c    B 0.2738182
#> 4        d    B 0.5700450
#> 5        e    C 0.3357191
#> 6        f    C 0.5962628
#> 7        a  C_a 0.6457932
complement_element(TS, "a", "C_a", keep = FALSE)
#>   elements sets     fuzzy
#> 1        a  C_a 0.6457932
```
