# Bivariate Statistics for numerical outcomes

## Purpose
This function will produce a summary of how each variable varies with a _numerical_ outcome variable. This will help the user to flag associations between the independent variables and outcome variable that may not be compatible with the subsequent modelling approach.


## Dependencies
`read_and_transform`

## Name
`bivar_stats_y_num`

## Inputs
* `transformed_data`
  * R dataset output by `read_and_transform`
* `output_dir`
  * The directory into which all outputs will be saved.
* `outcome`
  * The variable to use as an outcome.

## Function
* Check that the specified outcome variable has more than 2 unique values. `<some better check here?> `
* For columns prefixed with "o_", no stats should be calculated.
* For categorical variables produce `bivar_stats_y_num_x_cat.csv` where each categorical variable spans multiple rows and each row within the variable group represents a level of the categorical variable. The output file will have the following columns:
  * _Variable_: Name of the categorical variable.
  * _Level_: The value of the level in that variable.
  * _Mean outcome_: mean of the outcome variable when the categorical variable is level X.
  * _SD outcome_: the standard deviation of the outcome variable when the categorical variable is level X.
  * _Min outcome_: Minimum value of the variable when outcome level is X.
  * _P1 outcome_: Value at the percentile 1 of the outcome variable when categorical variable level is X.
  * _P5 outcome_: Value at the percentile 5 of the outcome variable when categorical variable level is X.
  * _P10 outcome_: Value at the percentile 10 of the outcome variable when categorical variable level is X.
  * _P25 outcome_: Value at the percentile 25 of the outcome variable when categorical variable level is X.
  * _P50 outcome_: Value at the percentile 50 of the outcome variable when categorical variable level is X.
  * _P75 outcome_: Value at the percentile 75 of the outcome variable when categorical variable level is X.
  * _P90 outcome_: Value at the percentile 90 of the outcome variable when categorical variable level is X.
  * _P95 outcome_: Value at the percentile 95 of the outcome variable when categorical variable level is X.
  * _P99 outcome_: Value at the percentile 99 of the outcome variable when categorical variable level is X.
  * _Max outcome_ : Maximum value of the outcome variable when categorical variable level is X.


* For categorical variables produce stats on the relative risk. In this case, the first level of the categorical will be assumed to the baseline level and all other levels (including the first level) will be considered relative to this baseline. Each relative risk level below ends in "_\__X_". This means that it should be calculated for each level of the outcome variable, and the name of the stat should be suffixed with that level value. Note that for the relative risk at level 1 - the value will always be 1 as it is computed as the mean of the outcome variable with the categorical variables is level 1 divided by itself. The output should be saved in `RR_stats_y_num_x_cat.csv` where each row is a categorical variable with following columns:
    * _Variable_: Name of categorical variable
    * _Relative risk level X_: mean of the outcome variable when the categorical variable is level X divided by the the mean of the outcome variable for the first level of the categorical variable.

* For numerical variables produce the following statistics where deciles are computed by mass (as opposed to by range) in `bivar_stats_y_num_x_num.csv` where each row represents a single numerical variable with following columns:
  * _Variable_: Name of the numerical variable.
  * _Pearson's correlation coefficient_: Pearson's correlation coefficient measuring the association between the numerical variable and the outcome variable.
  * _P-value of Pearson's correlation coefficient_: The p-value for Pearson's correlation coefficient measuring the association between the numerical variable and the outcome variable.
  * _Spearman's correlation coefficient_: Spearman's correlation coefficient measuring the association between the numerical variable and the outcome variable.
  * _P-value of Spearman's correlation coefficient_: The p-value for Spearman's correlation coefficient measuring the association between the numerical variable and the outcome variable.
  * _Mean outcome in 1st decile_: the mean of the outcome variable for the observations where the numerical variable is >= minimum value of the numerical variable and < the value of the 1st decile of the numerical variable
  * _Mean outcome in 2nd decile_: the mean of the outcome variable for the observations where the numerical variable is >= the value of the 1st decile of the numerical variable  and < the value of the 2nd decile of the numerical variable
  * _Mean outcome in 3rd decile_: the mean of the outcome variable for the observations where the numerical variable is >= the value of the 2nd decile of the numerical variable  and < the value of the 3rd decile of the numerical variable
  * _Mean outcome in 4th decile_: the mean of the outcome variable for the observations where the numerical variable is >= the value of the 3rd decile of the numerical variable  and < the value of the 4th decile of the numerical variable
  * _Mean outcome in 5th decile_: the mean of the outcome variable for the observations where the numerical variable is >= the value of the 4th decile of the numerical variable  and < the value of the 5th decile of the numerical variable
  * _Mean outcome in 6th decile_: the mean of the outcome variable for the observations where the numerical variable is >= the value of the 5th decile of the numerical variable  and < the value of the 6th decile of the numerical variable
  * _Mean outcome in 7th decile_: the mean of the outcome variable for the observations where the numerical variable is >= the value of the 6th decile of the numerical variable  and < the value of the 7th decile of the numerical variable
  * _Mean outcome in 8th decile_: the mean of the outcome variable for the observations where the numerical variable is >= the value of the 7th decile of the numerical variable  and < the value of the 8th decile of the numerical variable
  * _Mean outcome in 9th decile_: the mean of the outcome variable for the observations where the numerical variable is >= the value of the 8th decile of the numerical variable  and < the value of the 9th decile of the numerical variable
  * _Mean outcome in 10th decile_:  the mean of the outcome variable for the observations where the numerical variable is >= the value of the 9th decile of the numerical variable  and <= the maximum value numerical variable
## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* bivar_stats_y_num_x_cat.csv
* RR_stats_y_num_x_cat.csv
* bivar_stats_y_num_x_num.csv

## Defaults
```
bivariate_stats(
  transformed_data = transformed_data,
  output_dir = <test output directory>,
  outcome = gear
  )  
```
## Tests
