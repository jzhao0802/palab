# Variable configuration generator

## Purpose
This function will read in the a small sample of the original data from CSV input and guesses the column types.
The file that is ouput will be used to create `prefix`var_config.csv which is an input to the next function, `read_transform`.

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
* `prefix`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.

## Function
* Read in the first `sample_row` lines of `input_csv`. If `input_csv` doesn't have enough rows (default is 1000), read in as many as possible.
* Produce `prefix`var_config.csv with the following columns:
  * _ColumnName_: Name of the column `input_csv`
  * _Type_: This is the type of the column as guessed by the read function. <options of read>This field can take one of several values:
    * Categorical - for categorical columns
    * Numerical - for numerical columns
    * Other - for all other columns
  * _NumUniqueValues_: This is the number of unqiue values that the column contains.
* Every column that appears in `input_csv` should also appear as a row in `prefix`var_config.csv and must have a _Type_.

## Return
* var_config (R data.frame)

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* `prefix`var_config.csv
* The default of `prefix` is '', so the function produces var_config.csv by default.

## Defaults
```
var_config_generator(
  input_csv = ,
  sample_rows = 1000,
  prefix = ''
  output_dir=
  )  
```

## Example call
```
var_config <- var_config_generator(
  input_csv = "D:/data/cars1/input/mt_cars.csv",
  prefix = "cars",
  output_dir = "D:/data/cars1"
  )
```
## Tests
* Using the provided toy example for [input_csv](./example_data/mtcars.csv): all outputs should exactly match the provided examples for results [output](./example_output_csvs/var_config_generated.csv)
