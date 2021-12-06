
<!-- README.md is generated from README.Rmd. Please edit that file -->

# confcons

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test
coverage](https://codecov.io/gh/bfakos/confcons/branch/master/graph/badge.svg)](https://app.codecov.io/gh/bfakos/confcons?branch=master)
<!-- badges: end -->

‘confcons’ (**conf**idence & **cons**istence) is a light-weight,
stand-alone R package designed to calculate the following two novel
measures of predictive distribution models (incl. species distribution
models):

-   *confidence* that measures the proportion of predictions that the
    model is confident in;
-   *consistence* that measures how consistent the model is if the
    confidence in the training and evaluation subsets are compared.

While *confidence* serves as a replacement for the widely criticized
goodness-of-fit measures, such as AUC, *consistence* is a proxy for
model’s transferability (in space and time).

## Installation

You can install the development version of ‘confcons’ from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github(repo = "bfakos/confcons", upgrade = "never")
```

If you want to read the
[vignette](https://bfakos.github.io/confcons/articles/introduction_to_confcons.html)
in R, install the package with:

``` r
# install.packages("devtools")
devtools::install_github(repo = "bfakos/confcons", upgrade = "never", build_vignettes = TRUE)
```

## Examples

Three small functions, `thresholds()`, `confidence()` and
`consistence()`, belong to the core of the package. A wrapper function
called `measures()` utilize these workhorse functions and calculates
every measures for you along with some traditional measures, such as AUC
and maxTSS.

Let’s say we trained a predictive distribution model and made some
predictions with it, and now we want to be sure if our model is both

-   confident in the predictions, and
-   this confidence is consistent between the training and evaluation
    subsets, i.e. we might later use the model for extrapolation
    (through space or time).

Our example dataset is a `data.frame` containing both the training and
the evaluation subset. It is organized in three columns:

-   observations (`integer`): observed presences (`1`s) and absences
    (`0`s),
-   predictions (`numeric`): predicted probability of occurrences
    (within the `[0, 1]` interval), and
-   evaluation_mask (`logical`): indicates whether a certain row belongs
    to the evaluation subset (`TRUE`) or the training subset (`FALSE`).

``` r
dataset <- data.frame(
    observations = c(0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L),
    predictions = c(0.1, 0.2, 0.4, 0.5, 0.5, 0.2, 0.3, 0.3, 0.4, 0.3, 0.65, 0.9, 0.9, 1, 0.1, 0.5, 0.8, 0.8),
    evaluation_mask = c(FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE)
)
```

Well, it is a really small dataset…

Let’s attach the package to our R session:

``` r
library(confcons)
```

Now we can calculate the measures:

``` r
measures(observations = dataset$observations,
                 predictions = dataset$predictions,
                 evaluation_mask = dataset$evaluation_mask)
#>    CP_train     CP_eval         DCP   CPP_train    CPP_eval        DCPP 
#>  0.80000000  0.75000000 -0.05000000  0.75000000  0.66666667 -0.08333333
```

The model seems to be not superperfect, but it is more or less confident
in the positive predictions (i.e. predicted presences), since
`CPP_train` is closer to 1 than to 0. Even if not absolutely confident,
it is really consistent (i.e., `DCPP` is close to 0), so we might not
afraid of transferability issues if used for spatial or temporal
extrapolation.

A detailed description of the measures and the functions of ‘confcons’,
and more examples can be found in [this
vignette](https://bfakos.github.io/confcons/articles/introduction_to_confcons.html).

## Package lifecycle and contribution

This GitHub version of the package is now in stable state and a
manuscript about the novel measures, *confidence* and *consistence*, is
submitted to a scientific journal. Upon acceptance we aims to publish
‘confcons’ to [CRAN](https://cran.r-project.org/).

If you find a bug or have a feature request, or also if you have some
idea want to discuss with the authors of the package, please create a
[new issue](https://github.com/bfakos/confcons/issues).
