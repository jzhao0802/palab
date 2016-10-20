# Bivariate Statistics

## Purpose
This function will produce a summary of how each variable varies with the outcome variable. This will help the user understand which variables are important for predicting the output and spot any issues with the variables.

## Dependancies
`read_and_transform`

## Name
`bivariate_stats`

## Inputs
* `transformed_data`
  * R dataset output by `read_and_transform`
* `output_dir`
  * The directory into which all outputs will be output to.
* `metadata_location`
  * Full path to directory containing the metadata files.
* `bivariate_stats_categorical_metadata`
  * Name of a CSV file containing information on which statistics to calculate for categorical variables, in `metadata_location`.
  * Example file is [here](../example_metadata_files/bivariate_stats_categorical_metadata.csv)
  * File structure is same as `univariate_stats_categorical_metadata`.
* `bivariate_stats_numerical_metadata`
  * Name of a CSV file containing information on which statistics to calculate for numerical variables, in `metadata_location`.
  * Example file is [here](../example_metadata_files/bivariate_stats_numerical_metadata.csv)
  * File structure is same as `univariate_stats_categorical_metadata`.


## Function
* Read in the metadata files and alert the user of any unrecognised statistics.
* For columns prefixed with "O_", no stats should be calculated.
* If the variable with a role of "outcome" is categorical, then do the following:
  * Note that for each stat in the metdata files that ends in "\_X", the stat should be calculated for each class of the outcome variable, and the name of the stat should be suffixed with that level value. E.g. if the outcome variable has 2 levels, "Increase" and "Decrease", the stat NonMissing should have 2 columns in the output CSV, "NumMissing_Increase" and "NumMissing_Decrease"
  * For numerical variables , i.e. those prefixed with "N_":
    * Calculate all the stats with Active = "Y" in `bivariate_stats_numerical_metadata.csv`
  * For categorical variables, i.e. those prefixed with "C_":
    * Calculate all the stats with Active = "Y" in `bivariate_stats_categorical_metadata.csv`
    * Produce a full frequency table containing all levels for all variables. The table should have the following columns:
      * _Variable_: Name of the categorical variable.
      * _Level_: The value of the level in that variable.
      * _Count_: Count of observations which have this variable equal to this level.
      * _Count__X_: Count of observations which have this variable equal to this level, and the outcome variable equal to X. There will one column like this for eah level of the outcome variable.
      * _Percentage_: Percentage of observations which have this variable equal to this level.
      * _Percentage__X_: Percentage of observations which have this variable equal to this level, and the outcome variable equal to X. There will one column like this for eah level of the outcome variable.

## Output
All CSVs below should be output to the `output_dir`.
* bivariate_stats_numerical.csv
  * CSV of the stats in `bivariate_stats_numerical_metadata` calculated for numerical variables in the data.
* bivariate_stats_categorical.csv
  * CSV of the stats in `bivariate_stats_categorical_metadata` calculated for categorical variables in the data.
* bivariate_freq_categorical.csv
  * CSV of the full frequency table.

## Defaults
```
bivariate_stats(
  transformed_data = transformed_data,
  output_dir = <test output directory>,
  metadata_location = <location of test metadata>,
  bivariate_stats_categorical_metadata = bivariate_stats_categorical_metadata.csv,
  bivariate_stats_numerical_metadata = bivariate_stats_numerical_metadata.csv,
  )  
```
## Tests
