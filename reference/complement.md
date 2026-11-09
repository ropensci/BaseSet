# Complement TidySet

Use complement to find elements or sets the TidySet object. You can use
activate with complement or use the specific function. You must specify
if you want the complements of sets or elements.

## Usage

``` r
complement(.data, ...)
```

## Arguments

- .data:

  The TidySet object

- ...:

  Other arguments passed to either
  [`complement_set()`](https://docs.ropensci.org/BaseSet/reference/complement_set.md)
  or
  [`complement_element()`](https://docs.ropensci.org/BaseSet/reference/complement_element.md).

## Value

A TidySet object

## See also

[`activate()`](https://docs.ropensci.org/BaseSet/reference/activate.md)

Other complements:
[`complement_element()`](https://docs.ropensci.org/BaseSet/reference/complement_element.md),
[`complement_set()`](https://docs.ropensci.org/BaseSet/reference/complement_set.md),
[`subtract()`](https://docs.ropensci.org/BaseSet/reference/subtract.md)

Other methods:
[`TidySet-class`](https://docs.ropensci.org/BaseSet/reference/TidySet-class.md),
[`activate()`](https://docs.ropensci.org/BaseSet/reference/activate.md),
[`add_column()`](https://docs.ropensci.org/BaseSet/reference/add_column.md),
[`add_relation()`](https://docs.ropensci.org/BaseSet/reference/add_relation.md),
[`arrange.TidySet()`](https://docs.ropensci.org/BaseSet/reference/arrange_.md),
[`cartesian()`](https://docs.ropensci.org/BaseSet/reference/cartesian.md),
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
[`rename_set()`](https://docs.ropensci.org/BaseSet/reference/rename_set.md),
[`select.TidySet()`](https://docs.ropensci.org/BaseSet/reference/select_.md),
[`set_size()`](https://docs.ropensci.org/BaseSet/reference/set_size.md),
[`sets()`](https://docs.ropensci.org/BaseSet/reference/sets.md),
[`subtract()`](https://docs.ropensci.org/BaseSet/reference/subtract.md),
[`union()`](https://docs.ropensci.org/BaseSet/reference/union.md)

## Examples

``` r
rel <- data.frame(
    sets = c("A", "A", "B", "B", "C", "C"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
TS <- tidySet(rel)
TS |>
    activate("elements") |>
    complement("a")
#>   elements sets      fuzzy
#> 1        a    A 0.53157354
#> 2        b    A 0.49363702
#> 3        c    B 0.77930863
#> 4        d    B 0.20417834
#> 5        e    C 0.71339728
#> 6        f    C 0.06521611
#> 7        a   ∁a 0.46842646
TS |>
    activate("elements") |>
    complement("a", "C_a", keep = FALSE)
#>   elements sets     fuzzy
#> 1        a  C_a 0.4684265
TS |>
    activate("set") |>
    complement("A")
#>   elements sets      fuzzy
#> 1        a    A 0.53157354
#> 2        b    A 0.49363702
#> 3        c    B 0.77930863
#> 4        d    B 0.20417834
#> 5        e    C 0.71339728
#> 6        f    C 0.06521611
#> 7        a   ∁A 0.46842646
#> 8        b   ∁A 0.50636298
TS |>
    activate("set") |>
    complement("A", keep = FALSE)
#>   elements sets     fuzzy
#> 1        a   ∁A 0.4684265
#> 2        b   ∁A 0.5063630
TS |>
    activate("set") |>
    complement("A", FUN = function(x){abs(x - 0.2)}, keep = FALSE)
#>   elements sets     fuzzy
#> 1        a   ∁A 0.3315735
#> 2        b   ∁A 0.2936370
```
