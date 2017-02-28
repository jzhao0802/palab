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
  * The variable to use as an outcome. The variable should only have two values, 0 or 1, and should be taken as numerical.
* `vargt0`
  * If this is TRUE, certain statistics should be calculated differently

## Function
*  `var_config` should be used to identify numerical variables. No processing is to be carried out on categorical variables here.

* Produce a table with the following columns.
  * _Variable_: Name of numerical variable
  * _Num Unique Values_: Number of unique values that this variable has (from `var_config_generated`)
  * _Non Missing_: Number of non-missing observations in the variable
  * _Above 0_: Number of observations in which the variable has a value above 0
  * _Prop Above 0_: Number of observations in which the variable has a value above 0
  * _Class1 Above 0_:  Number of observations in which the variable has a value above 0 and `outcome_var` equals 1
  * _Class0 Above 0_:  Number of observations in which the variable has a value above 0 and `outcome_var` equals 0
  * _Prop Class1 Above 0_:  _Class1 Above 0_ / _TotalinClass1_
  * _Prop Class0 Above 0_:  _Class1 Above 0_ / _TotalinClass0_

  * _Prop difference_: Absolute value of ( (_Prop Class1 Above 0_ - _Prop Class0 Above 0_) / _Prop Above 0_ ).
  * _Correlation_: Spearman's correlation coefficient measuring the association between the numerical variable and the outcome variable. The result should be rounded to 5 decimal places.
  * _Correlation p-value_: Spearman's correlation coefficient p-value
  * _Correlation p-value corrected_: Spearman's correlation coefficient p-value corrected using the Bonferroni method described in correlations.md
  * _Diagnostic Odds_: Diagnostic odds ratio
    * This is defined as (TP/FP) / (FN/TN). Here a TP is _Class1 Above 0_, FP is _Class0 Above 0_. FN is _Class1 Zero or below_, TN is _Class0 Zero or below_.

  * _Mean_: Mean of the variable across all observations
  * _Mean Class1_: Mean of the variable when `outcome_var` equals 1.
  * _Mean Class0_: Mean of the variable when `outcome_var` equals 0.

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

* if `vargt0` = TRUE, then the following statistics should only be calculated across the Above-0 part of each variable. This is the equivalent of setting any value, in any variable, which is <= 0, to missing, and running the rest of the function normally.
  * _Mean*_ (all the mean values)
  * _Min*_ (all the min values)
  * _Max*_ (all the max values)
  * _P*_ (all the percentile values)

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
  outcome_var=,
  vargt0=FALSE
  )  
```

## Example call
```
cars_bivar_flag <- bivar_stats_y_flag(
  input=cars$data,
  var_config=var_config,
  prefix="cars",
  output_dir="D:/data/cars1/",
  outcome_var = "gear",
  vargt0=FALSE
  )
```
