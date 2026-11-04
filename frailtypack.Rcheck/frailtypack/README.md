# frailtypack

[![CRAN version](https://www.r-pkg.org/badges/version/frailtypack)](https://CRAN.R-project.org/package=frailtypack)
[![R-CMD-check](https://github.com/vrondeau/frailtypack/actions/workflows/R.yml/badge.svg)](https://github.com/vrondeau/frailtypack/actions/workflows/R.yml)
[![CRAN downloads](https://cranlogs.r-pkg.org/badges/grand-total/frailtypack)](https://CRAN.R-project.org/package=frailtypack)

## Overview

`frailtypack` is an R package for the analysis of survival data using shared frailty models, joint frailty models, and other advanced survival modelling approaches.

The package provides methods for recurrent event data, terminal events, competing risks, and joint modelling of longitudinal and survival outcomes.

For a detailed description of the statistical methods, see the package documentation and vignettes.

## Installation

### From CRAN

```r
install.packages("frailtypack")
```

### Development version from GitHub

```r
install.packages("remotes")
remotes::install_github("vrondeau/frailtypack")
```

## Documentation

The package includes R help pages and vignettes describing its methods and their use.

```r
help(package = "frailtypack")
browseVignettes("frailtypack")
```

## Shiny application

An interactive Shiny application is available at:

https://frailtypack-pkg.shinyapps.io/shiny_frailtypack/

## Bug reports and feature requests

Please report bugs or suggest improvements through the GitHub issue tracker:

https://github.com/vrondeau/frailtypack/issues

## License

See the `DESCRIPTION` file and the package source for licensing information.
