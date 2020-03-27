#include <Rcpp.h>
#include <algorithm>
using namespace Rcpp;

// [[Rcpp::export]]
double prod2(NumericVector x) {
    double out;
    out = 1;
    NumericVector::iterator it;
    for(it = x.begin(); it != x.end(); ++it) {
        out *= *it;
    }
    return out;
}

// [[Rcpp::export]]
NumericVector not_in(NumericVector p, NumericVector i) {
    int it;
    // i = std::sort(i);
    for(it = 0; it < i.size(); it++) {
        if (i[it] != 0) {
            i = i -1;
        }
        p.erase(i[it]);
    }
    return p;
}


// [[Rcpp::export]]
NumericVector multiply_probabilities2(NumericVector p, NumericVector i) {
    int n = i.size();
    double out = 1;
    if (n == p.size()) {
        return prod2(p);
    } else if (n == 0) {
        i = seq_len(n);
    }
        std::cout << i;
    NumericVector sel = not_in(p, i);
    NumericVector one;
    one = rep(1, sel.size());

    out *= prod2(p[i]);
    NumericVector two;
    two = one - sel;
    out *= prod2(two);
    return out;
}


// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically
// run after the compilation.
//

/*** R
prod2(c(0.5, 0.1, 0.3, 0.85, 0.25, 0.23)) == prod(c(0.5, 0.1, 0.3, 0.85, 0.25, 0.23))
not_in(c(0.5, 0.1, 0.3, 0.85, 0.25, 0.23), c(1, 2)) == c(0.5, 0.1, 0.3, 0.85, 0.25, 0.23)[-c(1, 2)]
multiply_probabilities2(c(0.5, 0.1, 0.3, 0.85, 0.25, 0.23), c(1, 2))
multiply_probabilities(c(0.5, 0.1, 0.3, 0.85, 0.25, 0.23), c(1, 2))
*/

















