# Read and transform data

## Purpose
This function will read in the original data from CSV input and transform it such that it is ready for further analysis. It will rename columns and populate missing data.

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
  * First column: _ColumnName_, the name of the column in the input dataset.
  * Second column: _Type_.
    This indicates what type the column in the input dataset is.
    * "O" for an attribute
    * "C" for a categorical variable
    * "N" for a numerical variable

    Every entry in the data metadata must have a value in _Type_.
  * Third column contains the value of that variable which denotes it is missing.
    * For example, "-999" or "NULL" or "."
    * There can only be one value per column.
    * It need not be popuated for all columns.
* `output_csv`
  * This can either by "Y" or "N".
* `output_dir`
  * The directory into which all outputs will be output to.

## Function
* Read in the input dataset and metadata files.
* Rename all columns by prefixing them with the type specified in the data metadata.
  * E.g. patientID -> O_patientID
  * If a column is in the input dataset but not in the data metadata, it should NOT be included in the transformed dataset.
  * If a variable is in the data metadata but not in the input dataset, it should NOT added to the transformed dataset.
* Transform the missing values for each column
    * If the missing value for that column (as specified in the data metadata) is seen in that column, it must be replaced with the R standard for missing, i.e. "NULL".
    * If the data metadata has no missing value specified, it shold be assumed that a blank, i.e. "" indicates missing.
* Produce a summary comparing the original and transformed dataset The report should contain:
  * Number of observations in the original and transformed dataset.
  * Number of each type of column for the original and transformed dataset.
    * E.g. Number of categorical variables, number of attributes
  * Names of columns dropped from the original dataset.
  * Names of columns in the data metadata but not in the input dataset.

## Output
All CSVs below should be output to the `output_dir`.
* `transformed_data`
  * R dataset containing the transformed dataset.
* input_dataset\_trans.csv
  * If `output_csv` = "Y", output a CSV of the transformed dataset.
  * Same name as the input dataset, but with a suffix of "\_trans".
* input_dataset\_summary.csv
  * Same name as the input dataset but with a suffix of "\_report".
  * This is always output.
  * If it already exists, it should overwrite the previous summary CSV.

## Defaults
```
read_and_transform(
  input_dataset_location = <location of test dataset>,
  input_dataset = <name of test dataset> ,
  data_metadata = <name of test data metadata> ,
  output_csv = "Y"   ,
  output_dir = <test output directory>
  )  
```
## Tests
