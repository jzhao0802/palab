# Replace extreme values in numerical variables

## Purpose
This function will replace extreme values in continuous variables with either a user defined value or a data-driven value.

## Dependencies
`read_and_transform`

## Name
`extreme_values`

## Inputs
* `transformed_data`
  * R dataset output by `read_and_transform`
* `output_dir`
  * The directory into which all outputs will be saved.
* `output_csv`
  * This flag indicates if the transformed data set should be saved as a csv file. This can either be "Y" or "N".
* `metadata_location`
  * Full path to directory containing ex_val_thrsh.csv.
* `ex_val_thrsh`
    * Input file where the user can provide their own thresholds for capping numerical variables or a flag indicating that a variable should not be capped. For all other numerical variables not listed in this file then the value of that variable at the 99th percentile will be used (x_p99) will be used to cap the variable.
    * First column: _Variable_, the name of the variable to be changed (with relevant variable type prefix; e.g. mpg is has been previously renamed (via `read_and_transform`) to n_mpg as it is a numerical variable).
    * Second column: _Thrsh_, a numerical value which represents a user defined threshold at which the variable should be capped. A flag of N indicates that the variable should not be capped.


## Function  
* If the user has provided the `ex_val_thrsh.csv` file:
 * Check that the input file has two columns <names here>. Return an error if these criteria are not met.<Not N, not numerical>
 * Check that there are no variables listed in `ex_val_thrsh` do not exist in `transformed_data`. Otherwise return an error specifying which variable name in `ex_val_thrsh` does not exist in `transformed_data`.
 * For variables where the row entry for _Thrsh_ is numerical: cap values greater than the provided threshold value, i.e. x[x>thrsh] = thrsh.
 * For numerical variables that are contained in `transformed_data` but not listed in `ex_val_thrsh`:  compute p99 for each variable and use it to replace values greater than the p99 value for that variable, i.e. x[x>p99] = p99.
 * For variables where the row entry for _Thrsh_ is N: do not alter these variables.
 * Produce `ex_val_thrsh_output.csv` which takes the same <duplicate> form to `ex_val_thrsh`:
   * First column: the list of variables that were capped for extreme values.
   * Second column: the threshold value at which the variable was capped which could be either user defined value or x_p99.
 * Create a duplicate of `transformed_data` called `ex_transformed_data`. Update the numerical variables in `ex_transformed_data` with those that have been capped.

* If the user has not provided `ex_val_thrsh` then the default assumption is that all numerical variables should be capped at p99:
  * Compute the 99th percentile for each numerical variable in `transformed_data` (as identified by the prefix "n_").
  * For each numerical variable, replace values greater than the value at the 99th percentile with the value at the 99th percentile, i.e. x[x>x_p99] = x_p99
  * Create a duplicate of `transformed_data` called `ex_transformed_data`. Update the all numerical variables in `ex_transformed_data` with their capped equivalents.
  * Produce `ex_val_thrsh_output.csv` which takes a similar form to `ex_val_thrsh`:
    * First column: the list of all numerical variables that were capped for extreme values.
    * Second column: x_p99 for the corresponding variable.

## Outputs
All CSVs below should be output to the output_dir, overwriting a previous version if necessary.

* `ex_transformed_data.rds`
  * RDS file of `ex_transformed_data`.
* If `output_csv` = "Y", output a csv of `ex_transformed_data`
  * This file should have the same name as the input dataset with a prefix of of "ex\_".
* `ex_val_thrsh_output.csv`
  * This file logs the thresholds that were used to cap the numerical variables.
## Defaults
```
extreme_values(
  transformed_data = transformed_data,
  output_dir = <test output directory>,
  output_csv = "N",
  metadata_location = <location of test metadata>,
  ex_val_thrsh = ex_val_thrsh.csv,
  )  
```
## Tests
