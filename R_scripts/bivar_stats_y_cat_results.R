#*************paths*****************************************
path <- 'C:/Users/odoyle/Documents/TECH/R-pipeline/'
path_data <- paste0(path, 'def_master/example_data/')
path_output <- paste0(path, 'def_master/example_output_csvs/')
path_meta <- paste0(path, 'def_master/example_metadata_files/')

#************load data***********************************
x <- read.csv(paste0(path_data, 'mtcars.csv'),stringsAsFactors=FALSE, na.strings=c("","NA"))
vtype <- read.csv(paste0(path_meta, 'var_config.csv'))
missing_flag <- 'missing'
x[x == "-99"] <- missing_flag
x[x == "-999"] <- missing_flag
#**************paritition data by variable type************

#outcome variable
y <- x$vs

#numerical
nv_names <- vtype[vtype$Type == 'n',]
nx <- x[, which(names(x) %in% nv_names$ColumnName)]
nx$vs <- NULL

#categorical
cv_names <- vtype[vtype$Type == 'c',]
cx <- x[, which(names(x) %in% cv_names$ColumnName)]


#**************functions**********************************


mean_outcome_var_level <- function(x,y,level){
  xt <- x[x != missing_flag]
  yt <- (y[x != missing_flag])
  mu <- mean(as.numeric(xt[yt == level]))
  return(mu)
}

sd_outcome_var_level <- function(x,y,level){
  xt <- x[x != missing_flag]
  yt <- (y[x != missing_flag])
  sd <- sd(as.numeric(xt[yt == level]))
  return(sd)
}

min_outcome_var_level <- function(x,y,level){
  xt <- x[x != missing_flag]
  yt <- (y[x != missing_flag])
  mn <- min(as.numeric(xt[yt == level]))
  return(mn)
}

percentile_outcome_var_level <- function(x,y,level, p){
  xt <- x[x != missing_flag]
  yt <- (y[x != missing_flag])
  pc <- quantile(as.numeric(xt[yt == level]),p)
  return(pc)
}

distinct_levels <- function(x) {
  unique(x[x != 'missing'])
}


num_of_levels <- function(x) {
  length(unique(x[x != 'missing']))
}

num_not_missing_level <- function(x,level) {
  length(x[x != missing_flag & x == level])
}


num_not_missing_y_level <- function(x,y,y_level) {
  xt <- x[x != missing_flag]
  yt <- (y[x != missing_flag])
  length(xt[yt==y_level])
}

num_not_missing_x_level_y_level <- function(x,x_level,y, y_level) {
  xt <- x[x != missing_flag]
  yt <- (y[x != missing_flag])
  length(xt[xt == x_level & yt==y_level])
}
#******************************bivariate statistics for numerical variables******************************

bvs_n <- data.frame(matrix(nrow = ncol(nx), ncol = 35))
colnames(bvs_n)[1] <- 'Variable'
colnames(bvs_n)[2] <- 'NonMissing_0'
colnames(bvs_n)[3] <- 'NonMissingPrp_0'
colnames(bvs_n)[4] <- 'Missing_0'
colnames(bvs_n)[5] <- 'MissingPrp_0'
colnames(bvs_n)[6] <- 'Mean outcome_0'
colnames(bvs_n)[7] <- 'SD_0'
colnames(bvs_n)[8] <- 'Min_0'
colnames(bvs_n)[9] <- 'P1_0'
colnames(bvs_n)[10] <- 'P5_0'
colnames(bvs_n)[11] <- 'P10_0'
colnames(bvs_n)[12] <- 'P25_0'
colnames(bvs_n)[13] <- 'P_50_0'
colnames(bvs_n)[14] <- 'P_75_0'
colnames(bvs_n)[15] <- 'P_90_0'
colnames(bvs_n)[16] <- 'P_95_0'
colnames(bvs_n)[17] <- 'P_99_0'
colnames(bvs_n)[18] <- 'Max_0'
colnames(bvs_n)[19] <- 'NonMissing_1'
colnames(bvs_n)[20] <- 'NonMissingPrp_1'
colnames(bvs_n)[21] <- 'Missing_1'
colnames(bvs_n)[22] <- 'MissingPrp_1'
colnames(bvs_n)[23] <- 'Mean outcome_1'
colnames(bvs_n)[24] <- 'SD_1'
colnames(bvs_n)[25] <- 'Min_1'
colnames(bvs_n)[26] <- 'P1_1'
colnames(bvs_n)[27] <- 'P5_1'
colnames(bvs_n)[28] <- 'P10_1'
colnames(bvs_n)[29] <- 'P25_1'
colnames(bvs_n)[30] <- 'P_50_1'
colnames(bvs_n)[31] <- 'P_75_1'
colnames(bvs_n)[32] <- 'P_90_1'
colnames(bvs_n)[33] <- 'P_95_1'
colnames(bvs_n)[34] <- 'P_99_1'
colnames(bvs_n)[35] <- 'Max_1'
ct = 1
for (i in 1:ncol(nx)){
    bvs_n[i,1] <- colnames(nx)[i]
    bvs_n[i,2] <- num_not_missing_y_level(nx[,i], y, 0)
    bvs_n[i,3] <- round(num_not_missing_y_level(nx[,i], y, 0)/length(nx[,i]),2)
    bvs_n[i,4] <- sum((nx[,i]== missing_flag) & (y==0))
    bvs_n[i,5] <- round(sum((nx[,i]== missing_flag) & (y==0))/length(nx[,i]),2)
    bvs_n[i,6] <- round(mean_outcome_var_level(nx[,i], y, 0),2)
    bvs_n[i,7] <- round(sd_outcome_var_level(nx[,i], y, 0),2)
    bvs_n[i,8] <- round(percentile_outcome_var_level(nx[,i], y, 0, 0),2)
    bvs_n[i,9] <- round(percentile_outcome_var_level(nx[,i], y, 0, 0.01),2)
    bvs_n[i,10] <- round(percentile_outcome_var_level(nx[,i], y, 0, 0.05),2)
    bvs_n[i,11] <- round(percentile_outcome_var_level(nx[,i], y, 0, 0.1),2)
    bvs_n[i,12] <- round(percentile_outcome_var_level(nx[,i], y, 0, 0.25),2)
    bvs_n[i,13] <- round(percentile_outcome_var_level(nx[,i], y, 0, 0.5),2)
    bvs_n[i,14] <- round(percentile_outcome_var_level(nx[,i], y, 0, 0.75),2)
    bvs_n[i,15] <- round(percentile_outcome_var_level(nx[,i], y, 0, 0.90),2)
    bvs_n[i,16] <- round(percentile_outcome_var_level(nx[,i], y, 0, 0.95),2)
    bvs_n[i,17] <- round(percentile_outcome_var_level(nx[,i], y, 0, 0.99),2)
    bvs_n[i,18] <- round(percentile_outcome_var_level(nx[,i], y, 0, 1),2)
    bvs_n[i,19] <- num_not_missing_y_level(nx[,i], y, 1)
    bvs_n[i,20] <- round(num_not_missing_y_level(nx[,i], y, 1)/length(nx[,i]),2)
    bvs_n[i,21] <- sum((nx[,i]== missing_flag) & (y==1))
    bvs_n[i,22] <- round(sum((nx[,i]== missing_flag) & (y==1))/length(nx[,i]),2)
    bvs_n[i,23] <- round(mean_outcome_var_level(nx[,i], y, 1),2)
    bvs_n[i,24] <- round(sd_outcome_var_level(nx[,i], y, 1),2)
    bvs_n[i,25] <- round(percentile_outcome_var_level(nx[,i], y, 1, 0),2)
    bvs_n[i,26] <- round(percentile_outcome_var_level(nx[,i], y, 1, 0.01),2)
    bvs_n[i,27] <- round(percentile_outcome_var_level(nx[,i], y, 1, 0.05),2)
    bvs_n[i,28] <- round(percentile_outcome_var_level(nx[,i], y, 1, 0.1),2)
    bvs_n[i,29] <- round(percentile_outcome_var_level(nx[,i], y, 1, 0.25),2)
    bvs_n[i,30] <- round(percentile_outcome_var_level(nx[,i], y, 1, 0.5),2)
    bvs_n[i,31] <- round(percentile_outcome_var_level(nx[,i], y, 1, 0.75),2)
    bvs_n[i,32] <- round(percentile_outcome_var_level(nx[,i], y, 1, 0.90),2)
    bvs_n[i,33] <- round(percentile_outcome_var_level(nx[,i], y, 1, 0.95),2)
    bvs_n[i,34] <- round(percentile_outcome_var_level(nx[,i], y, 1, 0.99),2)
    bvs_n[i,35] <- round(percentile_outcome_var_level(nx[,i], y, 1, 1),2)
    
  
}
write.csv(bvs_n, file = paste0(path_output,"bivar_stats_y_cat_x_num.csv"), row.names = FALSE)


#******************************descriptive statistics for categorical variables******************************

sum_levels_list <- lapply(cx, num_of_levels)
total_levels <- Reduce("+", sum_levels_list)
bvs_c <- data.frame(matrix(nrow = (total_levels), ncol = 8))
colnames(bvs_c)[1] <- 'Categorical variable'
colnames(bvs_c)[2] <- 'Level'
colnames(bvs_c)[3] <- 'Count_0'
colnames(bvs_c)[4] <- 'Proportion of Level_0'
colnames(bvs_c)[5] <- 'Proportion of Outcome_0'
colnames(bvs_c)[6] <- 'Count_1'
colnames(bvs_c)[7] <- 'Proportion of Level_1'
colnames(bvs_c)[8] <- 'Proportion of Outcome_1'
ct = 1
for (i in 1:nrow(cv_names)){
  n_levels <- num_of_levels(cx[,i])
  levels <- distinct_levels(cx[,i])
  for (j in 1:n_levels){
    bvs_c[ct,1] <- colnames(cx)[i]
    bvs_c[ct,2] <- levels[j]
    bvs_c[ct,3] <- num_not_missing_x_level_y_level(cx[,i], levels[j], y, 0)
    bvs_c[ct,4] <- num_not_missing_x_level_y_level(cx[,i], levels[j], y, 0)/sum(y==0)
    bvs_c[ct,5] <- num_not_missing_x_level_y_level(cx[,i], levels[j], y, 0)/num_not_missing_level(cx[,i], levels[j])
    bvs_c[ct,6] <- num_not_missing_x_level_y_level(cx[,i], levels[j], y, 1)
    bvs_c[ct,7] <- num_not_missing_x_level_y_level(cx[,i], levels[j], y, 1)/sum(y==1)
    bvs_c[ct,8] <- num_not_missing_x_level_y_level(cx[,i], levels[j], y, 1)/num_not_missing_level(cx[,i], levels[j])
    ct = ct + 1 
  }
}

write.csv(bvs_c, file = paste0(path_output,"bivar_stats_y_cat_x_cat.csv"), row.names = FALSE)

