library(dplyr)
library(readr)

#data_path = 'C:/Users/hjayanti/Documents/IMS/Projects/Novartis $ Subgroup tools/Actual_Data/1109/'
#res_path = 'C:/Users/hjayanti/Documents/IMS/Projects/Novartis $ Subgroup tools/Analysis/'
#input <- 'flat_file_subgroup_1109.csv'
#var_config_location <- paste0(data_path, 'var_typing_for_ds_1109_2.csv')

var_config_location <- 'C:/Users/hjayanti/Documents/IMS/Pipeline/palab_design/example_metadata_files/var_config.csv'
res_path = 'C:/Users/hjayanti/Documents/IMS/Pipeline/palab_design/example_output_csvs/'

# Read in the example dataset
x <- transformed_data
vtype <- read.csv(var_config_location, stringsAsFactors=FALSE)

x[is.na(x)] <- missing_flag 

#partition data by variable type
#numerical
nv_names <- vtype[vtype$Type == 'numerical',]
nx <- x[,nv_names$ColumnName]

#categorical
cv_names <- vtype[vtype$Type == 'categorical',]
cx <- x[,cv_names$ColumnName]


#****************define functions*****************************
mean_no_missing <- function(x) {
  round(mean(as.numeric(x[x != missing_flag])),2)
}

num_not_missing <- function(x) {
  length(x[x != missing_flag])
}

pc_num_not_missing <- function(x) {
  round(length(x[x != missing_flag])/length(x),2)
}

num_missing <- function(x) {
  length(x[x == missing_flag])
}

pc_num_missing <- function(x) {
  round(length(x[x == missing_flag])/length(x),2)
}

distinct_not_missing <- function(x) {
  distinct(x[x != missing_flag])
}
num_of_levels <- function(x) {
  length(unique(x[x != 'missing']))
}

percentile_no_missing <- function(x,pr) {
  quantile(as.numeric(x[x != missing_flag]), pr, na.rm=TRUE)
}

sd_no_missing <- function(x) {
  sd(as.numeric(x[x != missing_flag]))
}

#******************************descriptive statistics for numerical variables******************************8

ds_n <- data.frame(matrix(nrow = nrow(nv_names), ncol = 27))
colnames(ds_n)[1] <- 'Variable'
colnames(ds_n)[2] <- 'Non-missing, N'
colnames(ds_n)[3] <- 'Non-missing, %'
colnames(ds_n)[4] <- 'Missing, N'
colnames(ds_n)[5] <- 'Missing, %'
colnames(ds_n)[6] <- 'Mean'
colnames(ds_n)[7] <- 'Standard deviation'
colnames(ds_n)[8] <- 'Minimum'
colnames(ds_n)[9] <- 'P1'
colnames(ds_n)[10] <- 'P5'
colnames(ds_n)[11] <- 'P10'
colnames(ds_n)[12] <- 'P25'
colnames(ds_n)[13] <- 'P50' 
colnames(ds_n)[14] <- 'P75'
colnames(ds_n)[15] <- 'P90'
colnames(ds_n)[16] <- 'P95'
colnames(ds_n)[17] <- 'P99'
colnames(ds_n)[18] <- 'Max'
colnames(ds_n)[19] <- 'P10'
colnames(ds_n)[20] <- 'P20'
colnames(ds_n)[21] <- 'P30'
colnames(ds_n)[22] <- 'P40'
colnames(ds_n)[23] <- 'P50' 
colnames(ds_n)[24] <- 'P60'
colnames(ds_n)[25] <- 'P70'
colnames(ds_n)[26] <- 'P80'
colnames(ds_n)[27] <- 'P90'


for (i in 1:nrow(nv_names)){
  ds_n[i,1] <- colnames(nx)[i]
  ds_n[i,2] <- num_not_missing(nx[,i])
  ds_n[i,3] <- pc_num_not_missing(nx[,i])
  ds_n[i,4] <- num_missing(nx[,i])
  ds_n[i,5] <- pc_num_missing(nx[,i])
  ds_n[i,6] <- mean_no_missing(nx[,i]) 
  ds_n[i,7] <- sd_no_missing(nx[,i])   
  ds_n[i,8] <- percentile_no_missing(nx[,i],0) 
  ds_n[i,9] <- percentile_no_missing(nx[,i],0.01) 
  ds_n[i,10] <- percentile_no_missing(nx[,i],0.05) 
  ds_n[i,11] <- percentile_no_missing(nx[,i],0.1) 
  ds_n[i,12] <- percentile_no_missing(nx[,i],0.25) 
  ds_n[i,13] <- percentile_no_missing(nx[,i],0.5) 
  ds_n[i,14] <- percentile_no_missing(nx[,i],0.75)
  ds_n[i,15] <- percentile_no_missing(nx[,i],0.9)
  ds_n[i,16] <- percentile_no_missing(nx[,i],0.95)
  ds_n[i,17] <- percentile_no_missing(nx[,i],0.99)
  ds_n[i,18] <- percentile_no_missing(nx[,i],1) 
  ds_n[i,19] <- percentile_no_missing(nx[,i],0.1) 
  ds_n[i,20] <- percentile_no_missing(nx[,i],0.2)
  ds_n[i,21] <- percentile_no_missing(nx[,i],0.3) 
  ds_n[i,22] <- percentile_no_missing(nx[,i],0.4) 
  ds_n[i,23] <- percentile_no_missing(nx[,i],0.5) 
  ds_n[i,24] <- percentile_no_missing(nx[,i],0.6)
  ds_n[i,25] <- percentile_no_missing(nx[,i],0.7)
  ds_n[i,26] <- percentile_no_missing(nx[,i],0.8)
  ds_n[i,27] <- percentile_no_missing(nx[,i],0.9)
}


#******************************descriptive statistics for categorical variables******************************


num_of_levels <- function(x) {
  length(unique(x[x != 'missing']))
}

distinct_levels <- function(x) {
  ddd <- table(x[x!="missing"]) %>% data.frame %>% arrange(desc(Freq))
  levels(ddd[,1])
}

max_levels <- cx %>% summarise_all(num_of_levels) %>% max(.)

ds_c <- data.frame(matrix(ncol = (6 + 3*max_levels), nrow =ncol(cx)))
colnames(ds_c)[1] <- 'Variable'
colnames(ds_c)[2] <- 'Non-missing, N'
colnames(ds_c)[3] <- 'Non-missing, %'
colnames(ds_c)[4] <- 'Missing, N'
colnames(ds_c)[5] <- 'Missing, %'
colnames(ds_c)[6]<- 'Number of levels'

for (i in 1:(max_levels)) {
  
  colnames(ds_c)[3*(i-1)+7] <- paste0('Level', i, ' value')
  colnames(ds_c)[3*(i-1)+8] <- paste0('Obs in level',i, ', N')
  colnames(ds_c)[3*(i-1)+9] <- paste0('Obs in level',i, ', %')
}


for (i in 1:nrow(cv_names)){
  curcol = colnames(cx)[i]
  ds_c[i,1] <- curcol
  ds_c[i,2] <- num_not_missing(cx[,i])
  ds_c[i,3] <- pc_num_not_missing(cx[,i])
  ds_c[i,4] <- num_missing(cx[,i])
  ds_c[i,5] <- pc_num_missing(cx[,i])
  
  levels <- distinct_levels(cx[,i])
  ds_c[i,6] <-  num_of_levels(cx[,i])
  
  for (j in 1:n_levels) {
    ds_c[i,(3*(j-1)+7)] <- levels[j]
    ds_c[i,(3*(j-1)+8)] <- cx %>%  
      filter_(.dots = stringr::str_c(curcol, " == '", levels[j], "'")) %>% 
      summarise(n=n())
    ds_c[i,(3*(j-1)+9)] <- round(ds_c[i,(3*(j-1)+8)] / ds_c[i,2] , 2)
  } 
}

#****************************** MELTED descriptive statistics for categorical variables******************************

ds_cm <- data.frame(matrix(ncol = (5), nrow =1))
colnames(ds_cm)[1] <- 'Variable'
colnames(ds_cm)[2]<- 'Number of levels'
colnames(ds_cm)[3] <- 'Level'
colnames(ds_cm)[4] <- 'Count'
colnames(ds_cm)[5] <- 'Proportion'

ds_c_1 <- ds_cm
for (i in 1:nrow(cv_names)){
  curcol = colnames(cx)[i]
  ds_c_1[i,1] <- curcol
  ds_c_1[i,2] <- num_of_levels(cx[,i])
  ds_c_1[i,3] <- "non-missing"
  ds_c_1[i,4] <- num_not_missing(cx[,i])
  ds_c_1[i,5] <- pc_num_not_missing(cx[,i])
}

ds_c_2 <- ds_cm
for (i in 1:nrow(cv_names)){
  curcol = colnames(cx)[i]
  ds_c_2[i,1] <- curcol
  ds_c_2[i,2] <- num_of_levels(cx[,i])
  ds_c_2[i,3] <- "missing"
  ds_c_2[i,4] <- num_missing(cx[,i])
  ds_c_2[i,5] <- pc_num_missing(cx[,i])
}

ds_c_all <- rbind(ds_c_1, ds_c_2)

for (i in 1:nrow(cv_names)){
  levels <- distinct_levels(cx[,i])
  n_levels <- num_of_levels(cx[,i])
  curcol = colnames(cx)[i]
  
  ds_c_x <- data.frame(matrix(ncol = 5, nrow =n_levels))
  colnames(ds_c_x)[1] <- 'Variable'
  colnames(ds_c_x)[2]<- 'Number of levels'
  colnames(ds_c_x)[3] <- 'Level'
  colnames(ds_c_x)[4] <- 'Count'
  colnames(ds_c_x)[5] <- 'Proportion'
  
  
  for (j in 1:n_levels) {
    ds_c_x[,1] <- curcol
    ds_c_x[,2] <- num_of_levels(cx[,i])
    ds_c_x[j,3] <- levels[j]
    ds_c_x[j,4] <- cx %>%  
                 filter_(.dots = stringr::str_c(curcol, " == '", levels[j], "'")) %>% 
                 summarise(n=n())
    ds_c_x[j,5] <- ds_c_x[j,4] / num_not_missing(cx[,i])
  } 
  
  ds_c_all <- rbind(ds_c_all, ds_c_x)
}


#****************************** Write out to CSV ******************************

write.csv(ds_n, paste0(res_path, 'univar_stats_x_num.csv'), row.names = FALSE, na = "NA")
write.csv(ds_c, paste0(res_path, 'univar_stats_x_cat.csv'), row.names = FALSE, na = "NA")
write.csv(ds_c_all, paste0(res_path, 'univar_stats_x_cat_melted.csv'), row.names = FALSE, na = "NA")


#****************************** Correlations **********************************



