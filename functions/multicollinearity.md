# Multicollinearity

## Purpose
This function automatically selects an uncorrelated subset of predictors from the input data, i.e. it reduces the multicollinearity in the design matrix.

## Internal Dependencies
`read_transform` and `dummy_vars`

## Name
`multicol`

## Parameters
* `input`
  * R data frame output by `dummy_vars`
* `var_config`
  * Full path and name of the CSV containing the variable configuration.
  * Example file is [here](../example_metadata_files/var_config.csv)
* `vif_thrsh`
  * Float with default value of 5.
* `outcome_var`
  * The name of the outcome variable.
* `prefix`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.


## Function
* Firstly, remove the outcome variable from the `input` data frame and retain only the predictors, i.e. the numeric and categorical variables, using `var_config`.
* Process:
  1. Calculate Variance Inflation Factor (VIF) for each predictor, using all other predictors in `input`.
  2. Identify the predictor with the highest VIF, and remove it from the data set.
  3. Recalculate VIF for each each predictor in the remaining set.
  4. Repeat (2) and (3) until each remaining variable's VIF is below `vif_thrsh`.
    * At stages (1) and (3), also calculate the Condition Index (CI) of the design matrix.
* Definitions:
  * VIF_j is calculated for the j-th predictor of `input` as 1/(1-R^2_j), where R^2_j is the R^2 value of the linear/logistic regression model fitted to the j-th predictor in `input` as the outcome variable, and all other predictors used in the design matrix to predict it. Use the VIF function in the [fmsb](https://cran.r-project.org/web/packages/fmsb/fmsb.pdf) package for this.
    * If the j_th predictor is a categorical variable with two levels, then fit a logistic regression to it using the other predictors as independent variables.
    * If the j_th predictor is a numerical variable, then fit a linear regression to it using the other predictors as independent variables.
    * In both cases the R^2 value of the model is used to calculate the VIF for the j-th predictor.
    * Please use/follow the code [here](https://beckmw.wordpress.com/2013/02/05/collinearity-and-stepwise-vif-selection/) to implement this, but eliminate the for loops and instead use parallelization to calculate the VIF.
  * The condition index (CI) is calculated as the sqrt((e_max)/(e_min)), where e_max and e_min are the largest and smallest eigenvalues of the correlation matrix of the `input` matrix X (i.e. X'X after column standardising X).
* Once all remaining predictors have a VIF <= `vif_thrsh`, create a data frame called `multicol`. This is same as the `input` data frame but now with only the variables that have VIF <= `vif_thrsh`, and the `outcome_var`.
* Create a data frame called `info` which records the iterations of the function, with the following columns:
  * _Iteration_: The iteration number.
  * _NumVar_: The number of variables which were considered in this iteration.
  * _VarRemoved_: Name of the variable which was removed in this iteration, i.e. the one that had the highest VIF.
  * _CI_: The condition index of the predictors in this iteration.

## Return
A list containing the following data frames:
* `multicol`
* `info`

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* `prefix`multicol.csv

## Defaults
```
multicol(
  input =,
  var_condif=,
  vif_thrsh=5,
  outcome_var=,
  prefix='',
  output_dir =,
  )  
```

## Example call
```
output_dir <- "D:/data/cars1/"
input_rds <- str_c(output_dir, "transformed_data.rds")

m <- multicol(
  input = transformed_data_rds,
  var_config = "myvarconfig.csv",
  outcome_var = "gears",
  output_dir = output_dir
  )  
```
