#include <Rcpp.h>
#include <algorithm>
using namespace Rcpp;

// Vectorized product.
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

// Function that is equivalent to !(p %in% i)
// [[Rcpp::export]]
NumericVector not_in(NumericVector p, NumericVector i) {
    int it;
    NumericVector z = clone(i);
    // i = std::sort(i);
    for(it = 0; it < z.size(); ++it) {
        if (z[it] != 0) {
            z = z -1;
        }
        p.erase(z[it]);
    }
    return p;
}



// [[Rcpp::export]]
double multiply_probabilities(NumericVector p, NumericVector i) {
    int n = i.size();
    double out = 1;
    NumericVector z = clone(i);
    if (n == p.size() || i.isNULL()) {
        return prod2(p);
    } else if (n == 0) {
        z = seq_len(n);
    } else {
        z = z -1; // Adjust from R numbering to C++ numbering
    }

    // Calculate the probability of those selected
    NumericVector x = p[z];
    out *= prod2(x);
    // Calculate the probability that the otheres are not selected
    NumericVector sel = not_in(p, z);
    NumericVector two;
    NumericVector one;
    one = rep(1, sel.size());
    two = one - sel;
    // Calculate the probability that both things happen
    double negative = prod2(two);
    out *= negative;
    return out;
}

// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically
// run after the compilation.
//

/*** R
x <- c(0.5, 0.1, 0.3, 0.85, 0.25, 0.23)
y <- c(1, 2)
all.equal(prod2(x), prod(x))
y
not_in(x, y) == x[-y]
y
# multiply_probabilities2(x, y)
# multiply_probabilities(x, y)
# multiply_probabilities(x, NULL)
*/
