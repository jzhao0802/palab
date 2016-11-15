# PA Lab

## Overview
The Predictive Analtyics (PA) team run many projects a year which have common data analytics tasks. To save time and standardise the approach across projects, these tasks should be consolidated into a set of standard functions that can be used, i.e. the PA Lab.

## Format
* The PA Lab should be an R package which can be modified and added to easily.
* It should consist of a set of functions that perform each task.
* There should be an example html vignette (e.g. https://cran.r-project.org/web/packages/dplyr/vignettes/data_frames.html) that calls all functions in the correct order, with default parameters.
* Some test data will be provided and must be stored within the package so that someone can run the entire set of functions through and get familiar with the functionality.
* Each function must be able to run independently, subject to the dependencies stated in the function.
* Each function should be unit tested and have a help page with example calls. Please use the `testthat` package for unit tests.
* Use of the tidyverse package is strongly encouraged.
* Please conform to Hadley Wickham R style guide http://adv-r.had.co.nz/Style.html and the best practices described in the book (http://r-pkgs.had.co.nz).
* Code should be commented with a consistent coding structure across all functions.
* The package should pass R Cmd Check (http://r-pkgs.had.co.nz/check.html).
* Where possible, existing packages should be used to avoid re-writing code that has already been written in the R community.

## Initial running order for functions
* `var_config_generator`
* `read_transform`
* `long_var_names`
* `univariate_stats`
* `bivariate_stats_cat`
* `bivariate_stats_num`
* `correlation_xbyx`
* `extreme_values`
* `binning`
* `perf_metrics_cat`
