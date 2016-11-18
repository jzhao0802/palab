# Correlational analysis

## Purpose
This function provides metrics to assess if there's multicollinearity between the predictors in an input matrix.
## Internal Dependencies
`read_transform` and `dummy_vars`
## Name
`multicollinearity`
asdasdadasdsa
## Parameters
* `input`
  * R data frame output by `dummy_vars`
* `vif_thrsh`
  * Float with default value of 5.
* `ci_thrsh`
  * Float with a default value of 15.
* `output`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.

## Function
* Calculate Variance inflation factor for all predictors in `input` and also the condition index of the whole matrix.
* If any of the columns of the input data.frame isn't numeric, throw an error and let the user know which column(s) to check.
* Produce `output`multicollinearity.csv with the following columns (ordered in decreasing order by VIF):
  * _Variable_: Name of variable 1
  * _VIF_: https://www.wikiwand.com/en/Variance_inflation_factor
* If the VIF of any variable >= `vif_thrsh`, print out the variable's name and its VIF.
* Calculate the condition index (CI) as the sqrt((e_max)/(e_min)), where e_max and e_min are the largest and smallest eigenvalues of the correlation matrix of the `input` matrix X (i.e. X'X after column standardising X).
* Print out the CI for the user.

## Return
* If at least one variable's VIF > `vif_thrsh` OR CI > `ci_thrsh` return False, otherwise return True.

## Output
All CSVs below should be output to the `output_dir`.
* `output`multicollinearity.csv
* The default of `output` is '', so the function produces multicollinearity.csv by default.

## Defaults
```
multicollinearity(
  input =,
  vif_thrsh=5,
  ci_thrsh=15,
  output='',
  output_dir =,
  )  
```

## Example call
```
output_dir <- "D:/data/cars1/"
input_rds <- str_c(output_dir, "transformed_data.rds")

multicollinearity(
  input = transformed_data_rds,
  output_dir = output_dir,
  )  
```