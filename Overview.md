# PA Pipeline

## Overview
The Predictive Analtyics (PA) Pipeline is a set of functions to perform common tasks that are regularly encountered by members of the Predictive Analytics team during projects.
It is intended to be a set of functions (and tests), wrapped up in an R package. This package will be modified and added to as and when needed by the core PA team, but will initially be created by externals.

## Structure
* The PA pipeline should be an R library which can be modified and added to easily.
* There should be a master script that has all functions included in the correct order, with default parameters.
* Some test data must be created and available with the package so that someone can run the entire pipeline through with and get familiar with the functionality.
* Each function must be able to run indepentanly, subject to the dependancies stated in the function. 
