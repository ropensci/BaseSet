# BaseSet 1.0.0

* Now it is possible to list sets and elements that are not present in the relations but might be on the object via its factors: `name_sets()`, `name_elements()`, `nElements()` and `nSets()` gain a `all` argument.
* Fix a problem with `$<-` when the length did match a slot but the name didn't.
* Now it is possible to use sets and elements to subset a TidySet (but not for 
 relations).
* New `dimnames()` and `names()` functions to discover the names of the data in 
 the slots.
* Minor changes to `getGAF()` to improve speed.
* Increase R version dependency to 4.1 to remove magrittr dependency. 

# BaseSet 0.9.0

* `tidy()` now defaults to `tidySet()`.
* New function `union_closed()`.
* Make more robust the code to unwanted dimensions drops. 
* `power_set()` returns also the sets of size 1 and have better names by default.
* Extractors `[`, `$`, `[[` and setters `[<-`, `$<-`, `[[<-` now work for 
TidySets: 
    - `i` indicates rows, 
    - `j` either "relations", "sets" or "elements"
    - `k` the columns of the slot.  
    
  However `TS[["A"]]` extracts set "A" and replacing it via `[[<-` will remove 
  it.
* Completion of `$` works. 
* `length()` returns the number of sets (to complete `ncol` and `nrow`).
* `lengths()` returns the number of relations for each set. 

# BaseSet 0.0.17

* Fixing test when missing a package. 
* Adding copyright holder.

# BaseSet 0.0.16

* Update Code of Conduct to rOpenSci template
* Fix NOTE about LazyData

# BaseSet 0.0.15

* Upgrade R version requirements
* Fix some links
* Make sure that vignettes run when the Bioconductor packages are available

# BaseSet 0.0.14

* Remove unused dependency to BiocStyle
* Fix unicode characters for windows

# BaseSet 0.0.12

# BaseSet 0.0.0.9000

* Added a `NEWS.md` file to track changes to the package.
