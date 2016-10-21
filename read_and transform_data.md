# Read and transform data

## Purpose
This function will read in the original data from CSV input and transform it such that it is ready for further analysis. It will rename columns and standardise missing data.

## Name
`read_and_transform`

## Dependancies
None

## Inputs
* `input_dataset_location`
  * Full path to directory containing the input dataset.
* `input_dataset`
  * Name of the file containing the input dataset.
  * Format of the file will always be a CSV.  
  * First row of the CSV will always be the column names, and there are never any row names.
* `metadata_location`
  * Full path to directory containing the metadata files.
* `data_metadata`
  * Name of the CSV containing the data metadata, in `metadata_location`.
  * Example file is [here](../example_metadata_files/data_metadata.csv)
  * First column: _ColumnName_, the name of the column in the input dataset.
  * Second column: _Type_.
    This indicates what type the column in the input dataset is.
    * "o" for an attribute
    * "c" for a categorical variable
    * "n" for a numerical variable
    * "k" for the column which is the primary key
    Every entry in the data metadata must have a value in _Type_.
* `missing_values`
  * A comma delimited string of missing values for all columns.
  * e.g. "-999, 0, -99"
* `max_levels`
  * The maximum number of levels that a variable labelled as categorical in the data_metadata should have.
* `output_transformed`
  * This can either be "Y" or "N".
* `output_dir`
  * The directory into which all outputs will be output to.

## Function
* Read in the input dataset and metadata files.
* Produce a dataset called `transformed_data`:
  * Rename all columns by prefixing them with the type specified in the data metadata.
    * E.g. patientID -> o_patientID
    * If a column is in the input dataset but not in the data metadata, it should NOT be included in the transformed dataset.
    * If a column is in the data metadata but not in the input dataset, it should NOT added to the transformed dataset.
  * Transform the missing values for each column
      * Look for any of the values in `missing_values` in all columns, and replace with the R standard for missing, i.e. "NULL".
* Check that variables are compatable with their type.
  * If a variable is classed as numerical but has character values in it, the function should error.
  * If a variable is classed as categorical but has more than `max_levels` different values, the function should output a warning to the user.
* Produce a `<input_dataset>_report.csv` of the different tables involved, with the following information:
  * Number of observations in original data
  * Number of observations in transformed data
  * Number of columns in original data
  * Number of columns in transformed data
  * Number of categorical columns in transformed data
  * Number of numerical columns in transformed data  
  * Number of other columns in transformed data
  * Columns in metadata but not in input data
  * Columns in input data but not in metadata

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* transformed_data.rds
  * RDS file containing the transformed dataset.
* <input_dataset>\_trans.csv
  * If `output_csv` = "Y", output a CSV of `transformed_data`.
  * Same name as the input dataset, but with a suffix of "\_trans".
* <input_dataset>\_report.csv
  * Same name as the input dataset but with a suffix of "\_report".

## Defaults
```
read_and_transform(
  input_dataset_location = <location of test dataset>,
  input_dataset = <name of test dataset>,
  metadata_location = <location of test metadata>,
  data_metadata = <name of test data metadata>,
  missing_values = ""
  max_levels = 100,
  output_csv = "Y",
  output_dir = <test output directory>
  )  
```
## Tests
