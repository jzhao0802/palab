# Open file

## Purpose
This function will simply extract the input's extension (.rds or .csv), read in the file and return it as an R data.frame, to be used with the other functions in this package.

## Implementation details
Please use data.table and/or readr packages to ensure fast execution.

## Internal Dependencies
None

## Name
`open`

## Parameters
* `input`
  * Full path and name of the CSV or .rds file.

## Function
* Opens file (.rds or .csv) and returns it as R data.frame.

## Return
R data frame.

## Defaults
```
open(
  input =,
  )  
```

# Example call
```
open(
  input = "D:/data/cars1/input/mt_cars_transformed.csv",
  )
```
