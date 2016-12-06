# Variable description

## Purpose
This function can be called on the output of `univariate_stats`, `bivar_stats_y_cat` and `bivar_stats_y_num`.
As these functions produce outputs that are intended for the clients, it will add in a column containing readable variable names.

## Internal Dependencies
`univariate_stats`, `bivar_stats_y_cat` or `bivar_stats_y_num`

## Name
`var_desc`

## Parameters
* `input`
  * R data frame output by one of `univariate_stats`, `bivar_stats_y_cat` or `bivar_stats_y_num`
  * This function can only be called on a data.frame and not on a list.
* `name_desc`
  * Full path and name of the CSV containing the lookup table.
  * Example file is [here](../example_metadata_files/name_desc.csv)
  * First column: _Variable_, the name of the column in the input dataset.
  * Second column: _Name_, human/client readable long variable name. It will contain spaces.
  * Third column: _Description_, description of the variable. This info is not used by this function, it is simply for internal use, and documenting variables.
* `output`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.

## Function
* Read in the `name_desc` CSV.
* Add an extra column into `input` called _VariableName_".
* For each value in the _Variable_, look it up in the _Name_ column in `name_desc` and place this into the _VariableName_ column.
* If for some rows there is no matching entry in the _Variable_ column, the _VariableName_ column should be left blank

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* `output`.csv
  * `input` with pretty column names written to `output_dir`.

## Defaults
```
var_desc(
  input=,
  name_desc=,
  output=,
  output_dir=,
  )  
```

## Example call
```
var_desc(
  input=transformed_data,
  name_desc="D:/data/cars1/metadata/name_desc.csv",
  output="transformed_data_pretty",
  output_dir="D:/data/cars1/"
  )  
```
