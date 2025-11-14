# Changelog

## BaseSet (development version)

- Fixed issue with
  [`getGAF()`](https://docs.ropensci.org/BaseSet/dev/reference/getGAF.md)
  when all optional columns are present.

## BaseSet 1.0.0

CRAN release: 2025-02-17

- Now it is possible to list sets and elements that are not present in
  the relations but might be on the object via its factors:
  [`name_sets()`](https://docs.ropensci.org/BaseSet/dev/reference/name_sets.md),
  [`name_elements()`](https://docs.ropensci.org/BaseSet/dev/reference/name_elements.md),
  [`nElements()`](https://docs.ropensci.org/BaseSet/dev/reference/nElements.md)
  and
  [`nSets()`](https://docs.ropensci.org/BaseSet/dev/reference/nSets.md)
  gain a `all` argument.
- Fix a problem with `$<-` when the length did match a slot but the name
  didn’t.
- Now it is possible to use sets and elements to subset a TidySet (but
  not for relations).
- New [`dimnames()`](https://rdrr.io/r/base/dimnames.html) and
  [`names()`](https://rdrr.io/r/base/names.html) functions to discover
  the names of the data in the slots.
- Minor changes to
  [`getGAF()`](https://docs.ropensci.org/BaseSet/dev/reference/getGAF.md)
  to improve speed.
- Increase R version dependency to 4.1 to remove magrittr dependency.

## BaseSet 0.9.0

CRAN release: 2023-08-22

- `tidy()` now defaults to
  [`tidySet()`](https://docs.ropensci.org/BaseSet/dev/reference/tidySet.md).
- New function
  [`union_closed()`](https://docs.ropensci.org/BaseSet/dev/reference/union_closed.md).
- Make more robust the code to unwanted dimensions drops.
- [`power_set()`](https://docs.ropensci.org/BaseSet/dev/reference/power_set.md)
  returns also the sets of size 1 and have better names by default.
- Extractors `[`, `$`, `[[` and setters `[<-`, `$<-`, `[[<-` now work
  for TidySets:
  - `i` indicates rows,
  - `j` either “relations”, “sets” or “elements”
  - `k` the columns of the slot.

  However `TS[["A"]]` extracts set “A” and replacing it via `[[<-` will
  remove it.
- Completion of `$` works.
- [`length()`](https://rdrr.io/r/base/length.html) returns the number of
  sets (to complete `ncol` and `nrow`).
- [`lengths()`](https://rdrr.io/r/base/lengths.html) returns the number
  of relations for each set.

## BaseSet 0.0.17

CRAN release: 2021-07-05

- Fixing test when missing a package.
- Adding copyright holder.

## BaseSet 0.0.16

CRAN release: 2021-04-22

- Update Code of Conduct to rOpenSci template
- Fix NOTE about LazyData

## BaseSet 0.0.15

CRAN release: 2021-03-20

- Upgrade R version requirements
- Fix some links
- Make sure that vignettes run when the Bioconductor packages are
  available

## BaseSet 0.0.14

CRAN release: 2020-11-11

- Remove unused dependency to BiocStyle
- Fix unicode characters for windows

## BaseSet 0.0.12

## BaseSet 0.0.0.9000

- Added a `NEWS.md` file to track changes to the package.
