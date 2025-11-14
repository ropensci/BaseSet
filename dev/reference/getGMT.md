# Import GMT (Gene Matrix Transposed) files

The GMT (Gene Matrix Transposed) file format is a tab delimited file
format that describes groups of genes. In this format, each row
represents a group. Each group is described by a name, a description,
and the genes in it.

## Usage

``` r
getGMT(con, sep = "\t", ...)
```

## Arguments

- con:

  File name of the GMT file.

- sep:

  GMT file field separator, by default tabs.

- ...:

  Other arguments passed to `readLines`.

## Value

A TidySet object.

## References

The file format is defined by the Broad Institute
[here](https://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Data_formats#GMT:_Gene_Matrix_Transposed_file_format_.28.2A.gmt.29)

## See also

Other IO functions:
[`getGAF()`](https://docs.ropensci.org/BaseSet/dev/reference/getGAF.md),
[`getOBO()`](https://docs.ropensci.org/BaseSet/dev/reference/getOBO.md)

## Examples

``` r
gmtFile <- system.file(
    package = "BaseSet", "extdata",
    "hallmark.gene.symbol.gmt"
)
gs <- getGMT(gmtFile)
nRelations(gs)
#> [1] 7324
nElements(gs)
#> [1] 4386
nSets(gs)
#> [1] 50
```
