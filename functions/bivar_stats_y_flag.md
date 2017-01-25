# Statistics for when outcome is a flag

## Purpose
This function combines univariate and bivariate stats for the special case where the outcome variable is a flag (either 0 or 1) and the variables are numerical.
This is quite often the case for certain types of projects.

## Internal Dependancies
`read_transform`

## Name
`bivar_stats_y_flag`

## Parameters
* `input`
  * R data frame output by `read_transform`
* `var_config`
  * Full path and name of the CSV containing the variable configuration.
  * Example file is [here](../example_metadata_files/var_config.csv)
* `prefix`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.
* `outcome_var`
  * The variable to use as an outcome. It should only have two values, 0 or 1, and should be taken as numerical.

## Function
*  `var_config` should be used to identify numerical variables. No processing is to be carried out on categorical variables here.
* Produce a table with the following columns. 
  * _Variable_: Name of numerical variable
  * _Num Unique Values_: Number of unique values that this variable has (from `var_config_generated`)
  * _Non Missing_: Number of non-missing observations in the variable
  * _Above 0_: Number of observations in which the variable has a value above 0
  * _Class1 Above 0_:  Number of observations in which the variable has a value above 0 and `outcome_var` equals 1
  * _Mean_: Mean of the variable across all observations
  * _Mean Class1_: Mean of the variable when `outcome_var` equals 1.
  * _Mean Class0_: Mean of the variable when `outcome_var` equals 0.

  * _Mean difference_: Absolute value of ( (_Mean Class1_ - _Mean Class0_) / _Mean_ ).
  * _Correlation_: Spearman's correlation coefficient measuring the association between the numerical variable and the outcome variable. The result should be rounded to two decimal places.
  * _Diagnostic Odds_: Diagnostic odds ratio
    * This is defined as (TP/FP) / (FN/TN). Here a TP is _Class1 Above 0_, FP is _Class0 Above 0_. FN is _Class1 Zero or below_, TN is _Class0 Zero or below_.

  * _Min Class1_ : Minimum value of the variable when `outcome_var` equals 1.
  * _P25 Class1_ : Value at the percentile 25 of the variable when `outcome_var` equals 1.
  * _P50 Class1_ : Value at the percentile 50 of the variable when `outcome_var` equals 1.
  * _P75 Class1_ : Value at the percentile 75 of the variable when `outcome_var` equals 1.
  * _Max Class1_ : Maximum value of the variable when `outcome_var` equals 1.

  * _Min Class0_ : Minimum value of the variable when `outcome_var` equals 0.
  * _P25 Class0_ : Value at the percentile 25 of the variable when `outcome_var` equals 0.
  * _P50 Class0_ : Value at the percentile 50 of the variable when `outcome_var` equals 0.
  * _P75 Class0_ : Value at the percentile 75 of the variable when `outcome_var` equals 0.
  * _Max Class0_ : Maximum value of the variable when `outcome_var` equals 0.

## Return
A data frame containing the table described above

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* `prefix`bivar_stats_y_flag.csv

## Defaults
```
bivar_stats_y_flag(
  input=,
  var_config=,
  prefix='',
  output_dir=,
  outcome_var=
  )  
```

## Example call
```
cars_bivar_flag <- bivar_stats_y_flag(
  input=cars$data,
  var_config=var_config,
  output="cars",
  output_dir="D:/data/cars1/",
  outcome_var = "gear"
  )
```
