# Read and transform data

## Purpose
This function will read in the data from CSV input and transform it such that it is read for further analysis. It will rename columns and populate missing data.

## Name
read_and_transform

## Inputs
1. input_dataset_location
  * Full path to directory containing the input dataset.
2. input_dataset
  * This is the name of the file containing the input dataset.
  * Format of the file will always be a CSV.  
  * First row of the CSV will always be the column names, and there are never any row names.
  * All attributes and variables will
3. data_dictionary
  * This is the name of the file containing a data dictionary.
  * It must be in the same directory as referenced in input_dataset_location.
  * First column contains all the column headings in the input dataset.
  * Second column indicates what type the column in the input dataset is. It can be one of 4 types:
    1. "O" for an attribute
    2. "C" for a categorical variable
    3. "N" for a numerical variable
    4. "T" for a count variable

## Function
* Read in the input dataset.
* Rename all columns by prefixing them with the type specified in the data dictionary.
  * E.g. patientID -> O_patientID
  * If a column is in the input dataset but not in the data dictionary, it should NOT be included in the transformed dataset.
  * If a variable is in the data dictionary but not in the input dataset, it should NOT added to the transformed dataset.
* Produce a summary of the input dataset and transformation. The report should contain:
  * Number of observations in the original and transformed dataset.
  * Number of each type of column for the original and transformed dataset.
  * Names of columns dropped from the original dataset.
  * Names of columns in the data dictionary but not in the input dataset.

## Output
All datasets below should be output to the input_dataset_location.
1. CSV of the transformed dataset with renamed variables.
  * Same name as the input dataset, but with a suffix of "_trans_".
2. CSV of the summary dataset
  * Same name as the input dataset but with a suffix of "_report_".

## Tests
1. The transformed dataset should only have columns that are prefixed with "O", "C", "N" or "T".
2. If either of the inputs doesn't exist, the function should error.
