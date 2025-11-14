# BaseSet: Working with Sets the Tidy Way

Implements a class and methods to work with sets, doing intersection,
union, complementary sets, power sets, cartesian product and other set
operations in a "tidy" way. These set operations are available for both
classical sets and fuzzy sets. Import sets from several formats or from
other several data structures.

## Details

It provides a class
[`TidySet`](https://docs.ropensci.org/BaseSet/dev/reference/TidySet-class.md)
with methods to do operations with sets.

## See also

Useful links:

- <https://github.com/ropensci/BaseSet>

- <https://docs.ropensci.org/BaseSet/>

- Report bugs at <https://github.com/ropensci/BaseSet/issues>

## Author

**Maintainer**: Lluís Revilla Sancho <lluis.revilla@gmail.com>
([ORCID](https://orcid.org/0000-0001-9747-2570)) \[copyright holder\]

Other contributors:

- Zebulun Arendsee \[reviewer\]

- Jennifer Chang \[reviewer\]

## Examples

``` r
set <- list("A" = letters[1:5], "B" = letters[4:7])
TS <- tidySet(set)
cardinality(TS)
#>   sets cardinality
#> 1    A           5
#> 2    B           4
intersection(TS, c("A", "B"))
#>   elements sets fuzzy
#> 1        d  A∩B     1
#> 2        e  A∩B     1
```
