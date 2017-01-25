# Dummy variables

## Purpose
This function will take in an R data.frame and convert all nominal categorical variables with k levels, into k-1 dummy variables.

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
* `dummy_var_config`
  * Full path and name of the CSV containing the dummy var configuration.
  * Example file is [here](../example_metadata_files/dummy_var_config.csv)
* `name_desc`
  * Full path and name of the CSV containing the names and descriptions of columns in `input`.
* `prefix`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.
* `output_csv`
  * This can either be TRUE or FALSE.

## Function
* If no `dummy_var_config.csv` is provided then, for each categorical variable (as defined by `var_config`) with k levels, create k-1 dummy variables using the contrasts function of R, and remove the original column.
  * The levels of each categorical variable should be ordered alphabetically before creating the derived dummy variables.
  * The first variable in this alphabetically ordered list is the reference variable.
* If `dummy_var_config.csv` is provided then only the variables listed in the file should be transformed into dummy variables.
  * If no reference category is provided for the variable, the reference variable should be as above, the first in alphabetical order.
  * If a reference category is provided for the variable, the function should use this and throw an errof if the category doesn't exist.  
* If certain categorical variables have more than 10 levels, the function should give a warning to the user, listing the problematic columns.
* If the original categorical variable's name is `cat`, and it has k=3 levels: `A`, `B`, `C` then `A` becomes the reference variable (unless otherwise specified), and the column names of the k-1 dummy variables should be: `cat_B_A`, `cat_C_A`.
* Therefore
  * an observation with `cat` = `A` is enconded as `cat_B_A` = 0, `cat_C_A` = 0
  * an observation with `cat` = `B` is enconded as `cat_B_A` = 1, `cat_C_A` = 0
  * an observation with `cat` = `C` is enconded as `cat_B_A` = 0, `cat_C_A` = 1
* If `cat` has missing values, another dummy variable called `cat_missing_A` should be created.
  * An observation where `cat` is missing is enconded as `cat_B_A` = 0, `cat_C_A` = 0, `cat_missing_A` = 1
  * For all observations where `cat` is one of the k levels, `cat_missing_A` = 0
* As these the dummfied dataset may get output to CSV for use later on, all variable names must not have any special characters.
  * All special character in a variable name should be replaced with an underscore.
  * For example, if a variable A has a level called "100MG/day", the name of the dummy_var should be `A_100MG_day_<reflevel>`
* Here is a clear example of dummy encoding: http://www.ats.ucla.edu/stat/r/library/contrast_coding.htm
* A new `var_config` file should be created that has all the original categorical variables removed and replaced with the dummy variables.
* If `name_desc.csv` (for details have a look at `var_desc` function) is provided add each dummy variable to it as. For the example variable above, `cat`:
  * `Var` should be the newly created column name of the dummy variable, e.g. `cat_B_A`.
  * `Name` should be `cat: B vs A`.
  * `Desc` should be `Categorical variable: cat, level B vs level A`.

## Return
* `prefix`dummified (R data.frame)
	* The data frame `input`, with the categorical variables dropped, and replaced with the dummy vars. All categorical variables in this data frame should be numeric.

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* `prefix`name_desc_dummyfied.csv
  * A new name_desc file that is identical to `name_desc` except for the categorical variables.
* `prefix`var_config_dummyfied.csv
  * A new var_config file that is identical to `var_config` except for the categorical variables.
  * This should be written out every time the function is run. The most common thing to do after the function is run, is to put the output through univariate stats, which needs a var_config.csv.
* `prefix`dummyfied.csv
  * If `output_csv` = TRUE, write transformed data to a CSV.

## Defaults
```
dummy_vars(
  input =,
  var_config =,
  name_desc = '',
  prefix = '',
  output_dir =,
  output_csv = FALSE
  )  
```

# Example call
```
cars_dummy <- dummy_vars(
  input = cars$data,
  var_config = var_config,
  prefix = "cars",
  output_dir = "D:/data/cars1",
  output_csv = FALSE
  )
```
