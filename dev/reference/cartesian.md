# Create the cartesian product of two sets

Given two sets creates new sets with one element of each set

## Usage

``` r
cartesian(object, set1, set2, name = NULL, ...)

# S3 method for class 'TidySet'
cartesian(
  object,
  set1,
  set2,
  name = NULL,
  keep = TRUE,
  keep_relations = keep,
  keep_elements = keep,
  keep_sets = keep,
  ...
)
```

## Arguments

- object:

  A TidySet object.

- set1, set2:

  The name of the sets to be used for the cartesian product

- name:

  The name of the new set.

- ...:

  Placeholder for other arguments that could be passed to the method.
  Currently not used.

- keep:

  A logical value if you want to keep.

- keep_relations:

  A logical value if you wan to keep old relations.

- keep_elements:

  A logical value if you wan to keep old elements.

- keep_sets:

  A logical value if you wan to keep old sets.

## Value

A TidySet object with the new set

## See also

Other methods:
[`TidySet-class`](https://docs.ropensci.org/BaseSet/dev/reference/TidySet-class.md),
[`activate()`](https://docs.ropensci.org/BaseSet/dev/reference/activate.md),
[`add_column()`](https://docs.ropensci.org/BaseSet/dev/reference/add_column.md),
[`add_relation()`](https://docs.ropensci.org/BaseSet/dev/reference/add_relation.md),
[`arrange.TidySet()`](https://docs.ropensci.org/BaseSet/dev/reference/arrange_.md),
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
    sets = c(rep("a", 5), "b"),
    elements = letters[seq_len(6)]
)
TS <- tidySet(relations)
cartesian(TS, "a", "b")
#>    elements  sets fuzzy
#> 1         a     a     1
#> 2         b     a     1
#> 3         c     a     1
#> 4         d     a     1
#> 5         e     a     1
#> 6         f     b     1
#> 7         a a⨯b_1     1
#> 8         f a⨯b_1     1
#> 9         b a⨯b_2     1
#> 10        f a⨯b_2     1
#> 11        c a⨯b_3     1
#> 12        f a⨯b_3     1
#> 13        d a⨯b_4     1
#> 14        f a⨯b_4     1
#> 15        e a⨯b_5     1
#> 16        f a⨯b_5     1
#> 17        a   a⨯b     1
#> 18        f   a⨯b     1
#> 19        b   a⨯b     1
#> 20        c   a⨯b     1
#> 21        d   a⨯b     1
#> 22        e   a⨯b     1
```
