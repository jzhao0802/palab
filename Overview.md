# PA Lab

## Overview
The Predictive Analtyics (PA) team run many projects a year which have common data analytics tasks. To save time and standardise the approach across projects, these tasks should be consolidated into a set of standard scripts that can be used, i.e. the PA Lab.

## Format
* The PA Lab should be an R package which can be modified and added to easily.
* It should consist of a set of functions that perform each task.
* There should be a master script that has all functions included in the correct order, with default parameters.
* Some test data must be created or be available within the package so that someone can run the entire pipeline through with and get familiar with the functionality.
* Each function must be able to run independantly, subject to the dependancies stated in the function.

## Initial running order for functions
* `read_and_transform`
* `univariate_stats`
* `bivariate_stats`
* `correlational`
