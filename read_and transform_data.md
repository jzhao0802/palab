# Read and transform data

## Purpose
This function will read in the original data from CSV input and transform it such that it is ready for further analysis.

## Name
`read_and_transform`

## Internal Dependencies
None

## Parameters
* `input_dataset`
  * Full path and name of the CSV containing the input dataset.
  * Format of the file will always be a CSV.  
  * First row of the CSV will always be the column names, and there are never any row names.
* `var_config`
  * Full path and name of the CSV containing the variable configuration.
  * Example file is [here](../example_metadata_files/var_config.csv)
  * First column: _ColumnName_, the name of the column in the input dataset.
  * Second column: _Type_.
    This indicates what type the column in the input dataset is.
    * "Categorical" for a categorical variable
    * "Numerical" for a numerical variable
    * "Key" for the column which is the primary key
    * "Other" for an attribute or any other type of column not listed above.
  * Every entry in the data metadata must have a value in _Type_.
* `max_levels`
  * The maximum number of levels that a variable labelled as categorical in the data_metadata should have.
* `missing_values`
  * A comma delimited string of missing values for all columns.
  * e.g. "-999, 0, -99"
* `output_csv`
  * This can either be TRUE or FALSE.
* `output_dir`
  * The directory into which all outputs will be written to.
* `outcome`
  * The name of variable to use as an outcome.

## Function
* Read in the input_dataset and var_config.
* Check that variables are compatable with their type.
  * If a variable is classed as numerical but has character values in it, the function should error.
  * If a variable is classed as categorical but has more than `max_levels` different values, the function should output a warning to the user.
  * There should only be one variable listed as the key, and it should have as many unique values as there are observations in `input_dataset`.
  * No checks are carried out for other variables.
  * If there are columns in `input_dataset` which are not listed in `var_config.csv`, they should be dropped.
  * If there are columns in `var_config.csv` which are not in `input_dataset`, they should not be added.
* Produce a dataset called `transformed_data`:
  * Transform the missing values for each column - kook for any of the values in `missing_values` in all columns, and replace with the R standard for missing, i.e. "NA".
  * Remove any observations where the outcome is missing.
* Produce a `transformed_data_report.csv` of the different tables involved, with the following information:
  * Number of observations in original data
  * Number of observations in transformed data
  * Number of observations in original data where the outcome was missing.
  * Number of columns in original data
  * Number of columns in transformed data
  * Number of categorical columns in transformed data
  * Number of numerical columns in transformed data  
  * Number of other columns in transformed data
  * Columns in metadata but not in input data
  * Columns in input data but not in metadata

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* `transformed_data`
  * R dataset
* `var_config`
  * R dataset of var_config.csv
* transformed_data.rds
  * RDS file of `transformed_data` written to `output_dir`
* transformed_data.csv
  * If `output_csv` = "Y", output a CSV of `transformed_data`
* transformed_data_report.csv

## Defaults
```
read_and_transform(
  input_dataset =,
  var_config =,
  missing_values =,
  max_levels = 100,
  output_csv = FALSE,
  output_dir =
  )  
```

# Example call
```
read_and_transform(
  input_dataset = "D:/data/cars1/input/mt_cars.csv",
  var_config = "D:/data/cars1/metadata/var_config.csv",
  missing_values = "-999, 0, -99",
  max_levels = 100,
  output_csv = FALSE,
  output_dir = "D:/data/cars1"
  )
```

## Tests
* Using the provided toy example for [transformed_data](./example_data/mtcars.csv): all outputs should exactly match the provided examples for results:
  * [transformed_data CSV](./example_output_csvs/transformed_data.csv)
  * [transformed_data RDS](./example_output_csvs/transformed_data.rds)
