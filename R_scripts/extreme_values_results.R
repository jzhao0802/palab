#*************paths*****************************************
path_data <- 'F:/orla/PALab_Design/def_master/example_data/'
path_output <- 'F:/orla/PALab_Design/def_master/example_output_csvs/'
path_meta <- 'F:/orla/PALab_Design/def_master/example_metadata_files/'

#************load data***********************************
x <- read.csv(paste0(path_data, 'mtcars.csv'),stringsAsFactors=FALSE, na.strings=c("","NA"))
vtype <- read.csv(paste0(path_meta, 'var_config.csv'))
missing_flag <- 'missing'
x[x == "-99"] <- missing_flag

ex_val_thrsh <- read.csv(paste0(path_meta, 'ex_val_thrsh.csv'),stringsAsFactors=FALSE, na.strings=c("","NA"))
#xx <- x #keep back up of x

#numerical
nv_names <- vtype[vtype$Type == 'n',]
nx <- x[, which(names(x) %in% nv_names$ColumnName)]
#nx$mpg <- NULL

ex_val_thrsh_out <- data.frame(matrix(nrow = ncol(nx), ncol = 1))
colnames(ex_val_thrsh_out) <- colnames(ex_val_thrsh)[1]
ex_val_thrsh_out$Variable <-  colnames(nx)
ex_val_thrsh_out <- merge(x= ex_val_thrsh_out, y = ex_val_thrsh, by = "Variable", all = TRUE)

ex_nx <-nx

for (i in 1:ncol(nx)) {
  vname <- ex_val_thrsh_out[i,1]
  vdata <- nx[[vname]]
  
  if (!is.na(as.numeric(ex_val_thrsh_out[i,2])))  {
    thrsh <- ex_val_thrsh_out[i,2]
    vdata[(vdata>= thrsh)] <- thrsh
    ex_nx[[vname]] <- vdata
  }
  else if (is.na(ex_val_thrsh_out[i,2])) {
    thrsh <- quantile(vdata, 0.99)
    vdata[(vdata>= thrsh)] <- thrsh
    ex_nx[[vname]] <- vdata
    ex_val_thrsh_out[i,2] <- thrsh
  } 
  x[[vname]] <- vdata
}
write.csv(ex_val_thrsh_out, file = paste0(path_output,"ex_val_thrsh_out.csv"), row.names = FALSE)

write.csv(x, file = paste0(path_output,"ex_mtcars.csv"), row.names = FALSE)
