# Correlational analysis

## Purpose
This function will alert the user to any correlations between the variables.

## Internal Dependencies
`read_transform`

## Name
`correlation_xbyx`

## Parameters
* `input`
  * Full path and name of the R dataset of same name output by `read_transform`.
* `output_dir`
  * The directory into which all outputs will be output to.

## Function
* Calculate the [Pearson’s correlation coefficient](https://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient) for every pair of variables.
* Produce `correlation_xbyx.csv` with the following columns:
  * _Variable1_: Name of variable 1
  * _Variable2_: Name of variable 2
  * _Correlation_: The correlation coefficient
  * _AbsCorrelation_: Absolute value of the correlation coefficient
  * _P-Value_: p-value of correlation coefficient
* This table should be sorted by descending _AbsCorrelation_ to highlight the most correlated pair of variables.

## Output
All CSVs below should be output to the `output_dir`.
* correlation_xbyx.csv

## Defaults
```
correlation_xbyx(
  input =,
  output_dir =,
  )  
```

## Example call
```
output_dir <- "D:/data/cars1/"
input_rds <- str_c(output_dir, "transformed_data.rds")

correlation_xbyx(
  input = transformed_data_rds,
  output_dir = output_dir,
  )  
```
## Tests
