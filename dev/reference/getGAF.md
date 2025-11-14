# Read a GAF file

Read a GO Annotation File (GAF) formatted file

## Usage

``` r
getGAF(x)
```

## Arguments

- x:

  A file in GAF format.

## Value

A TidySet object.

## References

The format is defined
[here](https://geneontology.org/docs/go-annotation-file-gaf-format-2.1/).

## See also

Other IO functions:
[`getGMT()`](https://docs.ropensci.org/BaseSet/dev/reference/getGMT.md),
[`getOBO()`](https://docs.ropensci.org/BaseSet/dev/reference/getOBO.md)

## Examples

``` r
gafFile <- system.file(
    package = "BaseSet", "extdata",
    "go_human_rna_valid_subset.gaf"
)
gs <- getGAF(gafFile)
head(gs)
#>             elements       sets         DB       DB_Object_ID Evidence_Code
#> 1 URS0000001346_9606 GO:0006412 RNAcentral URS0000001346_9606           IEA
#> 2 URS0000001346_9606 GO:0030533 RNAcentral URS0000001346_9606           IEA
#> 3 URS000000192A_9606 GO:0016442 RNAcentral URS000000192A_9606           IEA
#> 4 URS000000192A_9606 GO:0035195 RNAcentral URS000000192A_9606           IEA
#> 5 URS00000019BC_9606 GO:0000244 RNAcentral URS00000019BC_9606           IEA
#> 6 URS00000019BC_9606 GO:0000353 RNAcentral URS00000019BC_9606           IEA
#>      With_From                                         DB_Object_Name
#> 1   GO:0030533                          Homo sapiens (human) tRNA-Lys
#> 2 Rfam:RF00005                          Homo sapiens (human) tRNA-Lys
#> 3 Rfam:RF00951 Homo sapiens (human) MIR1302-2 host gene (MIR1302-2HG)
#> 4 Rfam:RF00951 Homo sapiens (human) MIR1302-2 host gene (MIR1302-2HG)
#> 5 Rfam:RF00026                  Homo sapiens (human) snRNA-U6-related
#> 6 Rfam:RF00026                  Homo sapiens (human) snRNA-U6-related
#>   DB_Object_Type      Taxon     Date Assigned_By fuzzy   DB_Reference Aspect
#> 1           tRNA taxon:9606 20190601         GOC     1 GO_REF:0000108     BP
#> 2           tRNA taxon:9606 20190601  RNAcentral     1 GO_REF:0000115     MF
#> 3        lnc_RNA taxon:9606 20190601  RNAcentral     1 GO_REF:0000115     CC
#> 4        lnc_RNA taxon:9606 20190601  RNAcentral     1 GO_REF:0000115     BP
#> 5          snRNA taxon:9606 20190601  RNAcentral     1 GO_REF:0000115     BP
#> 6          snRNA taxon:9606 20190601  RNAcentral     1 GO_REF:0000115     BP
```
