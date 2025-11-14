# Convert to list

Converts a TidySet to a list.

## Usage

``` r
# S3 method for class 'TidySet'
as.list(x, ...)
```

## Arguments

- x:

  A TidySet object to be coerced to a list.

- ...:

  Placeholder for other arguments that could be passed to the method.
  Currently not used.

## Value

A list.

## Examples

``` r
r <- data.frame(sets = c("A", "A", "A", "B", "C"),
             elements = c(letters[1:3], letters[2:3]),
             fuzzy = runif(5),
             info = rep_len(c("important", "very important"), 5))
TS <- tidySet(r)
TS
#>   elements sets      fuzzy           info
#> 1        a    A 0.44670247      important
#> 2        b    A 0.37151118 very important
#> 3        c    A 0.02806097      important
#> 4        b    B 0.46598719 very important
#> 5        c    C 0.39003139      important
as.list(TS)
#> Warning: Dropping information on the coercion.
#> $A
#>          a          b          c 
#> 0.44670247 0.37151118 0.02806097 
#> 
#> $B
#>         b 
#> 0.4659872 
#> 
#> $C
#>         c 
#> 0.3900314 
#> 
```
