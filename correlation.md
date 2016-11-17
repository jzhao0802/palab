# Correlational analysis

## Purpose
This function calculates the correlations between the variables/columns of a numeric R data.frame.

## Internal Dependencies
`read_transform` and `dummy_vars`

## Name
`correlation`

## Parameters
* `input`
  * R data frame output by `dummy_vars`
* `method`
  * String specifying the type of correlation to calculate. Default = 'spearman'
    * 'spearman': https://www.wikiwand.com/en/Spearman's_rank_correlation_coefficient
    * 'pearson': https://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient
* `output`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.

## Function
* Calculate the correlation meassure specified in the `method` parameter for every pair of variables.
* If any of the columns of the input data.frame isn't numeric, throw an error and let the user know which column(s) to check.
* Produce `output`correlation.csv with the following columns:
  * _Variable1_: Name of variable 1
  * _Variable2_: Name of variable 2
  * _Correlation_: The correlation coefficient
  * _AbsCorrelation_: Absolute value of the correlation coefficient
  * _P-Value_: p-value of correlation coefficient
  * _FDR_BH_P-Value_: p-value after correcting with FDR (Benjamini Hochberg): https://www.wikiwand.com/en/False_discovery_rate#/Benjamini.E2.80.93Hochberg_procedure
  * _FDR_BHY_P-Value_: p-value after correcting with FDR (Benjamini Hochberg Yekutieli): https://www.wikiwand.com/en/False_discovery_rate#/Benjamini.E2.80.93Hochberg.E2.80.93Yekutieli_procedure
  * _Bonferroni_P-Value_: p-value after correcting with Bonferroni: https://www.wikiwand.com/en/Bonferroni_correction
  
* This table should be sorted by descending _AbsCorrelation_ to highlight the most correlated pair of variables. The correlation matrix is symmetric, please make sure that each pair is present only once and not twice.

## Output
All CSVs below should be output to the `output_dir`.
* `output`correlation.csv
* The default of `output` is '', so the function produces correlation.csv by default.

## Defaults
```
correlation(
  input =,
  method='spearman',
  output='',
  output_dir =,
  )  
```

## Example call
```
output_dir <- "D:/data/cars1/"
input_rds <- str_c(output_dir, "transformed_data.rds")

correlation(
  input = transformed_data_rds,
  output_dir = output_dir,
  )  
```