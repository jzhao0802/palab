path <- 'C:/Users/odoyle/Documents/TECH/R-pipeline/'
path_data <- paste0(path, 'def_master/example_data/')
library(tidyverse)

x <- readr::read_csv(paste0(path_data, 'event_dates.csv'))

outcome <- 'outcome_var'

n_vars <- ncols(x)-2
n_pairs <- (n_vars)*(n_vars-1)/2


