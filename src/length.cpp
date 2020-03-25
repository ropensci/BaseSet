#include <Rcpp.h>
#include <algorithm>
using namespace Rcpp;


double prod(NumericVector x) {
    double out;
    out = 1;
    NumericVector::iterator it;
    for(it = x.begin(); it != x.end(); ++it) {
        out *= *it;
    }
    return out;
}

// [[Rcpp::export]]
NumericVector multiply_probabilities(NumericVector p, NumericVector i) {
    int n = i.size();
    double out;
    if (n == p.size()) {
        return prod(p);
    } else if (n == 0) {
        i = seq_len(n);
    }
    i = i - 1; // To account for starting index at 0 for c++ and 1 in R
    NumericVector sel;
    sel = p.erase(i);
    out = prod(p[i])*prod(1-sel);
    return out;
}

// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically
// run after the compilation.
//

/*** R
# multiply_probabilities(42)
*/
