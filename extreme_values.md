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
    * Name of CSV file with user defined set of thresholds for the numerical variables.
    * First column: _VariableName_, the name of the variable to be changed (with relevant variable type prefix).
    * Second column: _Cap_, the value at which the variable should be capped.
    * There can be no variables listed in the CSV.

## Function  
* Check if the user has specified the thresholds.
* If the user has specified the thresholds then produce a dataset called `exu_transformed_data`:
 * Check that the input file has two columns and at least one row.
 * Check that the variables listed in `ex_val_thrsh.csv` exists in `transformed_data`.
 * For each listed variable replace values greater than the corresponding threshold value with the threshold value directly, i.e. x[x>thrsh] = thrsh.
* If the user has not specified the thresholds then produce a dataset called `exd_transformed_data`:
  * Compute the 99th percentile for each numerical variable in `transformed_data` (as identified by the prefix "n_").
  * For each numerical variable, replace values greater than the value at the 99th percentile with the value at the 99th percentile, i.e. x[x>x_p99] = x_p99
  * Produce a CSV called `p99_num_<input_dataset>` (e.g. p99_num_diabetes_cohort.csv where diabetetes_cohort is the name of the input dataset):
    * This CSV is to inform users as to which variables have been capped and at which point.
    * Collect the values at the 99th percentiles along with their variable name and store these in a csv with two columns and as many rows as there are numerical variables.

## Outputs
All CSVs below should be output to the output_dir, overwriting a previous version if necessary.

If the user has defined the thresholds:
* `exu_transformed_data.rds`
  * RDS file of `exu_transformed_data`.
* If `output_csv` = "Y", output a csv of `exu_transformed_data`
  * This file should have the same name as the input dataset with a suffix of "\_exu".

If the user has not defined the thresholds:
* `exd_transformed_data.rds`
  * RDS file of `exd_transformed_data`
* If `output_csv` = "Y", output a csv of `exd_transformed_data`
  * This file should have the same name as the input dataset with a suffix of "\_exd".

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
