# Read an OBO file

Read an Open Biological and Biomedical Ontologies (OBO) formatted file

## Usage

``` r
getOBO(x)
```

## Arguments

- x:

  Path to a file in OBO format.

## Value

A TidySet object.

## References

The format is described
[here](https://owlcollab.github.io/oboformat/doc/GO.format.obo-1_4.html)

## See also

Other IO functions:
[`getGAF()`](https://docs.ropensci.org/BaseSet/dev/reference/getGAF.md),
[`getGMT()`](https://docs.ropensci.org/BaseSet/dev/reference/getGMT.md)

## Examples

``` r
oboFile <- system.file(
    package = "BaseSet", "extdata",
    "go-basic_subset.obo"
)
gs <- getOBO(oboFile)
head(gs)
#>     elements       sets                             name          namespace
#> 1 GO:0000001 GO:0048308        mitochondrion inheritance biological_process
#> 2 GO:0000001 GO:0048311        mitochondrion inheritance biological_process
#> 3 GO:0000002 GO:0007005 mitochondrial genome maintenance biological_process
#> 4 GO:0000003 GO:0008150                     reproduction biological_process
#> 5 GO:0000003 GO:0008150                     reproduction biological_process
#> 6 GO:0000003 GO:0008150                     reproduction biological_process
#>                                                                                                                                                                                                                                 def
#> 1 "The distribution of mitochondria, including the mitochondrial genome, into daughter cells after mitosis or meiosis, mediated by interactions between mitochondria and the cytoskeleton." [GOC:mcc, PMID:10873824, PMID:11389764]
#> 2 "The distribution of mitochondria, including the mitochondrial genome, into daughter cells after mitosis or meiosis, mediated by interactions between mitochondria and the cytoskeleton." [GOC:mcc, PMID:10873824, PMID:11389764]
#> 3                                                              "The maintenance of the structure and integrity of the mitochondrial genome; includes replication and segregation of the mitochondrial chromosome." [GOC:ai, GOC:vw]
#> 4                                       "The production of new individuals that contain some portion of genetic material inherited from one or more parent organisms." [GOC:go_curators, GOC:isa_complete, GOC:jl, ISBN:0198506732]
#> 5                                       "The production of new individuals that contain some portion of genetic material inherited from one or more parent organisms." [GOC:go_curators, GOC:isa_complete, GOC:jl, ISBN:0198506732]
#> 6                                       "The production of new individuals that contain some portion of genetic material inherited from one or more parent organisms." [GOC:go_curators, GOC:isa_complete, GOC:jl, ISBN:0198506732]
#>                                         synonym     alt_id     subset comment
#> 1          "mitochondrial inheritance" EXACT []       <NA>       <NA>    <NA>
#> 2          "mitochondrial inheritance" EXACT []       <NA>       <NA>    <NA>
#> 3                                          <NA>       <NA>       <NA>    <NA>
#> 4 "reproductive physiological process" EXACT [] GO:0019952 goslim_agr    <NA>
#> 5 "reproductive physiological process" EXACT [] GO:0019952 goslim_agr    <NA>
#> 6 "reproductive physiological process" EXACT [] GO:0019952 goslim_agr    <NA>
#>   consider relationship                   set_name ref_origin     ref_code
#> 1     <NA>         <NA>      organelle inheritance       <NA>         <NA>
#> 2     <NA>         <NA> mitochondrion distribution       <NA>         <NA>
#> 3     <NA>         <NA> mitochondrion organization       <NA>         <NA>
#> 4     <NA>         <NA>         biological_process  Wikipedia Reproduction
#> 5     <NA>         <NA>         biological_process  Wikipedia Reproduction
#> 6     <NA>         <NA>         biological_process  Wikipedia Reproduction
#>   fuzzy
#> 1     1
#> 2     1
#> 3     1
#> 4     1
#> 5     1
#> 6     1
```
