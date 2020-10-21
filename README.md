
<!-- README.md is generated from README.Rmd. Please edit that file -->

# AusSportGrounds

<!-- badges: start -->

[![R build
status](https://github.com/SportStatisticsRSweet/AusSportGrounds/workflows/R-CMD-check/badge.svg)](https://github.com/SportStatisticsRSweet/AusSportGrounds/actions)
[![Codecov test
coverage](https://codecov.io/gh/SportStatisticsRSweet/AusSportGrounds/branch/master/graph/badge.svg)](https://codecov.io/gh/SportStatisticsRSweet/AusSportGrounds?branch=master)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of AusSportGrounds is to …

## Installation

You can install the released version of AusSportGrounds from
[CRAN](https://CRAN.R-project.org) with:

``` r
#install.packages("AusSportGrounds")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("SportStatisticsRSweet/AusSportGrounds")
```

## Usage

The package provides ggplot layers that can be added to any ggplot to
overlay various field types. An example is a basic AFL field with known
dimensions:

``` r
library(AusSportGrounds)
library(ggplot2)

# Create basic AFL field
dim <- list(length = 160,
            width = 140)

ggplot() +
     annotate_afl_oval(dim)
```

<img src="man/figures/README-example-1.png" width="100%" />

TODO - Add some more simple examples TODO - Point towards Vignettes

## Code of Conduct

Please note that the AusSportGrounds project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
