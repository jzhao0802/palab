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
* `cutpoints`
  * List of integers or floats. Default = c(5)
* `method`
  * String, either "r" for range or "q" for quantiles. Default = "q".
* `column`
  * List of column names to perform binning on. Default = c() which means all numeric columns.
* `replace_val`
  * String, either "o" for ordinal or "m" for mean. Default = "m".
* `output`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.
* `output_csv`
  * This can either be TRUE or FALSE.

## Function

* The function performs binning on all numeric columns by default. Columns are deemed continous/numeric based on the `var_config` file. `var_config` will be manually checked by us before using binning so no further checks are needed from this function.
* By default each numeric column is split into quintiles, i.e. 5 equal portions (`cutpoints` = c(5), `method` = "q", `column` = c(), `replace_val` = "m")
* If `column` is not an empty list, only those columns should be binned that are included in `column`, e.g.: `column` = c("age", "income"). 
* If either of the columns in the list of `column` is not a numeric feature based on `var_config` the function should throw an error and terminate.
* `cutpoints` determine the number of buckets the function uses to bin a given numeric variable. If it's a list with length of one, e.g. `cutpoints` = c(12), the function must use `cutpoints` - 1 points to split the variables into `cutpoints` equal bins.
* If it's a list with a length greater than one, e.g. `cutpoints` = c(25, 50, 75), the function must use each item in the list as a cutpoint to form the buckets for binning.
* The `cutpoints` param has to be interpretted together with the `method` param:
  * If `method` = "q", the function works with quantiles, i.e. cutpoints divide the range of a probability distribution into continuous intervals with equal probabilities. 
  * If `method` = "r", the function works on the range of variables. It takes the minimum and maximum values of all the columns in the `column` list (i.e. this could be all numeric columns, a list of 2 columns, or just a single one). Then the range of (maximum-minimum) is divided into equal-range bins based on `cutpoints`. 
    * If the length of `cutpoints` is one, the `cutpoints` number of equidistant bins are used across the range of (maximum-minimum). 
    * If `cutpoints` is a list, then the bins are formed accordingly. E.g. `cutpoints` = c(10, 20, 40) will define 4 bins: 
      1. -Inf < x <=  10
      2. 10 < x <= 20
      3. 20 < x <= 40
      4. 40 < x <= Inf
* If `replace_val` = "o", then each continuous value is replaced with the number of bin it belongs to. For example if `cutpoints` = c(3), `method` = "q", `column` = c("age"), `replace_val` = "o", and "age" = c(15, 16, 17, 18, 19, 20, 21, 22, 23), the binned version of "age" = c(1, 1, 1, 2, ,2, 2, 3, 3, 3). It's vital to preserve the ordinal structure of the data. This is why, the first 3 rows (15, 16,17) will become 1 and not 2 or 3. 
* If `replace_val` = "m", then each continuous value is replaced with the mean of values within the bin it belongs to. For example if `cutpoints` = c(3), `method` = "q", `column` = c("age"), `replace_val` = "m", and "age" = c(15, 16, 17, 18, 19, 20, 21, 22, 23), the binned version of "age" = c(16, 16, 16, 19, ,19, 19, 22, 22, 22).

## Return
R data frame holding the transformed data (i.e. numeric columns binned).

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* `output`binned.rds
  * RDS file of transformed data written to `output_dir`
* `output`binned.csv
  * If `output_csv` = TRUE, write transformed data to a CSV.
* The default of `output` is '', so the function produces binned.rds and binned.csv if `output_csv`=TRUE.

## Defaults
```
binning(
  input=,
  var_config=,
  cutpoints=c(5),
  method="q",
  column=c(),
  replace_val="m",
  output='',
  output_dir=,
  output_csv=FALSE
  )  
```

## Example call
```
binning(
  input=transformed_data,
  var_config="D:/data/cars1/metadata/var_config.csv",
  output_dir="D:/data/cars1/"
  )  
```