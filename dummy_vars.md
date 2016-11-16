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
  * R data frame output by `var_config_generator`.
* `output`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_csv`
  * This can either be TRUE or FALSE.
* `output_dir`
  * The directory into which all outputs will be written to.

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
* If there's a `name_desc.csv` (for details have a look at `var_rename` function) in the `output_dir`, add each dummy variable to it as:
  * `var_name` should be the newly created column name of the dummy variable, e.g. `cat_B_A`.
  * `var_long_name` should be `cat: B vs A`.
  * `var_desc` should be `Categorical variable: cat, level B vs level A`.

## Return
R data frame holding the transformed data with dummy vars and original categorical variables removed so that each column is numeric.

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* `name_desc.csv`
  * Updated as described above.
* `output`.rds
  * RDS file of transformed data written to `output_dir`
* `output`.csv
  * If `output_csv` = "Y", write transformed data to a CSV.

## Defaults
```
dummy_vars(
  input =,
  var_config =,
  output_csv = FALSE,
  output = 'transformed_dummyfied',
  output_dir =
  )  
```

# Example call
```
dummy_vars(
  input = "D:/data/cars1/input/mt_cars_transformed.csv",
  var_config = "D:/data/cars1/metadata/var_config.csv",
  output_csv = FALSE,
  output = 'transformed_dummyfied',
  output_dir = "D:/data/cars1"
  )
```
