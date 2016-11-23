# Dummy variables

## Purpose
This function will take in an R data.frame and convert all nominal categorical variables with k levels, into k-1 dummy variables. 

## Implementation details
Here is a clear example of dummy encoding:
http://www.ats.ucla.edu/stat/r/library/contrast_coding.htm

## Internal Dependencies
`read_transform`

## Name
`dummy_vars`

## Parameters
* `input`
  * R data frame output by `read_transform`.
* `var_config`
  * Full path and name of the CSV containing the variable configuration.
  * Example file is [here](../example_metadata_files/var_config.csv)
* `name_desc`
  * Full path and name of the CSV containing the names and descriptions of columns in `input`.
* `output`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.
* `output_csv`
  * This can either be TRUE or FALSE.

## Function
* For each categorical varible (as defined by `var_config`) with k levels, create k-1 dummy variables using the contrasts function of R, and remove the original column. The resulting data.frame must have only numeric features.
* If certain categorical variables have more than 10 levels, the function should give a warning to the user, listing the problematic columns.
* The levels of each categorical variable should be ordered alphabetically before creating the derived dummy variables.
* If the original categorical variable's name is `cat`, and it has k=3 levels: `A`, `B`, `C` then the column names of the k-1 dummy variables should be: `cat_B_A`, `cat_C_A`. 
* Therefore 
  * a sample with `cat` = `A` is enconded as (0, 0),
  * a sample with `cat` = `B` is enconded as (1, 0),
  * a sample with `cat` = `C` is enconded as (0, 1),
  * where the first binary flag corresponds to `cat_B_A` and the second to `cat_C_A`.
* A new var_config file should be created that has all the original categorical variables removed and replaced with the dummy variables, see Output section.
* If `name_desc.csv` (for details have a look at `var_desc` function) is provided add each dummy variable to it as:
  * `Var` should be the newly created column name of the dummy variable, e.g. `cat_B_A`.
  * `Name` should be `cat: B vs A`.
  * `Desc` should be `Categorical variable: cat, level B vs level A`.

## Return
R data frame holding the transformed data with dummy vars and original categorical variables removed so that each column is numeric.

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* `name_desc`
  * Updated/over-write as described above.
* `output`var_config_dummyfied.csv
  * A new var_config file that is identical to `var_config` except the categorical variables.
* `output`dummyfied.rds
  * RDS file of transformed data written to `output_dir`
* `output`dummyfied.csv
  * If `output_csv` = TRUE, write transformed data to a CSV.
* The default of `output` is '', so the function produces dummyfied.rds and dummyfied.csv if `output_csv`=TRUE.

## Defaults
```
dummy_vars(
  input =,
  var_config =,
  name_desc = '',
  output = '',
  output_dir =,
  output_csv = FALSE
  )  
```

# Example call
```
dummy_vars(
  input = "D:/data/cars1/input/mt_cars_transformed.csv",
  var_config = "D:/data/cars1/metadata/var_config.csv",
  output = 'transformed_dummyfied',
  output_dir = "D:/data/cars1",
  output_csv = FALSE
  )
```
