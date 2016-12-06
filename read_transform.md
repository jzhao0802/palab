# Read and transform data

## Purpose
This function will read in the original data from CSV input and transform it such that it is ready for further analysis.

## Implementation details
Please use data.table and/or readr packages to ensure fast execution.

## Name
`read_transform`

## Internal Dependencies
None

## Parameters
* `input_csv`
* Full path and name of the CSV containing the input dataset.
  * Format of the file will always be a CSV.  
  * First row of the CSV will always be the column names, and there are never any row names.
* `var_config`
  * Full path and name of the CSV containing the variable configuration.
  * Example file is [here](../example_metadata_files/var_config.csv)
  * First column: _ColumnName_, the name of the column in the input dataset.
  * Second column: _Type_.
    This indicates what type the column in the input dataset is.
    * "Categorical" for a categorical variable, (or c for short)
    * "Numerical" for a numerical variable, (or n for short)
    * "Key" for the column which is the primary key, (or k for short)
    * "Other" for an attribute or any other type of column not listed above, (or o for short)
  * Every entry in the data metadata must have a value in _Type_.
* `max_levels`
  * The maximum number of levels that a variable labelled as categorical in the data_metadata should have.
* `missing_values`
  * A comma delimited string of missing values for all columns.
  * e.g. "-999, 0, -99"
* `output`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.
* `output_csv`
  * This can either be TRUE or FALSE.
* `outcome`
  * The name of variable to use as an outcome.

## Function
* Read in the input_csv and var_config.
* Check that variables are compatable with their type.
  * If a variable is classed as numerical but has character values in it, the function should error.
  * If a variable is classed as categorical but has more than `max_levels` different values, the function should output a warning to the user.
  * There should only be one variable listed as the key, and it should have as many unique values as there are observations in `input_csv`.
  * No checks are carried out for other variables.
  * If there are columns in `input_csv` which are not listed in `var_config.csv`, they should be dropped.
  * If there are columns in `var_config.csv` which are not in `input_csv`, they should not be added.
* Produce a dataset called `output`:
  * Transform the missing values for each column - look for any of the values in `missing_values` in all columns, and replace with the R standard for missing, i.e. "NA".
  * Remove any observations where the outcome is missing.
* Produce a report (and save it as `output`report.csv if `output_csv` = TRUE) of the different tables involved, with the following information:
  * Number of observations in original data
  * Number of observations in transformed data
  * Number of observations in original data where the outcome was missing.
  * Number of columns in original data
  * Number of columns in transformed data
  * Number of numerical columns in transformed data  
  * Number of other columns in transformed data
  * Columns in `var_config` but not in input data
  * Columns in input data but not in `var_config`

## Return
List containing these data frames:
* data - the transformed data
* report - the report mentioned above

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* `output`.csv
  * If `output_csv` = TRUE, write transformed data to a csv.
* `output`report.csv
  * If `output_csv` = TRUE, write report as csv.

## Defaults
```
read_transform(
  input_csv =,
  var_config =,
  missing_values =,
  max_levels = 100,
  output = 'transformed_data',
  report_csv = NULL,
  output_dir =,
  output_csv = FALSE
  )  
```

# Example call
```
cars <- read_transform(
  input_csv = "D:/data/cars1/input/mt_cars.csv",
  var_config = "D:/data/cars1/metadata/cars_var_config.csv",
  missing_values = "-999, 0, -99",
  max_levels = 100,
  output = "cars",
  output_dir = "D:/data/cars1",
  output_csv = TRUE,
  outcome_var = “gear”
  )
```

## Tests
* Using the provided toy example for [input_csv](./example_data/mtcars.csv): all outputs should exactly match the provided examples for results:
  * [transformed data CSV](./example_output_csvs/transformed_data.csv)
