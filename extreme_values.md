# Replace extreme values in numerical variables

## Purpose
This function will replace extreme values in numerical variables with either a user-defined value or a data-driven value.

## Internal Dependencies
`read_transform`

## Name
`extreme_values`

## Parameters
* `input`
  * R dataset output by `read_transform`
* `var_config`
    * Full path and name of the CSV containing the variable configuration.
    * Example file is [here](./example_metadata_files/var_config.csv)
* `pth`
  * A numerical value between 0 and 1 which represents the percentile at which variables the will be capped. The default value 0.99 which represents the 99th percentile.
* `ex_val_thrsh`
    * Input file where the user can provide their own thresholds for capping numerical variables or a flag indicating that a variable should not be capped. For all other numerical variables not listed in this file then the value of that variable at the `pth` percentile will be used to cap the variable.
    * First column: _Variable_, the name of the variable.
    * Second column: _Thrsh_, a numerical value which represents a user-defined threshold at which the variable should be capped. A flag of "N" indicates that the variable should not be capped.
    * Example file: [ex_val_thrsh.csv](./example_metadata_files/ex_val_thrsh.csv)
* `output`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be saved.
* `output_csv`
  * This flag indicates whether the transformed data set should be saved as a csv file. This can either be TRUE or FALSE.

## Function  
* If the user has provided the `ex_val_thrsh.csv` file:
 * Check that the input file has two columns and at least one row. Return an error if these criteria are not met.
 * Check that the variables listed in `ex_val_thrsh` exist in `input`. Otherwise return an error specifying which variable name in `ex_val_thrsh` does not exist in `input`.
 * For variables where the row entry for _Thrsh_ is numerical: cap values greater than or equal to the provided threshold value, i.e. x[x>thrsh] = thrsh.
 * For numerical variables that are contained in `input` but not listed in `ex_val_thrsh`:  compute the value at the `pth` percentile (`x_pth`) for each variable and use it to replace values greater than or equal to the value at `pth` percentile for that variable, i.e. `x[x>=x_pth] = x_pth`.
 * For variables where the row entry for _Thrsh_ is "N": do not alter these variables.
 * Produce `ex_val_thrsh_output.csv` which takes the same <duplicate> form to `ex_val_thrsh`:
   * First column: the list of variables that were capped for extreme values.
   * Second column: the threshold value at which the variable was capped which could be either user-defined value or x_pth.
 * Create a duplicate of `input` called `output`_ex.csv__. Update the numerical variables in `output`_ex.csv__ with those that have been capped.

* If the user has not provided `ex_val_thrsh` then the default assumption is that all numerical variables should be capped at `x_pth`:
  * Compute the value at the percentile level stored in `pth` (`x_pth`) for each numerical variable in `input`.
  * For each numerical variable, replace values greater than or equal to `x_pth` with `x_pth`, i.e. `x[x>=x_pth] = x_pth`
  * Create a duplicate of `input` called `output`_ex.csv__. Update the all numerical variables in `output`_ex.csv_ with their capped equivalents.

* Produce `output`_ex_val_thrsh_out.csv_ which takes the same form as `ex_val_thrsh`:
    * First column: the list of all numerical variables.
    * Second column: if the variable was not capped then enter the flag 'N', otherwise enter the numerical value at which the variable was capped (user-defined threshold or `x_pth`).

## Return
R data frame with the capped values.

## Outputs
All CSVs below should be output to the output_dir, overwriting a previous version if necessary.
* `output`_ex.rds
  * RDS file of `output`_ex.csv_ written to `output_dir`
* If `output_csv` = TRUE, write out `output`_ex.csv_ as a csv to `output_dir`
* `output`_ex_val_thrsh_out.csv_
  * This file logs the thresholds that were used to cap the numerical variables.

## Defaults
```
extreme_values(
  input = ,
  var_config = ,
  xperct = 0.99,
  ex_val_thrsh =,
  output = ,
  output_dir = ,
  output_csv = "False"
  )  
```

## Tests
* All outputs should have the correct format and structure as specified.
* Using the provided toy example for [input](./example_data/mtcars.csv) and [ex_val_thrsh](./example_metadata_files/ex_val_thrsh.csv) for `ex_val_thrsh`: all outputs produced should exactly match the provided examples results in [`output`_ex.csv_](./example_output_csvs/ex_mtcars.csv) [`output`_ex_val_thrsh_out.csv](./example_output_csvs/ex_val_thrsh_out.csv), with `pth` set to 0.99.
