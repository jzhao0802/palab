# Replace extreme values in numerical variables

## Purpose
This function will replace extreme values in continuous variables with either a user defined value or a data-driven value.

## Dependencies
`read_and_transform`

## Name
`extreme_values`

## Parameters
* `transformed_data`
  * R dataset output by `read_and_transform`
* `output_dir`
  * The directory into which all outputs will be saved.
* `output_csv`
  * This flag indicates whether the transformed data set should be saved as a csv file. This can either be "Y" or "N".
* `var_config`
    * Full path and name of the CSV containing the variable configuration.
    * Example file is [here](file:///C:/Users/odoyle/)
    * First column: _ColumnName_, the name of the column in the input dataset.
    * Second column: _Type_.
      This indicates what type the column in the input dataset is.
      * "Categorical" for a categorical variable
      * "Numerical" for a numerical variable
      * "Key" for the column which is the primary key
      * "Other" for an attribute or any other type of column not listed above.
    * Every entry in the data metadata must have a value in _Type_.
* `perct`
  * A numerical value between 0 and 1 which represents the percentile at which variables the will be capped. The default value 0.99 which represents the 99th percentile.
* `ex_val_thrsh`
    * Input file where the user can provide their own thresholds for capping numerical variables or a flag indicating that a variable should not be capped. For all other numerical variables not listed in this file then the value of that variable at the 99th percentile will be used (x_p99) will be used to cap the variable.
    * First column: _Variable_, the name of the variable.
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
  * Compute the value at the percentile level stored in `perct` for each numerical variable in `transformed_data`.
  * For each numerical variable, replace values greater than the value at the `perct` percentile with the value at the `perct` percentile, i.e. x[x>x_perct] = x_perct
  * Create a duplicate of `transformed_data` called `ex_transformed_data`. Update the all numerical variables in `ex_transformed_data` with their capped equivalents.
  * Produce `ex_val_thrsh_out.csv` which takes the same form as `ex_val_thrsh`:
    * First column: the list of all numerical variables that were capped for extreme values.
    * Second column: value at the `perct` percentile for the corresponding variable.

## Outputs
All CSVs below should be output to the output_dir, overwriting a previous version if necessary.

* `ex_transformed_data.rds`
  * RDS file of `ex_transformed_data`.

* If `output_csv` = "TRUE", write out `ex_transformed_data` as a csv to `output_dir`

* `ex_val_thrsh_out.csv`
  * This file logs the thresholds that were used to cap the numerical variables.
## Defaults
```
extreme_values(
  transformed_data = ,
  output_dir = ,
  output_csv = "False",
  var_config = ,
  xperct = 0.99,
  ex_val_thrsh =
  )  
```
## Tests
* All outputs should have the correct format and structure as specified.
* Using the provided toy example provided [here](file:///example_data/mtcars.csv) for `transformed_data` and [here](./example_metadata_files/ex_val_thrsh.csv) - all outputs produced should exactly match the provided examples results: [ex_val_thrsh_output.csv](file:///example_output_csvs/ex_val_thrsh_output.csv), and DATA LINK HERE with `perct` set to 0.99.
