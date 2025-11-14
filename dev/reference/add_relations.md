# Add relations to a TidySet

Adds new relations to existing or new sets and elements. If the sets or
elements do not exist they are added.

## Usage

``` r
add_relations(object, elements, sets, fuzzy, ...)
```

## Arguments

- object:

  A
  [`TidySet`](https://docs.ropensci.org/BaseSet/dev/reference/TidySet-class.md)
  object

- elements:

  A character vector of the elements.

- sets:

  A character vector of sets to be added.

- fuzzy:

  The strength of the membership.

- ...:

  Placeholder for other arguments that could be passed to the method.
  Currently not used.

## Value

A
[`TidySet`](https://docs.ropensci.org/BaseSet/dev/reference/TidySet-class.md)
object with the new relations.

## Note

`add_relations` doesn't set up any other information about the
relationship. Remember to add/modify them if needed with
[`mutate`](https://dplyr.tidyverse.org/reference/mutate.html) or
[`mutate_relation`](https://docs.ropensci.org/BaseSet/dev/reference/mutate_.md)

## See also

[`add_relation()`](https://docs.ropensci.org/BaseSet/dev/reference/add_relation.md)
to add relations with new sets or/and new elements.

Other add\_\*:
[`add_elements()`](https://docs.ropensci.org/BaseSet/dev/reference/add_elements.md),
[`add_sets()`](https://docs.ropensci.org/BaseSet/dev/reference/add_sets.md)

## Examples

``` r
x <- list("a" = letters[1:5], "b" = LETTERS[3:7])
a <- tidySet(x)
add_relations(a, elements = c("a", "b", "g"), sets = "d")
#>    elements sets fuzzy
#> 1         a    a     1
#> 2         b    a     1
#> 3         c    a     1
#> 4         d    a     1
#> 5         e    a     1
#> 6         C    b     1
#> 7         D    b     1
#> 8         E    b     1
#> 9         F    b     1
#> 10        G    b     1
#> 11        a    d     1
#> 12        b    d     1
#> 13        g    d     1
add_relations(a, elements = c("a", "b"), sets = c("d", "g"))
#>    elements sets fuzzy
#> 1         a    a     1
#> 2         b    a     1
#> 3         c    a     1
#> 4         d    a     1
#> 5         e    a     1
#> 6         C    b     1
#> 7         D    b     1
#> 8         E    b     1
#> 9         F    b     1
#> 10        G    b     1
#> 11        a    d     1
#> 12        b    g     1
add_relations(a, elements = c("a", "b"), sets = c("d", "g"), fuzzy = 0.5)
#>    elements sets fuzzy
#> 1         a    a   1.0
#> 2         b    a   1.0
#> 3         c    a   1.0
#> 4         d    a   1.0
#> 5         e    a   1.0
#> 6         C    b   1.0
#> 7         D    b   1.0
#> 8         E    b   1.0
#> 9         F    b   1.0
#> 10        G    b   1.0
#> 11        a    d   0.5
#> 12        b    g   0.5
add_relations(a,
    elements = c("a", "b"), sets = c("d", "g"),
    fuzzy = c(0.5, 0.7)
)
#>    elements sets fuzzy
#> 1         a    a   1.0
#> 2         b    a   1.0
#> 3         c    a   1.0
#> 4         d    a   1.0
#> 5         e    a   1.0
#> 6         C    b   1.0
#> 7         D    b   1.0
#> 8         E    b   1.0
#> 9         F    b   1.0
#> 10        G    b   1.0
#> 11        a    d   0.5
#> 12        b    g   0.7
```
