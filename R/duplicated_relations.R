
# Outputs which columns have problems with the relations
duplicated_relations <- function(df) {
    # Look for duplicated relations
    es <- paste(df$elements, df$sets)
    i <- split(es, es)
    if (any(lengths(i) > 1)) {
        # Solve how to account for duplicate relationships (different Evidence codes and so on.2)
        v <- t(simplify2array(strsplit(names(i)[lengths(i) != 1], split = " ")))
        v2 <- t(apply(v, 1, function(x) {
            sapply(df[df$elements== x[1] & df$sets == x[2],
                      !colnames(df) %in% c("elements", "sets")],
                   function(y) {length(unique(y))})}))
        k <- apply(v2, 2, function(x){all(x == 1)})
        if (any(!k)) {
            stop(paste(names(k)[!k], collapse = ", "),
                 " have different values for the same ontolgy and element.")
        }
    }
    df
}
