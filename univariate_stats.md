# Univariate Statistics

## Purpose
This function will produce a summary of each variable in the input dataset. It will help the user understand the data better and spot any issues with the variables.  

## Internal Dependencies
`read_and_transform`

## Name
`univariate_stats`

## Parameters
* `transformed_data`
  * R dataset output by `read_and_transform`
* `var_config`
  * R dataset output by `var_config_generator`
* `output_dir`
  * The directory into which all outputs will be written to.

## Function
* For categorical variables (from `var_config`), produce `univar_stats_x_cat.csv`. This is a full frequency table containing all levels for all variables with the following columns:
  * _Variable_: Name of the categorical variable.
  * _NumLevels_: This is the number of different levels in that variable. This value will be repeated for all rows with that variable.
  * _Level_: The value of the level in that variable
    * Each variable should the following 2 special levels:
      * First is a level called "non_missing". This row will contain aggregated stats on all the non-missing levels in that variable.
      * Second is a level called "missing". This row will contains stats on all the missing observations for that variable.
  * _Count_: Count of observations which have this variable equal to this level.
  * _Percentage_: Percentage of observations which have this variable equal to this level.
    * For the special levels, _Percentage_ = _Count_ / Number of observations
    * For the normal levels, _Percentage_ = _Count_ / Number of non_missing observations for that variable
* For numerical variables (from `var_config`), produce `univar_stats_x_num.csv` with following columns:
  * _Variable_: Name of the categorical variable.
  * _NonMissing_: Number of non-missing obsservations.
  * _NonMissingPerc_: Percentage of non-missing observations.
  * _Missing_: Number of missing observations.
  * _MissingPerc_: Percentage of missing observations.
  * _Mean_: Mean of the variable.
  * _SD_: Standard deviation of the variable.
  * _Min_: Minimum value of the variable.
  * _P1_: Value at the percentile 1 of the variable.
  * _P5_: Value at the percentile 5 of the variable.
  * _P10_: Value at the percentile 10 of the variable.
  * _P25_: Value at the percentile 25 of the variable.
  * _P50_: Value at the percentile 50 of the variable.
  * _P75_: Value at the percentile 75 of the variable.
  * _P90_: Value at the percentile 90 of the variable.
  * _P95_: Value at the percentile 95 of the variable.
  * _P99_: Value at the percentile 99 of the variable.
  * _Max_: Maximum value of the variable.
  * _P10_: Value at the percentile 10 of the variable.
  * _P20_: Value at the percentile 20 of the variable.
  * _P30_: Value at the percentile 30 of the variable.
  * _P40_: Value at the percentile 40 of the variable.
  * _P50_: Value at the percentile 50 of the variable.
  * _P60_: Value at the percentile 60 of the variable.
  * _P70_: Value at the percentile 70 of the variable.
  * _P80_: Value at the percentile 80 of the variable.
  * _P90_: Value at the percentile 90 of the variable.
* Note that the percentile thresholds should be calculated on non-missing values only.
* Produce `univar_stats_problems.csv` to highlight any obvious data issues. If the univariate stats of a variable meets any of the following criteria, then it should be in the output:
  * Variable is 100% missing
  * Variable has only 1 unique value

  The table should have the following columns:
  * _Variable_: Name of variable
  * _Problem_: A description of the problem with this variable, which can take the folloiwng values:


## Output
All files below should be output to the `output_dir`, overwriting a previous version if necessary.
* univar_stats_x_cat.csv
* univar_stats_x_num.csv

## Defaults
```
univariate_stats(
  transformed_data=,
  var_config=,
  output_dir=,
  )  
```

## Example call
```
univariate_stats(
  transformed_data=transformed_data,
  var_config=var_config,
  output_dir="D:/data/cars1/",
  )  
```
## Tests
