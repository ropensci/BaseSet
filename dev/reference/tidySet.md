# Create a TidySet object

These functions help to create a `TidySet` object from `data.frame`,
`list`, `matrix`, and `GO3AnnDbBimap`. They can create both fuzzy and
standard sets.

## Usage

``` r
# S3 method for class 'GeneSetCollection'
tidySet(relations)

# S3 method for class 'GeneColorSet'
tidySet(relations)

# S3 method for class 'GeneSet'
tidySet(relations)

tidySet(relations)

# S3 method for class 'data.frame'
tidySet(relations)

# S3 method for class 'list'
tidySet(relations)

# S3 method for class 'matrix'
tidySet(relations)

# S3 method for class 'Go3AnnDbBimap'
tidySet(relations)

# S3 method for class 'TidySet'
tidySet(relations)
```

## Arguments

- relations:

  An object to be coerced to a TidySet.

## Value

A TidySet object.

## Details

Elements or sets without any relation are not shown when printed.

## Methods (by class)

- `tidySet(GeneSetCollection)`: Converts to a tidySet given a
  GeneSetCollection

- `tidySet(GeneColorSet)`: Converts to a tidySet given a GeneColorSet

- `tidySet(GeneSet)`: Converts to a tidySet given a GeneSet

- `tidySet(data.frame)`: Given the relations in a data.frame

- `tidySet(list)`: Convert to a TidySet from a list.

- `tidySet(matrix)`: Convert an incidence matrix into a TidySet

- `tidySet(Go3AnnDbBimap)`: Convert Go3AnnDbBimap into a TidySet object.

- `tidySet(TidySet)`: Convert TidySet into a TidySet object.

## See also

[`TidySet`](https://docs.ropensci.org/BaseSet/dev/reference/TidySet-class.md)

## Examples

``` r
# Needs GSEABase package from Bioconductor
if (requireNamespace("GSEABase", quietly = TRUE)) {
    library("GSEABase")
    gs <- GeneSet()
    gs
    tidySet(gs)
    fl <- system.file("extdata", "Broad.xml", package="GSEABase")
    gs2 <- getBroadSets(fl) # actually, a list of two gene sets
    TS <- tidySet(gs2)
    dim(TS)
    sets(TS)
}
#> Loading required package: BiocGenerics
#> Loading required package: generics
#> 
#> Attaching package: ‘generics’
#> The following object is masked from ‘package:BaseSet’:
#> 
#>     union
#> The following objects are masked from ‘package:base’:
#> 
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#> 
#> Attaching package: ‘BiocGenerics’
#> The following objects are masked from ‘package:stats’:
#> 
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from ‘package:base’:
#> 
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: Biobase
#> Welcome to Bioconductor
#> 
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#> Loading required package: annotate
#> Loading required package: AnnotationDbi
#> Loading required package: stats4
#> Loading required package: IRanges
#> Loading required package: S4Vectors
#> 
#> Attaching package: ‘S4Vectors’
#> The following object is masked from ‘package:BaseSet’:
#> 
#>     active
#> The following object is masked from ‘package:utils’:
#> 
#>     findMatches
#> The following objects are masked from ‘package:base’:
#> 
#>     I, expand.grid, unname
#> 
#> Attaching package: ‘AnnotationDbi’
#> The following object is masked from ‘package:BaseSet’:
#> 
#>     select
#> Loading required package: XML
#> Loading required package: graph
#> 
#> Attaching package: ‘graph’
#> The following object is masked from ‘package:XML’:
#> 
#>     addNode
#> The following objects are masked from ‘package:BaseSet’:
#> 
#>     complement, intersection
#> 
#> Attaching package: ‘GSEABase’
#> The following object is masked from ‘package:BaseSet’:
#> 
#>     incidence
#>       sets Identifier                    shortDescripton
#> 1  chr5q23     c1:101  Genes in cytogenetic band chr5q23
#> 2 chr16q24     c1:102 Genes in cytogenetic band chr16q24
#>                      longDescription organism
#> 1  Genes in cytogenetic band chr5q23    Human
#> 2 Genes in cytogenetic band chr16q24    Human
#>                                                   urls.getBroadSet
#> 1 file://home/runner/work/_temp/Library/GSEABase/extdata/Broad.xml
#> 2 file://home/runner/work/_temp/Library/GSEABase/extdata/Broad.xml
#>                                                    urls2     contributor  type
#> 1 http://www.broad.mit.edu/gsea/msigdb/cards/chr5q23.xml Broad Institute Broad
#> 2 http://genome.ucsc.edu/cgi-bin/hgTracks?position=16q24 Broad Institute Broad
#>                                                   urls3
#> 1 http://genome.ucsc.edu/cgi-bin/hgTracks?position=5q23
#> 2                                                  <NA>
relations <- data.frame(
    sets = c(rep("a", 5), "b"),
    elements = letters[seq_len(6)]
)
tidySet(relations)
#>   elements sets fuzzy
#> 1        a    a     1
#> 2        b    a     1
#> 3        c    a     1
#> 4        d    a     1
#> 5        e    a     1
#> 6        f    b     1
relations2 <- data.frame(
    sets = c(rep("A", 5), "B"),
    elements = letters[seq_len(6)],
    fuzzy = runif(6)
)
tidySet(relations2)
#>   elements sets       fuzzy
#> 1        a    A 0.880934217
#> 2        b    A 0.961116277
#> 3        c    A 0.004018454
#> 4        d    A 0.552900206
#> 5        e    A 0.219235973
#> 6        f    B 0.646727143
# A
x <- list("A" = letters[1:5], "B" = LETTERS[3:7])
tidySet(x)
#>    elements sets fuzzy
#> 1         a    A     1
#> 2         b    A     1
#> 3         c    A     1
#> 4         d    A     1
#> 5         e    A     1
#> 6         C    B     1
#> 7         D    B     1
#> 8         E    B     1
#> 9         F    B     1
#> 10        G    B     1
# A fuzzy set taken encoded as a list
A <- runif(5)
names(A) <- letters[1:5]
B <- runif(5)
names(B) <- letters[3:7]
relations <- list(A, B)
tidySet(relations)
#>    elements sets      fuzzy
#> 1         a Set2 0.72770205
#> 2         b Set2 0.87258744
#> 3         c Set2 0.38198155
#> 4         d Set2 0.89274570
#> 5         e Set2 0.84387029
#> 6         c <NA> 0.72976121
#> 7         d <NA> 0.03841498
#> 8         e <NA> 0.33382332
#> 9         f <NA> 0.74927265
#> 10        g <NA> 0.91315801
# Will error
# x <- list("A" = letters[1:5], "B" = LETTERS[3:7], "c" = runif(5))
# a <- tidySet(x) # Only characters or factors are allowed as elements.
M <- matrix(c(1, 0.5, 1, 0), ncol = 2,
            dimnames = list(c("A", "B"), c("a", "b")))
tidySet(M)
#>   elements sets fuzzy
#> 1        A    a   1.0
#> 2        B    a   0.5
#> 3        A    b   1.0
```
