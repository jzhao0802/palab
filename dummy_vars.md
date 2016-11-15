# Dummy variables

## Purpose
This function will take in an R data.frame and convert all nominal categorical variables with k levels, into k-1 dummy variables. 

## Implementation details
Here is a clear example of dummy encoding, that will be referenced throughout this document:
http://www.ats.ucla.edu/stat/r/library/contrast_coding.htm

## Internal Dependencies
`read_transform`

## Name
`dummy_vars`

## Parameters
* `transformed_data`
  * R data frame output by `read_transform`.
* `var_config`
  * R data frame output by `var_config_generator`.
* `output_dir`
  * The directory into which all outputs will be written to.

## Function
* For each categorical varible with k levels, create k-1 dummy variables using the contrasts function of R, and remove the original column. The resulting data.frame must have only numerical features.
* If certain categorical variables have more than 10 levels, the function should give a warning to the user, listing the problematic columns.
* The levels of each categorical variables should be ordered alphabetically before creating the derived dummy variables.
* If the original categorical variable's name is `cat`, and it has k=3 levels: `A`, `B`, `C` then the column names of the k-1 dummy variables should be: `cat_B_A`, `cat_C_A`. 
* Therefore 
  * a sample with `cat` = `A` is enconded as (0, 0),
  * a sample with `cat` = `B` is enconded as (1, 0),
  * a sample with `cat` = `C` is enconded as (0, 1),
  * where the first binary flag corresponds to `cat_B_A` and the second to `cat_C_A`.
  

## Output
All files below should be output to the `output_dir`, overwriting a previous version if necessary.
* univar_stats_x_cat.csv
* univar_stats_x_cat_melted.csv
* univar_stats_x_num.csv

## Defaults
```
univariate_stats(
  transformed_data=,
  var_config=,
  output_dir=,
  )  
```

## Example call
```
univariate_stats(
  transformed_data=transformed_data,
  var_config=var_config,
  output_dir="D:/data/cars1/",
  )  
```

## Tests
* All outputs should have the correct format and structure as specified.
* Using the provided toy example for [transformed_data](./example_data/mtcars.csv): all outputs should exactly match the provided examples for the results [univar_stats_x_cat](./example_output_csvs/univar_stats_x_cat.csv);
[univar_stats_x_cat_melted](./example_output_csvs/univar_stats_x_cat_melted.csv);
[univar_stats_x_num](./example_output_csvs/univar_stats_x_num.csv).
