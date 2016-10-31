# Replace extreme values in numerical variables

## Purpose
This function will replace extreme values in continuous variables with either a user defined value or a data-driven value.

## Dependencies
`read_and_transform`

## Name
`replace_extreme_vals`

## Inputs
* `transformed_data`
  * R dataset output by `read_and_transform`
* `output_dir`
  * The directory into which all outputs will be saved.
* `output_csv`
  * This flag indicates if the transformed data set should be saved as a csv file. This can either be "Y" or "N".
* `ex_val_thrsh.csv`
    * CSV file with user defined set of thresholds for the continuous variables. This file should have two columns where the first column corresponds to the variable name (with relevant variable type prefix) and the second column corresponds to the value at which the variable should be capped.  

## Function  
* Check if the user has specified the thresholds.
* If the user has specified the thresholds then produce a dataset called `exu_transformed_data`:
 * Check that the input file has two columns and at least one row.
 * Check that the variables listed in `ex_val_thrsh.csv` exists in `transformed_data`.
 * For each listed variable replace values greater than the corresponding threshold value with the threshold value directly, i.e. x[x>thrsh] = thrsh.
* If the user has not specified the thresholds then produce a dataset called `exd_transformed_data`:
  * Compute the 99th percentile for each numerical variable in `transformed_data` (as identified by the prefix "n_").
  * For each numerical variable replace values greater than the value at the 99th percentile with the value at the 99th percentile, i.e. x[x>x_p99] = x_p99
  * Collect the values at the 99th percentiles along with their variable name and store these in a csv with two columns and as many rows as there are numerical variables - `p99_num`

## Outputs
All CSVs below should be output to the output_dir, overwriting a previous version if necessary.
If the user has defined the thresholds:
* `exu_transformed_data.rds`
  * RDS containing the dataset where the a user defined collection of numberical variables have been capped using user defined thresholds.
  * If `output_csv` = "Y", output a csv file with the full set of variables as present in `exu_transformed_data` but where the appropriate numerical variables have been capped. This file should have the same name as the input dataset with a suffix of "\_exu".
If the user has not defined the thresholds:
* `exd_transformed_data.rds`
  * RDS containing the dataset where all numberical variables have been capped using the 99th percentile as the threshold.
  * If `output_csv` = "Y", output a csv file with the full set of variables as present in `exu_transformed_data` but where the appropriate numerical variables have been capped. This file should have the same name as the input dataset with a suffix of "\_exd".
  * Write `p99_num` as a csv with the file name which is the same as the input dataset but with prefix `p99_num_` (e.g. p99_num_diabetes_cohort.csv where diabetetes_cohort is the name of the input dataset).


## Defaults
```
replace_extreme_vals(
  transformed_data = transformed_data,
  output_dir = <test output directory>
  )  
```
## Tests
