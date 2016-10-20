# Correlational analysis

## Purpose
This function will alert the user to any correlations between the variables.

## Dependancies
`read_and_transform`

## Name
`correlational`

## Inputs
* `transformed_data`
  * R dataset output by `read_and_transform`
* `output_dir`
  * The directory into which all outputs will be output to.

## Function
* Calcualte the [Pearson’s correlation coefficient](https://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient) for every pair of variables.
* Produce a table with the following columns:
  * _Variable1_: Name of variable 1
  * _Variable2_: Name of variable 2
  * _Correlation_: The correlation coefficient
  * _AbsCorrelation_: Absolute value of the correlation coefficient
  * _P-Value_: p-value of correlation coefficient
* This table should be sorted by descending _AbsCorrelation_ to highlight the most correlated variables.

## Output
All CSVs below should be output to the `output_dir`.
* correlational_analysis.csv
  * This is the table described in the function section.

## Defaults
```
univariate_stats(
  transformed_data = transformed_data,
  output_dir = <test output directory>,
  )  
```
## Tests
