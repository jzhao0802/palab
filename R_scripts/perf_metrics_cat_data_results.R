
#functions
range0_to_1 <- function(x){(x-min(x))/(max(x)-min(x))}


#paths
path_data = 'F:/orla/PALab_Design/def_master/example_data/'
path_output = 'F:/orla/PALab_Design/def_master/example_output_csvs/'


model_output <- data.frame(matrix(nrow = 100, ncol=3))
colnames(model_output) <- c("patient_id", "outcome_var", "pred_scores")

#populate data frame
model_output$pred_scores <- range0_to_1(rnorm(100))
model_output$outcome_var <- c(rep(0,50), rep(1,50))
model_output$patient_id <- as.integer(100000*(rnorm(100) + 100))

write.csv(model_output, file = paste0(path_data,"model_output.csv"), row.names = FALSE)

#create metrics.csv
model_output["pred_cat"] <- 0 
model_output$pred_cat[model_output$pred_scores>=0.5]=1
metrics <- data.frame(matrix(nrow = 11, ncol=2))
colnames(metrics) <- c("metric_name", "value") 

TP <- sum((model_output$outcome_var == 1) & (model_output$pred_cat == 1))
metrics[1,1] <- "TP"
metrics[1,2] <- TP

FN <- sum((model_output$outcome_var == 1) & (model_output$pred_cat == 0))
metrics[2,1] <- "FN"
metrics[2,2] <- FN

FP <- sum((model_output$outcome_var == 0) & (model_output$pred_cat == 1))
metrics[3,1] <- "FP"
metrics[3,2] <- FP

TN <- sum((model_output$outcome_var == 0) & (model_output$pred_cat == 0))
metrics[4,1] <- "TN"
metrics[4,2] <- TN

metrics[5,1] <- "Senstivity (recall)"
metrics[5,2] <-TP/(TP+FN)

metrics[6,1] <- "Specificity"
metrics[6,2] <-TN/(FP+TN)

metrics[7,1] <- "Precision"
metrics[7,2] <-TP/(FP+TP)

metrics[8,1] <- "Accuracy"
metrics[8,2] <-(TN+TP)/(FP+TP+TN+FN)

metrics[9,1] <- "F1-score"
metrics[9,2] <-(2*TP)/(2*TP+FP+FN)

metrics[10,1] <- "auROC"
metrics[10,2] <-roc(model_output$outcome_var, model_output$pred_scores)$auc

library(PRROC)

metrics[11,1] <- "auPR"
metrics[11,2] <- pr.curve(scores.class0 = model_output$pred_scores[1:50], scores.class1 = model_output$pred_scores[51:100])$auc.integral

write.csv(metrics, file = paste0(path_output,"metrics.csv"), row.names = FALSE)

#create tp_vals.csv
tp_vals <- list(5,10,15,50)

#create pr_top_counts.csv
pr_top_counts <- data.frame(matrix(nrow = 4, ncol = 3))
colnames(pr_top_counts) <- c("TP", "FP", "score_thrsh")
pos_scores <- sort(model_output$pred_scores[model_output$outcome_var==1], decreasing =TRUE)

pr_top_counts[1,1] <- tp_vals[1]
thrsh <- pos_scores[as.numeric(tp_vals[1])]
pr_top_counts[1,2] <- sum((model_output$outcome_var == 0) & (model_output$pred_scores >= thrsh))
pr_top_counts[1,3] <- thrsh

pr_top_counts[2,1] <- tp_vals[2]
thrsh <- pos_scores[as.numeric(tp_vals[2])]
pr_top_counts[2,2] <- sum((model_output$outcome_var == 0) & (model_output$pred_scores >= thrsh))
pr_top_counts[2,3] <- thrsh

pr_top_counts[3,1] <- tp_vals[3]
thrsh <- pos_scores[as.numeric(tp_vals[3])]
pr_top_counts[3,2] <- sum((model_output$outcome_var == 0) & (model_output$pred_scores >= thrsh))
pr_top_counts[3,3] <- thrsh


pr_top_counts[4,1] <- tp_vals[4]
thrsh <- pos_scores[as.numeric(tp_vals[4])]
pr_top_counts[4,2] <- sum((model_output$outcome_var == 0) & (model_output$pred_scores >= thrsh))
pr_top_counts[4,3] <- thrsh

write.csv(pr_top_counts, file = paste0(path_output,"pr_top_counts.csv"), row.names = FALSE)

#create pr_curve_bins.csv
pred <- prediction(model_output$pred_scores, model_output$outcome_var);
RP.perf <- performance(pred, "prec", "rec");
ppv <- as.numeric( unlist (RP.perf@y.values))
recall <- as.numeric( unlist (RP.perf@x.values))
recall_bins <- seq(0.05,1,0.05)

ppv_at_recall <- numeric()
for (i in 1:length(recall_bins)){
  min_dist <- min(abs(recall - recall_bins[i]))
  ppv_at_recall[i] <- mean(ppv[(round(abs(recall - recall_bins[i]),3) == round(min_dist,3))])
}

plot(recall_bins, ppv_at_recall); lines(recall_bins, ppv_at_recall)
require(reshape2)
pr_curve_bins <- (data.frame(recall_bins, ppv_at_recall))

write.csv(pr_curve_bins, file = paste0(path_output,"pr_curve_bins.csv"), row.names = FALSE)