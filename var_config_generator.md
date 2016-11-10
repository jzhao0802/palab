# Variable configuration generator

## Purpose
This function will read in the a small sample of the original data from CSV input and guesses the column types.
The file that is ouput will be used to create `var_config.csv` which is an input to the next function, `read_and_transform`.

## Name
`var_config_generator`

## Internal Dependencies
None

## Parameters
* `input_dataset`
  * Full path and name of the CSV containing the input dataset.
  * Format of the file will always be a CSV.  
  * First row of the CSV will always be the column names, and there are never any row names.
* `sample_rows`
  * The number of rows to read from the input dataset.
* `output_dir`
  * The directory into which all outputs will be written to.

## Function
* Read in the first `sample_row` lines of `input_dataset`.
* Produce var_config_generated.csv with the following columns:
  * _ColumnName_: Name of the column `input_dataset`
  * _TypeGenerated_: This is the type of the column as guessed by the read function. <options of read>This field can take one of several values:
    * Categorical - for categorical columns
    * Numerical - for numerical columns
    * Other - for all other columns
  * _NumUniqueValues_: This is the number of unqiue values that the column contains.
* Every column that appears in `input_dataset` should also appear as a row in `var_config_generated` and must have a _TypeGenerated_.

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* var_config_generated.csv

## Defaults
```
var_config_generator(
  input_dataset = ,
  sample_rows = 1000,
  output_dir=
  )  
```

## Example call
```
var_config_generator(
  input_dataset = "D:/data/cars1/input/mt_cars.csv"
  output_dir = "D:/data/cars1"
  )  
```
## Tests
* Using the provided toy example for [transformed_data](./example_data/mtcars.csv): all outputs should exactly match the provided examples for results [var_config_generated](./example_output_csvs/var_config_generated.csv)
