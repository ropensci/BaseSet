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
#>   elements sets     fuzzy           info
#> 1        a    A 0.9705209      important
#> 2        b    A 0.3891828 very important
#> 3        c    A 0.4611865      important
#> 4        b    B 0.3152418 very important
#> 5        c    C 0.1746759      important
as.list(TS)
#> Warning: Dropping information on the coercion.
#> $A
#>         a         b         c 
#> 0.9705209 0.3891828 0.4611865 
#> 
#> $B
#>         b 
#> 0.3152418 
#> 
#> $C
#>         c 
#> 0.1746759 
#> 
```
