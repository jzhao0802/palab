# Performance metrics and graphics for the predictions from a binary classifier.

## Purpose
This function will provide metrics and graphics that are relevant for assessing the results of a binary classifier.

## Dependencies
_An additional column will have been generated which is the predicted score of the positive outcome event for each observation_

## Name
`perf_metrics_cat`

## Inputs
* `model_output`
  * an R dataset where the first column is the `patient_id`, the second column is the `outcome_variable` and the third column is the `predicted_scores` from the model.
* `prob_thrsh`
  * The threshold which is applied to the `predicted_scores`
* `roc_curve_flag`
  * This flag indicates whether a receiver operator characteristic (ROC) curve should be saved as a graphic. This can be either "True" or "False".
* `pr_curve_flag`
  * This flag indicates whether a precision-recall (PR) curve should be generated and saved as a graphic. This can be either "True" or "False".


## Function
* Check if `model_output` input has the correct format:
  * Three columns with more than one row
  * The first column should have as many distinct values as there are rows
  * The second column should contain two distinct values
  * Each column should have the same number of rows (no NA entries are permitted)
* Round the `predicted_scores` to three decimal places
* Assess which labels pertain to the positive or negative classifier
  * Find the distinct values for the `outcome_variable` the minimum of these values is  considered to be the label for the negative class (likely to be -1 or 0; refer to this as `lnc`) and the maximum of these values is considered to be the label for the positive class (likely to be +1; refer to this as `lpc`).
* Check if the user has specified `prob_thrsh`.
  * If it has been provided, check that the value provided is numeric and report an error if not.
  * If it has been provided then the default value is 0.5.
* Create an additional column `predicted_cat` in `model_output`
  * This is a binary variable which is set to 1 when the corresponding value in the `predicted_scores` column is greater than or equal to `prob_thrsh` and is set to 0 when the corresponding `predicted_scores` is less than `prob_thrsh`.
* Produce `metrics.csv` where each row is populated with the following metrics:  
 * Calculate the number of true positives (TP; the number of observations correctly labelled as belonging to the positive class) - sum(`outcome_variable` == `lpc` & `predicted_cat`==`lpc`)
 * Calculate the number of false negatives (FN; the number of observations incorrectly labelled as belonging to the negative class) -  sum(`outcome_variable` == `lpc` & `predicted_cat`==`lnc`)
 * Calculate the number of false positives (FP; the number of observations incorrectly labelled as belonging to the positive class) - sum(`outcome_variable` == `lnc` & `predicted_cat`==`lpc`)
 * Calculate the number of true negatives (TN; the number of observations correctly labelled as belonging to the negative class) - sum(`outcome_variable` == `lnc` & `predicted_cat`==`lnc`)
 * Calculate the senstivity (recall) - TP/(TP + FN)
 * Calculate the specificity - TN/(FP + TN)
 * Calculate the precision - TP/(TP+FP)
 * Calculate the accuracy - (TP + TN)/(TP + FN + FP + TN)
 * Calculate the f1-score - 2\*(precision\*recall)/(precision + recall)
* Calculate the area under the receiver operator characteristic curve (AUROC). The ROC curve is creating by ploting the senstivity (recall) against the false positive rate (1 - specificity) across a range of operating thresholds (for e.g. the thresholds could be represented as an order list of the unique values in `predicted_scores`). Refer to pROC package for an example of an implementation. If `roc_curve_flag` is set to 1 then save out a graphic of the curve <ggplot> where the y-axis is labelled as 'Sensitivity (Recall)' and the x-axis is labelled as 'False Positive Rate (1 - Specificity)'. The graph object should be saved in rds format and as an png of size xxx. The file name should be `roc_curve`.  
* Calculate the area under the precision-recall curve (AUPR). The PR curve is creating by plotting the precision against the senstivity (recall) across a range of operating thresholds. In addition to the aupr, the following outputs will also be available:
  * The output of the curve should be postprocessed so that the recall is presented across recall bins defined as ([0,0.05], [0.05, 0.1], ...., [0.95, 1]) the corresponding precision is the maximum precision observed across the entire bin. This should be stored in `pr_curve_recall_bins.csv`.  If `pr_curve_flag` is set to one then produce a graphic of the PR curve and label the x-axis as 'Precision' and the y-axis as 'Recall'. This should be saved in rds format and as an png. The file name should be `pr_curve`.
  * Produce `pr_top_patient_counts.csv` where the columns names are TP and FP.  TP has the following row-values set to  <steps of 10, e.g.>{10, 25, 50, 100, 250, 500, 750, 1000, 1250, 1500, 1750, 2000, 2500, 5000, 10000}. To compute the corresponding row value for FP then suggest the `predicted_scores` to the positive class and sorted it descending order. Select the top x true positives from the sorted positive predicted scores and now count the number of false positives that are greater than the minimum predicted score for the top x true positives. That is, to compute the number of FP when TP is equal to `Npos`  `pos_scores` = sort(`predicted_scores`[`outcome_variable`== 1]); `score_thrsh` = `pos_scores`[`Npos`]; `FP` = sum(((`predicted_scores`[`outcome_variable`== 1])>=`score_thrsh`). If the suggested range for TP is outside the range of the TP is the dataset then the corresponding column for FP should be set to `NA`.

## Output
* `metrics.csv`
* If `roc_curve_flag` is "True", `roc_curve.png/.rds`
* If `pr_curve_flag` is "True", `pr_curve_flag.png/.rds`
* `pr_curve_recall_bins.csv`
* `pr_top_patient_counts.csv`
