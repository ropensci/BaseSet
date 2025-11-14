# Join sets

Given a TidySet merges several sets into the new one using the logic
defined on FUN.

## Usage

``` r
union(object, ...)

# S3 method for class 'TidySet'
union(
  object,
  sets,
  name = NULL,
  FUN = "max",
  keep = FALSE,
  keep_relations = keep,
  keep_elements = keep,
  keep_sets = keep,
  ...
)
```

## Arguments

- object:

  A TidySet object.

- ...:

  Other named arguments passed to `FUN`.

- sets:

  The name of the sets to be used.

- name:

  The name of the new set. By defaults joins the sets with an ∩.

- FUN:

  A function to be applied when performing the union. The standard union
  is the "max" function, but you can provide any other function that
  given a numeric vector returns a single number.

- keep:

  A logical value if you want to keep.

- keep_relations:

  A logical value if you wan to keep old relations.

- keep_elements:

  A logical value if you wan to keep old elements.

- keep_sets:

  A logical value if you wan to keep old sets.

## Value

A `TidySet` object.

## Details

The default uses the `max` function following the [standard fuzzy
definition](https://en.wikipedia.org/wiki/Fuzzy_set_operations), but it
can be changed. See examples below.

## See also

[`union_probability()`](https://docs.ropensci.org/BaseSet/dev/reference/length_probability.md)

Other methods that create new sets:
[`complement_element()`](https://docs.ropensci.org/BaseSet/dev/reference/complement_element.md),
[`complement_set()`](https://docs.ropensci.org/BaseSet/dev/reference/complement_set.md),
[`intersection()`](https://docs.ropensci.org/BaseSet/dev/reference/intersection.md),
[`subtract()`](https://docs.ropensci.org/BaseSet/dev/reference/subtract.md)

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
[`remove_column()`](https://docs.ropensci.org/BaseSet/dev/reference/remove_column.md),
[`remove_element()`](https://docs.ropensci.org/BaseSet/dev/reference/remove_element.md),
[`remove_relation()`](https://docs.ropensci.org/BaseSet/dev/reference/remove_relation.md),
[`remove_set()`](https://docs.ropensci.org/BaseSet/dev/reference/remove_set.md),
[`rename_elements()`](https://docs.ropensci.org/BaseSet/dev/reference/rename_elements.md),
[`rename_set()`](https://docs.ropensci.org/BaseSet/dev/reference/rename_set.md),
[`select.TidySet()`](https://docs.ropensci.org/BaseSet/dev/reference/select_.md),
[`set_size()`](https://docs.ropensci.org/BaseSet/dev/reference/set_size.md),
[`sets()`](https://docs.ropensci.org/BaseSet/dev/reference/sets.md),
[`subtract()`](https://docs.ropensci.org/BaseSet/dev/reference/subtract.md)

## Examples

``` r
# Classical set
rel <- data.frame(
    sets = c(rep("A", 5), "B", "B"),
    elements = c(letters[seq_len(6)], "a")
)
TS <- tidySet(rel)
union(TS, c("B", "A"))
#> Error in as.vector(x): no method for coercing this S4 class to a vector
# Fuzzy set
rel <- data.frame(
    sets = c(rep("A", 5), "B", "B"),
    elements = c(letters[seq_len(6)], "a"),
    fuzzy = runif(7)
)
TS2 <- tidySet(rel)
# Standard default logic
union(TS2, c("B", "A"), "C")
#> Error in base::union(x, y, ...): unused argument ("C")
# Probability logic
union(TS2, c("B", "A"), "C", FUN = union_probability)
#> Error in base::union(x, y, ...): unused arguments ("C", FUN = function (p) 
#> {
#>     l <- length(p)
#>     if (l == 1) {
#>         return(p)
#>     }
#>     n <- vapply(seq_len(l)[-1], function(x) {
#>         sum(combn(seq_along(p), x, FUN = independent_probabilities, p = p))
#>     }, numeric(1))
#>     sum(p) + sum(rep(c(-1, 1), length.out = length(n)) * n)
#> })
```
