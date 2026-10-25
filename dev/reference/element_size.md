# Calculates the size of the elements

Assuming that the fuzzy values are probabilities, calculates the
probability of being of different sizes for a given set.

## Usage

``` r
element_size(object, elements = NULL)

# S4 method for class 'TidySet'
element_size(object, elements = NULL)
```

## Arguments

- object:

  A TidySet object.

- elements:

  The element from which the length is calculated.

## Value

A list with the size of the elements or the probability of having that
size.

## Methods (by class)

- `element_size(TidySet)`: Calculates the number of sets an element
  appears with
  [`length_set()`](https://docs.ropensci.org/BaseSet/dev/reference/length_set.md)

## See also

cardinality

Other sizes:
[`set_size()`](https://docs.ropensci.org/BaseSet/dev/reference/set_size.md)

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
[`name_elements<-()`](https://docs.ropensci.org/BaseSet/dev/reference/name_elements-set.md),
[`name_sets()`](https://docs.ropensci.org/BaseSet/dev/reference/name_sets.md),
[`name_sets<-()`](https://docs.ropensci.org/BaseSet/dev/reference/name_sets-set.md),
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
    sets = c(rep("A", 5), "B", "C"),
    elements = c(letters[seq_len(6)], letters[6]),
    fuzzy = runif(7)
)
a <- tidySet(relations)
element_size(a)
#>    elements size probability
#> 1         a    0   0.4400872
#> 2         a    1   0.5599128
#> 3         b    0   0.1429164
#> 4         b    1   0.8570836
#> 5         c    0   0.6151903
#> 6         c    1   0.3848097
#> 7         d    0   0.4720830
#> 8         d    1   0.5279170
#> 9         e    0   0.3993625
#> 10        e    1   0.6006375
#> 11        f    0   0.5243893
#> 12        f    1   0.3997999
#> 13        f    2   0.0758108
```
