# Variable configuration generator

## Purpose
This function will read in the a small sample of the original data from CSV input and guesses the column types.
The file that is ouput will be used to create `output`var_config.csv which is an input to the next function, `read_transform`.

## Name
`var_config_generator`

## Internal Dependencies
None

## Parameters
* `input_csv`
  * Full path and name of the CSV containing the input dataset.
  * Format of the file will always be a CSV.  
  * First row of the CSV will always be the column names, and there are never any row names.
* `sample_rows`
  * The number of rows to read from the input dataset.
* `output`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.

## Function
* Read in the first `sample_row` lines of `input_csv`. If `input_csv` doesn't have enough rows (default is 1000), read in as many as possible.
* Produce `output`var_config.csv with the following columns:
  * _ColumnName_: Name of the column `input_csv`
  * _TypeGenerated_: This is the type of the column as guessed by the read function. <options of read>This field can take one of several values:
    * Categorical - for categorical columns
    * Numerical - for numerical columns
    * Other - for all other columns
  * _NumUniqueValues_: This is the number of unqiue values that the column contains.
* Every column that appears in `input_csv` should also appear as a row in `output`var_config.csv and must have a _TypeGenerated_.

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* `output`var_config.csv
* The default of `output` is '', so the function produces var_config.csv by default.

## Defaults
```
var_config_generator(
  input_csv = ,
  sample_rows = 1000,
  output = ''
  output_dir=
  )  
```

## Example call
```
var_config_generator(
  input_csv = "D:/data/cars1/input/mt_cars.csv"
  output_dir = "D:/data/cars1"
  )  
```
## Tests
* Using the provided toy example for [input_csv](./example_data/mtcars.csv): all outputs should exactly match the provided examples for results [output](./example_output_csvs/var_config_generated.csv)
