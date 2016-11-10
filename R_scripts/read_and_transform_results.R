library(dplyr)
library(readr)

data_path = 'C:/Users/hjayanti/Documents/IMS/Pipeline/palab_design/example_data/'
res_path = 'C:/Users/hjayanti/Documents/IMS/Pipeline/palab_design/example_output_csvs/'
input <- 'mtcars.csv'

# Read in the example dataset
x <- read.csv(paste0(data_path, input), stringsAsFactors=FALSE, na.strings=c("","NA"))

# Functions to help produce var_config_generator.csv
X_vars <- str(x) %>% data.frame

num_unique <- function(x) {
  length(unique(x))
}

sapply(x, num_unique)

# Read and transform 
missing_flag <- 'missing'
#********assumes missing values are coded as na
x[is.na(x)] <- missing_flag 
x[x == "-99"] <- missing_flag 
x[x == "-999"] <- missing_flag 


# Produce transformed_data outputs
transformed_data <- x
transformed_data[x=="missing"] <- NA
write.csv(transformed_data, paste0(res_path, "transformed_data.csv"), na = "")
saveRDS(transformed_data, paste0(res_path, "transformed_data.rds"))

