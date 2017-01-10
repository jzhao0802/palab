# Bivariate Statistics for categerical outcomes

## Purpose
This function will produce a summary of how each variable varies with a _categorical_ outcome variable. This will help the user to flag associations between the independent variables and outcome variable that may not be compatible with the subsequent modelling approach.

## Internal Dependancies
`read_transform`

## Name
`bivar_stats_y_cat`

## Parameters
* `input`
  * R data frame output by `read_transform`
* `var_config`
  * Full path and name of the CSV containing the variable configuration.
  * Example file is [here](../example_metadata_files/var_config.csv)
* `output`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.
* `outcome_var`
  * The variable to use as an outcome.

## Function
* Output a warning if the outcome variable has more than 5 levels.
  * More than 5 levels will make the resulting spreadsheets very difficult to digest, so the user needs to be warned about this.
* Each statistic mentioned below ends in "_\__X_". This means that it should be calculated for each level of the outcome variable, and the name of the stat should be suffixed with that level value. E.g. if the outcome variable has 2 levels, "1" and "0", the stat _Count__X_ should have 2 columns in the output CSV, "Count_1" and "Count_0", calculated for all observations where the outcome variable has level 1 and 0 respectively.
* The statistic columns for each class in the output should appear next to each other in the output, so that they can be compared.
  * For example, the order of columns should be: Count_1, Count_0, Proportion of Level 1, Proportion of Level 0, Proportion of Outcome 1, Proportion of Outcome 0... etc. 
* For categorical variables (except the outcome variable itself), produce `output`bivar_stats_y_cat_x_cat.csv. This is a full frequency table containing all levels for all variables with the following columns:
  * _Variable_: Name of the categorical variable.
  * _Level_: The value of the level in that variable.
    * Each variable should the following 2 special levels:
      * First is a level called "non_missing". This row will contain aggregated stats on all the non-missing levels in that variable.
      * Second is a level called "missing". This row will contains stats on all the missing observations for that variable.
  * _Count__X_: Count of observations which have this variable equal to this level when outcome level is X.
  * _Proportion of Level__X_: _Count__X_ / all observations where level of variable is this level, i.e. P(outcome = Y1 | variable = X1); rounded to two decimal places.
  * _Proportion of Outcome__X_: _Count__X_ / all observations where the outcome level is X, i.e. P(variable = X1 | outcome = Y1); rounded to two decimal places.

* For numerical variables, produce  `output`bivar_stats_y_cat_x_num.csv with following columns with all results rounded to two decimal places:
  * _Variable_: Name of the categorical variable.
  * _NonMissing__X_: Number of non-missing obsservations when outcome level is X.
  * _NonMissingPrp__X_: Proportion of non-missing observations when outcome level is X where the denominator is the total number of observations in the data inclusive of missing values. The result should be rounded to two decimal places.
  * _Missing__X_: Number of missing observations when outcome level is X.
  * _MissingPrp__X_: Proportion of missing observations when outcome level is X where the denominator is the total number of observations in the data inclusive of missing values. The result should be rounded to two decimal places.
  * _Mean__X_: Mean of the variable when outcome level is X.
  * _SD__X_: Standard deviation of the variable when outcome level is X.
  * _Min__X_: Minimum value of the variable when outcome level is X.
  * _Max__X_: Maximum value of the variable when outcome level is X.
  * _P1__X_: Value at the percentile 1 of the variable when outcome level is X.
  * _P5__X_: Value at the percentile 5 of the variable when outcome level is X.
  * _P10__X_: Value at the percentile 10 of the variable when outcome level is X.
  * _P25__X_: Value at the percentile 25 of the variable when outcome level is X.
  * _P50__X_: Value at the percentile 50 of the variable when outcome level is X.
  * _P75__X_: Value at the percentile 75 of the variable when outcome level is X.
  * _P90__X_: Value at the percentile 90 of the variable when outcome level is X.
  * _P95__X_: Value at the percentile 95 of the variable when outcome level is X.
  * _P99__X_: Value at the percentile 99 of the variable when outcome level is X.

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* `output`bivar_stats_y_cat_x_cat.csv
* `output`bivar_stats_y_cat_x_num.csv
* The default of `output` is '', so the function produces bivar_stats_y_cat_x_cat.csv and bivar_stats_y_cat_x_num.csv by default.

## Return
List containing these data frames:
* bivar_stats_y_cat_x_cat
* bivar_stats_y_cat_x_num

## Defaults
```
bivar_stats_y_cat(
  input=,
  var_config=,
  output='',
  output_dir=,
  outcome=
  )  
```

## Example call
```
cars_bivar <- bivar_stats_y_cat(
  input=cars$data,
  var_config=var_config,
  output="cars",
  output_dir="D:/data/cars1/",
  outcome = "gear"
  )
```

## Tests
* All outputs should have the correct format and structure as specified.
* Using the provided toy example for [input](./example_data/mtcars.csv): all outputs should exactly match the provided examples for the results [bivar_stats_y_cat_x_cat](./example_output_csvs/bivar_stats_y_cat_x_cat.csv);
[bivar_stats_y_cat_x_num](./example_output_csvs/bivar_stats_y_cat_x_num.csv).
