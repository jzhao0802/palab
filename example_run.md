## var config
```
var_config <- var_config_generator(
  input_csv = "D:/data/cars1/input/mt_cars.csv",
  output = "cars",
  output_dir = "D:/data/cars1"
  )
```
In memory:
* cars_var_config

On disk:
* cars_var_config.csv

## read_transform
```
cars <- read_transform(
  input_csv = "D:/data/cars1/input/mt_cars.csv",
  var_config = "D:/data/cars1/var_config.csv"
  missing_values = "-999, 0, -99",
  max_levels = 100,
  prefix = "cars",
  output_dir = "D:/data/cars1",
  output_csv = TRUE,
  outcome_var = “gear”
  )
```
In memory:
* cars$data
* cars$report

On disk:
* cars.csv
* cars_report.csv

## univariate_stats
```
cars_uni <- univariate_stats(
  input=cars$data,
  var_config = "D:/data/cars1/var_config.csv"
  prefix = "cars",
  output_dir="D:/data/cars1/",
  )  
```
In memory:
* cars_uni$univar_stats_x_cat
* cars_uni$univar_stats_x_cat_melted
* cars_uni$univar_stats_x_num
* cars_uni$univar_stats_problems

On disk:
* cars_univariate_cat.csv
* cars_univariate_num.csv
* cars_univariate_melted.csv
* cars_univariate_problems.csv

## bivariate_stats_cat
```
cars_bivar <- bivar_stats_y_cat(
  input=cars$data,
  var_config = "D:/data/cars1/var_config.csv"
  prefix = "cars",
  output_dir="D:/data/cars1/",
  outcome_var = "gear"
  )
```

In memory:
* cars_bivar$bivar_stats_y_cat_x_cat
* cars_bivar$bivar_stats_y_cat_x_num

On disk:
* cars_bivar_stats_y_cat_x_cat.csv
* cars_bivar_stats_y_cat_x_num.csv

## bivariate_stats_num
```
cars_bivar_num <- bivar_stats_y_cat(
  input=cars$data,
  var_config = "D:/data/cars1/var_config.csv"
  prefix = "cars",
  output_dir="D:/data/cars1/",
  outcome_var = "gear"
  )
```  

In memory:
* cars_bivar_num$bivar_stats_y_num_x_cat
* cars_bivar_num$bivar_stats_y_num_x_num
* cars_bivar_num$RR_stats_y_num_x_cat

On disk:
* cars_bivar_stats_y_num_x_cat.csv
* cars_bivar_stats_y_num_x_num.csv
* cars_RR_stats_y_num_x_cat.csv

## extreme_values
```
cars_extreme <- extreme_values(
  input = cars$data,
  var_config = "D:/data/cars1/var_config.csv"
  pth = 0.99,
  ex_val_thrsh =,
  prefix = "cars",
  output_dir="D:/data/cars1/",
  output_csv = TRUE
  )  
```

In memory:
* cars_extreme$ex
* cars_extreme$ex_val_thrsh

On disk:
* cars_ex.csv
* cars_ex_val_thrsh.csv

## correlation
```
cars_cor <- correlation(
  input = cars$data,
  var_config = "D:/data/cars1/var_config.csv"
  prefix = "cars",
  output_dir="D:/data/cars1/"
  )  
```
In memory:
* cars_cor

On disk:
* cars_correlation.csv

## binning
```
cars_binned <- binning(
  input=cars$data,
  var_config = "D:/data/cars1/var_config.csv"
  prefix = "cars",
  output_dir="D:/data/cars1/"
  )  
```

In memory:
* cars_binned

On disk:
* cars_binned.csv

## dummy_vars
```
cars_dummy <- dummy_vars(
  input = cars$data,
  var_config = "D:/data/cars1/var_config.csv"
  prefix = "cars",
  output_dir = "D:/data/cars1",
  output_csv = FALSE
  )
```
In memory:
* cars_dummy

On disk:
* cars_dummified.csv
