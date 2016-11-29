# Create sequence variables.

## Purpose
The function reads in a list of paired variables and a set of corresponding orders (before, afterm equal) and creates a flag indicating whether the events occur in the specified order in the input data set. Note that between running `seq_var_ds` and this function we anticipate the user will have manually edited the final list of sequential variables to be created as in this step we usually consult a clincian to sense check the pairs and the ordering.

## Internal Dependencies
`seq_vars_ds`


## Parameters
* `event_dates`
  * Data frame where each column is a variable and each row is an observation.
  * The outcome variable (if provided) is represented as a binary variable.
  * For all other variables the non-missing entries should be in date format.
* `seq_vars_selection`
  A data frame with five columns. The first two columns provide the names of the variables that are paired together, i.e. `A` and `B`. The final three columns detail the order of the sequence variable and are called `Before`, `After` and `Equal`. These columns will be populated with either `TRUE` or `FALSE`.Please find an example [here](./example_data/seq_vars_selection.csv).
* `missing_values`
    * A comma delimited string of missing values for all columns.
    * e.g. "-999, 0, -99"
    * The default value is NA.
* `output`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.

## Function
* For each row in `seq_vars_selection` at least one of the order columns (Before, After or Equal) should have a value of `TRUE`. Provide a warning if this is not the case and exclude the row from further analyses below.
* Create `output`seq_vars_feats.csv which holds the sequential variables created using the specification in `seq_vars_selection`. Please find an example [here](./example_data/seq_vars_feats.csv). The first column of the data frame will be the patient id. The remaining columns will be specified as follows:
  * For each row in `seq_vars_selection` (which represents a pair of events) produce:
  * If `Before` is set to `TRUE` then create an array of flags with zero being the default value, where the length is equal to the number of rows in `event_dates`.  The flag should be set to 1 if the event named in `A` occured before the event named in `B` for that patient observation. If the observation for is missing for `A` or `B` or both then the flag should be set to NA. The mapping to the patient id should be preserved. This array of flags should be joined to `output`seq_vars_feats.csv using the patient id as the key, and the column name should be a concatenation of the following strings: the event name stored in `A`, `_BEFORE_` and the event name stored in `B` . If `Before` is set to `FALSE` then skip this column.
  * If `After` is set to `TRUE` then create an array of flags with zero being the default value, where the length is equal to the number of rows in `event_dates`.  The flag should be set to 1 if the event named in `A` occured after the event named in `B` for that patient observation. If the observation for is missing for `A` or `B` or both then the flag should be set to NA. The mapping to the patient id should be preserved. This array of flags should be joined to `output`seq_vars_feats.csv using the patient id as the key the column name should be a concatenation of the following strings: the event name stored in `A`, `_AFTER_` and the event name stored in `B` . If `After` is set to `FALSE` then skip this column.
  * If `Equal` is set to `TRUE` then create an array of flags with zero being the default value,  where the length is equal to the number of rows in `event_dates`.  The flag should be set to 1 if the event named in `A` occured at the same time as the event named in `B` for that patient observation. If the observation for is missing for `A` or `B` or both then the flag should be set to NA. The mapping to the patient id should be preserved. This array of flags should be joined to `output`seq_vars_feats.csv using the patient id as the key the column name should be a concatenation of the following strings: the event name stored in `A`, `_EQUAL_` and the event name stored in `B` . If `Equal` is set to `FALSE` then skip this column.


## Output
* `output`seq_vars_feats.csv
* The default of `output` is '', so the function produces seq_vars_feats.csv by default.

## Defaults
```
seq_vars(
  event_dates = ,
  seq_vars_selection =,
  missing_values = NA, 
  output='',
  output_dir=
  )
```  

# Example Call
```
seq_vars_create(
  event_dates = event_dates.csv,
  seq_vars_selection = ./example_data/seq_vars_selection.csv,
  missing_values = NA 
  )
```
