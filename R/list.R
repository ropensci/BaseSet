
setAs("TidySet", "list", function(from) {
  out <- split(seq_len(nRelations(from)),
               relations(from)$sets)

  lapply(out, function(x, relations){
    out <- relations$fuzzy[x]
    names(out) <- relations$elements[x]
    out
  }, relations = relations(from))
})
