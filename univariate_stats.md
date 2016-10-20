# Univarate Statistics

## Purpose
This function will produce a summary of each variable in the input dataset. It will help the user understand the data better and spot any issues with the variables.  

## Dependancies
`read_and_transform`

## Name
`univariate_stats`

## Inputs
* `transformed_data`
  * R dataset output by `read_and_transform`
* `output_dir`
  * The directory into which all outputs will be output to.
* `metadata_location`
  * Full path to directory containing the metadata files.
* `univariate_stats_categorical_metadata`
  * Name of a CSV file containing information on which statistics to calculate for categorical variables, in `metadata_location`.
  * Example file is [here](../example_metadata_files/univariate_stats_categorical_metadata.csv)
  * First column: _StatName_, the name of column in the output of the univariate statstics.
  * Second column: _Active_, either "Y" or "N".
  * Third column: _Description_, a description of the statistic to help the user to decide if they want it active.
  * Fourth column: _ExampleOutput_, example output from the statistic, to help the user decide if they want it active.
* `univariate_stats_numerical_metadata`
  * Name of a CSV file containing information on which statistics to calculate for numerical variables, in `metadata_location`.
  * Example file is [here](../example_metadata_files/univariate_stats_numerical_metadata.csv)
  * File structure is same as `univariate_stats_categorical_metadata`.

## Function
* Read in the metadata files and alert the user of any unrecognised statistics.
* For columns prefixed with "O_", no stats should be calculated.
* For numerical variables , i.e. those prefixed with "N_":
  * Calculate all the stats with Active = "Y" in `univariate_stats_numerical_metadata.csv`.
* For categorical variables, i.e. those prefixed with "C_":
  * Calculate all the stats with Active = "Y" in `univariate_stats_categorical_metadata`.
  * Produce a full frequency table containing all levels for all variables. The table should have the following columns:
    * _Variable_: Name of the categorical variable.
    * _Level_: The value of the level in that variable.
    * _Count_: Count of observations which have this variable equal to this level.
    * _Percentage_: Percentage of observations which have this variable equal to this level.

## Output
All CSVs below should be output to the `output_dir`.
* univariate_stats_numerical.csv
  * CSV of the stats in `univariate_stats_numerical_metadata` calculated for numerical variables in the data.
* univariate_stats_categorical.csv
  * CSV of the stats in `univariate_stats_categorical_metadata` calculated for categorical variables in the data.
* univariate_freq_categorical.csv
  * CSV of the full frequency table.

## Defaults
```
univariate_stats(
  transformed_data = transformed_data,
  output_dir = <test output directory>,
  metadata_location = <location of test metadata>,
  univariate_stats_categorical_metadata = univariate_stats_categorical_metadata.csv,
  univariate_stats_numerical_metadata = univariate_stats_numerical_metadata.csv,
  )  
```
## Tests
