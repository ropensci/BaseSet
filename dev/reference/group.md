# Create a new set from existing elements

It allows to create a new set given some condition. If no element meet
the condition an empty set is created.

## Usage

``` r
group(object, name, ...)

# S3 method for class 'TidySet'
group(object, name, ...)
```

## Arguments

- object:

  A TidySet object.

- name:

  The name of the new set.

- ...:

  A logical condition to subset some elements.

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
x <- list("A" = c("a" = 0.1, "b" = 0.5), "B" = c("a" = 0.2, "b" = 1))
TS <- tidySet(x)
TS1 <- group(TS, "C", fuzzy < 0.5)
TS1
#>   elements sets fuzzy
#> 1        a    A   0.1
#> 2        b    A   0.5
#> 3        a    B   0.2
#> 4        b    B   1.0
#> 5        a    C   1.0
sets(TS1)
#>   sets
#> 1    A
#> 2    B
#> 3    C
TS2 <- group(TS, "D", fuzzy < 0)
sets(TS2)
#>   sets
#> 1    A
#> 2    B
#> 3    D
r <- data.frame(
    sets = c(rep("A", 5), "B", rep("A2", 5), "B2"),
    elements = rep(letters[seq_len(6)], 2),
    fuzzy = runif(12),
    type = c(rep("Gene", 2), rep("Protein", 2), rep("lncRNA", 2))
)
TS3 <- tidySet(r)
group(TS3, "D", sets %in% c("A", "A2"))
#>    elements sets      fuzzy    type
#> 1         a    A 0.02795603    Gene
#> 2         b    A 0.46938430    Gene
#> 3         c    A 0.80568003 Protein
#> 4         d    A 0.81405131 Protein
#> 5         e    A 0.40391100  lncRNA
#> 6         f    B 0.21843101  lncRNA
#> 7         a   A2 0.41836140    Gene
#> 8         b   A2 0.66887075    Gene
#> 9         c   A2 0.50765028 Protein
#> 10        d   A2 0.66035931 Protein
#> 11        e   A2 0.51179131  lncRNA
#> 12        f   B2 0.83555244  lncRNA
#> 13        a    D 1.00000000    <NA>
#> 14        b    D 1.00000000    <NA>
#> 15        c    D 1.00000000    <NA>
#> 16        d    D 1.00000000    <NA>
#> 17        e    D 1.00000000    <NA>
```
