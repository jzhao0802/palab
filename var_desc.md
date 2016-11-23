# Variable description

## Purpose
Rename column names of an input data.frame with more readable ones by looking them up in an external file.

## Internal Dependencies
None

## Name
`var_desc`

## Parameters
* `input`
  * R data frame output by `read_transform`
* `name_desc`
  * Full path and name of the CSV containing the names and descriptions of columns in `input`.
* `output`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.

## Function
* `name_desc` is a lookup table provided by the user. It has three columns:
  * `Var`: name of a column in `input`
  * `Name`: human/client readable long variable name. It will contain spaces.
  * `Desc`: description of the variable. This info is not used by this function, it is simply for internal use, and documenting variables.
* The table in `name_desc` is read in by this function and used as a lookup table to rename all columns with human/client readable ones. The column names in `input` map to the `Var` column of `name_desc`.
* If a given column name of `input` is not found in `name_desc`'s `Var` column, then that column should not be renamed.

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