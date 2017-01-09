# Bin continuous variables

## Purpose
Bin continuous/numeric variable(s) in a data.frame into finite number of bins.

## Implementation details
It's probably a good idea to build this function modularly, i.e. write an internal functions that do binning on a single column either using the quantiles or the range of the given variable. Then this function is just a wrapper around those internal column-wise functions.

## Internal Dependencies
`read_transform`

## Name
`binning`

## Parameters
* `input`
  * R data frame output by `read_transform`
* `var_config`
  * Full path and name of the CSV containing the variable configuration.
  * Example file is [here](../example_metadata_files/var_config.csv)
* `binning_config.csv`
  * Full path and name of the CSV containing the binning configuration for each variable.
  * Example file is [here](../example_metadata_files/binning_config.csv)
  * First column: _VariableName_, the name of the column in the input dataset.
  * Second column: _NumBins_, the number of bins required for the variable. If not poplated, default to 5.
  * Third column: _Method_, either "r" for range or "q" for quantiles. If not poplated, default to "q"
  * Fourth colum: _CutPoints_, comma seperated list of cut points to split the variable into bins.
  * Fifth column: _ReplaceVal_, either "o" for ordinal or "m" for mean. If not poplated, default = "m".
* `output`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.
* `output_csv`
  * This can either be TRUE or FALSE.

## Function

* The function performs binning on all numeric columns by default. Columns are deemed continous/numeric based on the `var_config` file. `var_config` will be manually checked by us before using binning so no further checks are needed from this function.
* If a variable is not listed in `binning_config.csv`, it should not be transformed.
* If a variable is listed in `binning_config.csv`, then it is transformed as specified by the columns in the config file, and then replaces the original column in `input`
* If a variable is listed but has no values in any other column, it is by default split into quintiles, i.e. 5 equal portions (_NumBins_ = 5, _Method_ = "q", _ReplaceVal_ = "m")
* If numerical columns are not listed in `var_config`, but are listed in `binning`, the function should throw an error and terminate.

* _NumBins_ determine the number of buckets the function uses to bin the variable.
* The _NumBins_ param has to be interpretted together with the _Method_ param:
  * If _Method_ = "q", the function works with quantiles, i.e. cutpoints divide the range of a probability distribution into continuous intervals with equal probabilities.
    * All observations with the same value of the variable must belong in the same bin. This means that if q = 4 and there the value at quartile 1, 2 and 3 is the same, there will only be 2 bins, despite q being stated as 4.
    * In the event that bins are collapsed, a warning should be issued which reads as follows:
      * "Variable X was not split into 4 bins as only 2 unique cut points were found"
  * If _Method_ = "r", the function works on the range of the variable. The range of teh variable (maximum-minimum) is divided into equal-range bins based on _NumBins_.

* _CutPoints_ is used when there are specific cut points.
  * If _CutPoints_ is specified, the _NumBins_ column in `binning_config.csv` is overridden.
  * The function must use each item in the list as a cutpoint to form the buckets for binning that variable.
  * E.g. _CutPoints_ = 10, 20, 40 will define 4 bins:
    1. -Inf < x <=  10
    2. 10 < x <= 20
    3. 20 < x <= 40
    4. 40 < x <= Inf

* If _ReplaceVal_ = "o", then each continuous value is replaced with the number of bin it belongs to. For example if _NumBins_ = 3, _Method_ = "q", _VariableName_ = Age, _ReplaceVal_ = "o", and "age" = c(15, 16, 17, 18, 19, 20, 21, 22, 23), the binned version of "age" = c(1, 1, 1, 2, 2, 2, 3, 3, 3). It's vital to preserve the ordinal structure of the data. This is why, the first 3 rows (15, 16,17) will become 1 and not 2 or 3.
* If _ReplaceVal_ = "m", then each continuous value is replaced with the mean of values within the bin it belongs to. For example if _CutPoints_ = c(3), _Method_ = "q", _VariableName_ = Age, _ReplaceVal_ = "m", and "age" = c(15, 16, 17, 18, 19, 20, 21, 22, 23), the binned version of "age" = c(16, 16, 16, 19, ,19, 19, 22, 22, 22).
* Missing values should be ignored and remain missing after the binning.

## Return
* `output`binned (R data.frame)
  * This is the original data frame (`input`), with the varibles listed in `binning_config.csv` replaced with their binned versions.

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* `output`binned.csv
  * If `output_csv` = TRUE, write transformed data to a CSV.

## Defaults
```
binning(
  input=,
  var_config=,
  cutpoints=,
  method="q",
  num_bins =5,
  column=c(),
  replace_val="m",
  output='',
  output_dir=,
  output_csv=FALSE
  )  
```

## Example call
```
cars_binned <- binning(
  input=cars$data,
  var_config=var_config,
  output = "cars",
  output_dir="D:/data/cars1/"
  )
```
