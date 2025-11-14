# Name elements

Retrieve the name of the elements.

## Usage

``` r
name_elements(object, all, ...)

# S4 method for class 'TidySet,logical'
name_elements(object, all = TRUE)

# S4 method for class 'TidySet,missing'
name_elements(object, all)

# S4 method for class 'TidySet,logical,characterORfactor'
name_elements(object, all) <- value

# S4 method for class 'TidySet,missing,characterORfactor'
name_elements(object) <- value
```

## Arguments

- object:

  A TidySet object.

- all:

  A logical value if all elements should be reported or only those
  present.

- ...:

  Other arguments passed to methods.

- value:

  A character with the new names for the elements.

## Value

A `TidySet` object.

## Methods (by class)

- `name_elements(object = TidySet, all = logical)`: Name elements

- `name_elements(object = TidySet, all = missing)`: Name elements

- `name_elements(object = TidySet, all = logical) <- value`: Rename
  elements

- `name_elements(object = TidySet, all = missing) <- value`: Rename
  elements

## See also

Other names: `name_elements<-()`,
[`name_sets()`](https://docs.ropensci.org/BaseSet/dev/reference/name_sets.md),
`name_sets<-()`,
[`rename_elements()`](https://docs.ropensci.org/BaseSet/dev/reference/rename_elements.md),
[`rename_set()`](https://docs.ropensci.org/BaseSet/dev/reference/rename_set.md)

## Examples

``` r
relations <- data.frame(
    sets = c(rep("A", 5), "B"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
TS <- tidySet(relations)
name_elements(TS)
#> [1] "a" "b" "c" "d" "e" "f"
```
