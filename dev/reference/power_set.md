# Create the power set

Create the power set of the object: All the combinations of the elements
of the sets.

## Usage

``` r
power_set(object, set, name, ...)
```

## Arguments

- object:

  A TidySet object.

- set:

  The name of the set to be used for the power set, if not provided all
  are used.

- name:

  The root name of the new set, if not provided the standard notation
  "P()" is used.

- ...:

  Other arguments passed down if possible.

## Value

A TidySet object with the new set.

## See also

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
power_set(TS, "a", name = "power_set")
#>    elements           sets fuzzy
#> 1         a              a     1
#> 2         b              a     1
#> 3         c              a     1
#> 4         d              a     1
#> 5         e              a     1
#> 6         f              b     1
#> 7         a  power_set_1_1     1
#> 8         b  power_set_1_2     1
#> 9         c  power_set_1_3     1
#> 10        d  power_set_1_4     1
#> 11        e  power_set_1_5     1
#> 12        a  power_set_2_1     1
#> 13        b  power_set_2_1     1
#> 14        a  power_set_2_2     1
#> 15        c  power_set_2_2     1
#> 16        a  power_set_2_3     1
#> 17        d  power_set_2_3     1
#> 18        a  power_set_2_4     1
#> 19        e  power_set_2_4     1
#> 20        b  power_set_2_5     1
#> 21        c  power_set_2_5     1
#> 22        b  power_set_2_6     1
#> 23        d  power_set_2_6     1
#> 24        b  power_set_2_7     1
#> 25        e  power_set_2_7     1
#> 26        c  power_set_2_8     1
#> 27        d  power_set_2_8     1
#> 28        c  power_set_2_9     1
#> 29        e  power_set_2_9     1
#> 30        d power_set_2_10     1
#> 31        e power_set_2_10     1
#> 32        a  power_set_3_1     1
#> 33        b  power_set_3_1     1
#> 34        c  power_set_3_1     1
#> 35        a  power_set_3_2     1
#> 36        b  power_set_3_2     1
#> 37        d  power_set_3_2     1
#> 38        a  power_set_3_3     1
#> 39        b  power_set_3_3     1
#> 40        e  power_set_3_3     1
#> 41        a  power_set_3_4     1
#> 42        c  power_set_3_4     1
#> 43        d  power_set_3_4     1
#> 44        a  power_set_3_5     1
#> 45        c  power_set_3_5     1
#> 46        e  power_set_3_5     1
#> 47        a  power_set_3_6     1
#> 48        d  power_set_3_6     1
#> 49        e  power_set_3_6     1
#> 50        b  power_set_3_7     1
#> 51        c  power_set_3_7     1
#> 52        d  power_set_3_7     1
#> 53        b  power_set_3_8     1
#> 54        c  power_set_3_8     1
#> 55        e  power_set_3_8     1
#> 56        b  power_set_3_9     1
#> 57        d  power_set_3_9     1
#> 58        e  power_set_3_9     1
#> 59        c power_set_3_10     1
#> 60        d power_set_3_10     1
#> 61        e power_set_3_10     1
#> 62        a  power_set_4_1     1
#> 63        b  power_set_4_1     1
#> 64        c  power_set_4_1     1
#> 65        d  power_set_4_1     1
#> 66        a  power_set_4_2     1
#> 67        b  power_set_4_2     1
#> 68        c  power_set_4_2     1
#> 69        e  power_set_4_2     1
#> 70        a  power_set_4_3     1
#> 71        b  power_set_4_3     1
#> 72        d  power_set_4_3     1
#> 73        e  power_set_4_3     1
#> 74        a  power_set_4_4     1
#> 75        c  power_set_4_4     1
#> 76        d  power_set_4_4     1
#> 77        e  power_set_4_4     1
#> 78        b  power_set_4_5     1
#> 79        c  power_set_4_5     1
#> 80        d  power_set_4_5     1
#> 81        e  power_set_4_5     1
```
