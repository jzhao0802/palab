# PA Pipeline

## Overview
The Predictive Analtyics (PA) Pipeline is a set of functions to perform common tasks that are regularly encountered by members of the Predictive Analytics team during projects.
It is intended to be a set of functions (and tests), wrapped up in an R package. This package will be modified and added to as and when needed by the core PA team, but will initially be created by externals.

##  Structure
There are several sections to to PA pipeline:
* Transformation
* Description statstics
* Modelling

## Definitions
* Input dataset
  * This is the data that is to be analysed.
* Observation
  * A row in the input dataset
* Attributes
  * A column in the input dataset which is descriptive but no intended as an input to a statistical algorthm. For example, an ID (patient ID, hospitalID) or a date (index date)
* Variable
  * A column in the input dataset which is intended as an input into a statistical algorithm.
  * Also known as predictors, independant variables.
* Categorical variable
  * A variable which has a distinct number of unique values which are not related numericlly, i.e. Gender, Treatment type, Comorbidity.
* Numerical variable  
  * A variable which has values on a continous scale, e.g. Height
* Count variables
  * A variable which is a count of something. The values in these types of variables are always expected to be positve integers. They can sometimes be treated as categorical variables if there is a small range.
* Outcome variable
  * A variable which will will be used to train a supervised model
  * Also known as: Response variable, Target variable, Dependant variable
* Index date
  * This is a common attribute in a datasets and is the date from which the information for that observation was recorded.
