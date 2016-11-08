#*************paths*****************************************
path_data <- 'F:/orla/PALab_Design/def_master/example_data/'
path_output <- 'F:/orla/PALab_Design/def_master/example_output_csvs/'
path_meta <- 'F:/orla/PALab_Design/def_master/example_metadata_files/'

#************load data***********************************
x <- read.csv(paste0(path_data, 'mtcars.csv'),stringsAsFactors=FALSE, na.strings=c("","NA"))
vtype <- read.csv(paste0(path_meta, 'var_config.csv'))
missing_flag <- 'missing'
x[x == "-99"] <- missing_flag

#**************paritition data by variable type************

#outcome variable
y <- x$mpg

#numerical
nv_names <- vtype[vtype$Type == 'n',]
nx <- x[, which(names(x) %in% nv_names$ColumnName)]
nx$mpg <- NULL

#categorical
cv_names <- vtype[vtype$Type == 'c',]
cx <- x[, which(names(x) %in% cv_names$ColumnName)]


#**************functions**********************************
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

percentile_no_missing <- function(x,pr) {
  quantile(as.numeric(x[x != missing_flag]), pr)
}
sd_no_missing <- function(x) {
  sd(as.numeric(x[x != missing_flag]))
}

corr_no_missing <- function(x,y) {
  cor(as.numeric(x[x != missing_flag]), as.numeric(y[x != missing_flag]), method="pearson")
}
corr_pval_no_missing <- function(x,y) {
  cor.test(as.numeric(x[x != missing_flag]), as.numeric(y[x != missing_flag]), method="pearson")$p.value
}

mean_in_decile <- function(x,y,up,dw) {
  xt <- as.numeric(x[x != missing_flag])
  yt <- as.numeric(y[x != missing_flag])
  x1 <- quantile(xt, up)
  x2 <- quantile(xt, dw)
  mu_val <- mean(yt[xt >= x1 & xt < x2])
  return(mu_val)
}

mean_in_decile_tenth <- function(x,y,up,dw) {
  xt <- as.numeric(x[x != missing_flag])
  yt <- as.numeric(y[x != missing_flag])
  x1 <- quantile(xt, up)
  x2 <- quantile(xt, dw)
  mu_val <- mean(yt[xt >= x1 & xt <= x2])
  return(mu_val)
}

mean_outcome_var_level <- function(x,y,level){
  xt <- x[x != missing_flag]
  yt <- (y[x != missing_flag])
  mu <- mean(as.numeric(yt[xt == level]))
  return(mu)
}

sd_outcome_var_level <- function(x,y,level){
  xt <- x[x != missing_flag]
  yt <- (y[x != missing_flag])
  sd <- sd(as.numeric(yt[xt == level]))
  return(sd)
}

min_outcome_var_level <- function(x,y,level){
  xt <- x[x != missing_flag]
  yt <- (y[x != missing_flag])
  mn <- min(as.numeric(yt[xt == level]))
  return(mn)
}

percentile_outcome_var_level <- function(x,y,level, p){
  xt <- x[x != missing_flag]
  yt <- (y[x != missing_flag])
  pc <- quantile(as.numeric(yt[xt == level]),p)
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
#******************************bivariate statistics for numerical variables******************************

bvs_n = data.frame(matrix(nrow = ncol(nx), ncol = 13))
colnames(bvs_n)[1] <- 'Variable name'
colnames(bvs_n)[2] <- 'Correlation coefficient (Pearson\'s) between variable and VA12'
colnames(bvs_n)[3] <- 'P-value of correlation coefficient (Pearson\'s) between variable and VA12'
colnames(bvs_n)[4] <- 'Mean VA in 1st decile'
colnames(bvs_n)[5] <- 'Mean VA in 2nd decile'
colnames(bvs_n)[6] <- 'Mean VA in 3rd decile'
colnames(bvs_n)[7] <- 'Mean VA in 4th decile'
colnames(bvs_n)[8] <- 'Mean VA in 5th decile'
colnames(bvs_n)[9] <- 'Mean VA in 6th decile'
colnames(bvs_n)[10] <- 'Mean VA in 7th decile'
colnames(bvs_n)[11] <- 'Mean VA in 8th decile'
colnames(bvs_n)[12] <- 'Mean VA in 9th decile'
colnames(bvs_n)[13] <- 'Mean VA in 10th decile'



for (i in 1:ncol(nx)){
  bvs_n[i,1] <- colnames(nx)[i]
  bvs_n[i,2] <- corr_no_missing(nx[,i], y)
  bvs_n[i,3] <- corr_pval_no_missing(nx[,i], y)
  bvs_n[i,4] <- mean_in_decile(nx[,i], y, 0, 0.1)
  bvs_n[i,5] <- mean_in_decile(nx[,i], y, 0.1, 0.2)
  bvs_n[i,6] <- mean_in_decile(nx[,i], y, 0.2, 0.3)
  bvs_n[i,7] <- mean_in_decile(nx[,i], y, 0.3, 0.4)   
  bvs_n[i,8] <- mean_in_decile(nx[,i], y, 0.4, 0.5)
  bvs_n[i,9] <- mean_in_decile(nx[,i], y, 0.5, 0.6)
  bvs_n[i,10] <- mean_in_decile(nx[,i], y, 0.6, 0.7)
  bvs_n[i,11] <- mean_in_decile(nx[,i], y, 0.7, 0.8)
  bvs_n[i,12] <- mean_in_decile(nx[,i], y, 0.8, 0.9)
  bvs_n[i,13] <- mean_in_decile_tenth(nx[,i], y, 0.9, 1)
  
}

write.csv(bvs_n, file = paste0(path_output,"bivar_stats_y_num_x_num.csv"), row.names = FALSE)


#******************************descriptive statistics for categorical variables******************************

sum_levels_list <- lapply(cx, num_of_levels)
total_levels <- Reduce("+", sum_levels_list)
bvs_c <- data.frame(matrix(nrow = (total_levels), ncol = 15))
colnames(bvs_c)[1] <- 'Categorical variable'
colnames(bvs_c)[2] <- 'Level'
colnames(bvs_c)[3] <- 'Mean VA12'
colnames(bvs_c)[4] <- 'SD VA12 '
colnames(bvs_c)[5] <- 'Minimum VA12'
colnames(bvs_c)[6] <- '1st percentile VA12'
colnames(bvs_c)[7] <- '5th percentile VA12'
colnames(bvs_c)[8] <- '10th percentile VA12'
colnames(bvs_c)[9] <- '25th percentile VA12'
colnames(bvs_c)[10] <- '50th percentile VA12'
colnames(bvs_c)[11] <- '75th percentile VA12'
colnames(bvs_c)[12] <- '90th percentile VA12'
colnames(bvs_c)[13] <- '95th percentile VA12'
colnames(bvs_c)[14] <- '99th percentile VA12'
colnames(bvs_c)[15] <- 'Maximum VA12'
ct = 1
for (i in 1:nrow(cv_names)){
  n_levels <- num_of_levels(cx[,i])
  levels <- distinct_levels(cx[,i])
  for (j in 1:n_levels){
    bvs_c[ct,1] <- colnames(cx)[i]
    bvs_c[ct,2] <- levels[j]
    bvs_c[ct,3] <- mean_outcome_var_level(cx[,i], y, levels[j])
    bvs_c[ct,4] <- sd_outcome_var_level(cx[,i], y, levels[j])
    bvs_c[ct,5] <- percentile_outcome_var_level(cx[,i], y, levels[j], 0)
    bvs_c[ct,6] <- percentile_outcome_var_level(cx[,i], y, levels[j], 0.01)
    bvs_c[ct,7] <- percentile_outcome_var_level(cx[,i], y, levels[j], 0.05)
    bvs_c[ct,8] <- percentile_outcome_var_level(cx[,i], y, levels[j], 0.1)
    bvs_c[ct,9] <- percentile_outcome_var_level(cx[,i], y, levels[j], 0.25)
    bvs_c[ct,10] <- percentile_outcome_var_level(cx[,i], y, levels[j], 0.5)
    bvs_c[ct,11] <- percentile_outcome_var_level(cx[,i], y, levels[j], 0.75)
    bvs_c[ct,12] <- percentile_outcome_var_level(cx[,i], y, levels[j], 0.90)
    bvs_c[ct,13] <- percentile_outcome_var_level(cx[,i], y, levels[j], 0.95)
    bvs_c[ct,14] <- percentile_outcome_var_level(cx[,i], y, levels[j], 0.99)
    bvs_c[ct,15] <- percentile_outcome_var_level(cx[,i], y, levels[j], 1)
    ct = ct + 1 
  }
}

write.csv(bvs_c, file = paste0(path_output,"bivar_stats_y_num_x_cat.csv"), row.names = FALSE)
