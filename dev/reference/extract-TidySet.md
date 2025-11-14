# Extract

Operators acting on TidySet to extract or replace parts. They are
designed to resemble the basic operators.

## Usage

``` r
# S4 method for class 'TidySet'
x$name

# S4 method for class 'TidySet'
x$name <- value

# S4 method for class 'TidySet'
x[i, j, k, ..., drop = TRUE]

# S4 method for class 'TidySet'
x[i, j, k, ...] <- value

# S4 method for class 'TidySet'
x[[i, j, ..., exact = TRUE]]

# S4 method for class 'TidySet'
x[[i]] <- value
```

## Arguments

- x:

  A TidySet object.

- name:

  The data about the TidySet object to extract.

- value:

  The value to overwrite

- i:

  Which rows do you want to keep? By default all.

- j:

  Which slot do you want to extract? One of "sets", "elements" or
  "relations".

- k:

  Which columns do you want to extract. By default all.

- ...:

  Other arguments currently ignored.

- drop:

  Remove remaining elements, sets and relations? Passed to all arguments
  of [`droplevels()`](https://rdrr.io/r/base/droplevels.html).

- exact:

  A logical value. FALSE if fuzzy matching is wanted. Add values to the
  TidySet. Allows to control to which slot is it added.

## Value

Always returns a valid
[TidySet](https://docs.ropensci.org/BaseSet/dev/reference/TidySet-class.md).

## Examples

``` r
TS <- tidySet(list(A = letters[1:5], B = letters[6]))
TS[, "sets", "origin"] <- sample(c("random", "non-random"), 2, replace = TRUE)
TS[, "sets", "type"] <- c("Fantastic", "Wonderful")
# This produces a warning
# TS$description <- c("What", "can", "I", "say", "now", "?")
# Better to be explicit:
TS[, "relations", "description"] <- c("What", "can", "I", "say", "now", "?")
relations(TS)
#>   elements sets fuzzy description
#> 1        a    A     1        What
#> 2        b    A     1         can
#> 3        c    A     1           I
#> 4        d    A     1         say
#> 5        e    A     1         now
#> 6        f    B     1           ?
TS[, "elements", "description"] <- rev(c("What", "can", "I", "say", "now", "?"))
elements(TS)
#>   elements description
#> 1        a           ?
#> 2        b         now
#> 3        c         say
#> 4        d           I
#> 5        e         can
#> 6        f        What
# Which will be deleted?
# TS$description <- NULL
TS$type
#> [1] "Fantastic" "Wonderful"
TS$origin <- c("BCN", "BDN")
# Different subsets
TS[1, "elements"]
#>   elements sets fuzzy description origin      type description.elements
#> 1        a    A     1        What    BCN Fantastic                    ?
TS[1, "sets"]
#>   elements sets fuzzy description origin      type description.elements
#> 1        a    A     1        What    BCN Fantastic                    ?
#> 2        b    A     1         can    BCN Fantastic                  now
#> 3        c    A     1           I    BCN Fantastic                  say
#> 4        d    A     1         say    BCN Fantastic                    I
#> 5        e    A     1         now    BCN Fantastic                  can
# Always print
TS
#>   elements sets fuzzy description origin      type description.elements
#> 1        a    A     1        What    BCN Fantastic                    ?
#> 2        b    A     1         can    BCN Fantastic                  now
#> 3        c    A     1           I    BCN Fantastic                  say
#> 4        d    A     1         say    BCN Fantastic                    I
#> 5        e    A     1         now    BCN Fantastic                  can
#> 6        f    B     1           ?    BDN Wonderful                 What
TS[, "sets", c("type", "origin")] # Same
#>   elements sets fuzzy description      type origin description.elements
#> 1        a    A     1        What Fantastic    BCN                    ?
#> 2        b    A     1         can Fantastic    BCN                  now
#> 3        c    A     1           I Fantastic    BCN                  say
#> 4        d    A     1         say Fantastic    BCN                    I
#> 5        e    A     1         now Fantastic    BCN                  can
#> 6        f    B     1           ? Wonderful    BDN                 What
TS[, "sets", "origin"] # Drop column type
#>   elements sets fuzzy description origin description.elements
#> 1        a    A     1        What    BCN                    ?
#> 2        b    A     1         can    BCN                  now
#> 3        c    A     1           I    BCN                  say
#> 4        d    A     1         say    BCN                    I
#> 5        e    A     1         now    BCN                  can
#> 6        f    B     1           ?    BDN                 What
is(TS[, "sets", "origin"])
#> [1] "TidySet"
TS[, "sets"]
#>   elements sets fuzzy description origin      type description.elements
#> 1        a    A     1        What    BCN Fantastic                    ?
#> 2        b    A     1         can    BCN Fantastic                  now
#> 3        c    A     1           I    BCN Fantastic                  say
#> 4        d    A     1         say    BCN Fantastic                    I
#> 5        e    A     1         now    BCN Fantastic                  can
#> 6        f    B     1           ?    BDN Wonderful                 What
TS[["A"]]
#>   elements sets fuzzy description origin      type description.elements
#> 1        a    A     1        What    BCN Fantastic                    ?
#> 2        b    A     1         can    BCN Fantastic                  now
#> 3        c    A     1           I    BCN Fantastic                  say
#> 4        d    A     1         say    BCN Fantastic                    I
#> 5        e    A     1         now    BCN Fantastic                  can
TS[["B"]]
#>   elements sets fuzzy description origin      type description.elements
#> 1        f    B     1           ?    BDN Wonderful                 What
TS[["C"]] # Any other set is the empty set
#> [1] elements             sets                 fuzzy               
#> [4] description          origin               type                
#> [7] description.elements
#> <0 rows> (or 0-length row.names)
```
