# Performance metrics and graphics for the predictions from a binary classifier.

## Purpose
This function will provide metrics and graphics that are relevant for assessing the results of a binary classifier.

## Internal Dependencies
_An additional column will have been generated which is the predicted score of the positive outcome event for each observation_

## Name
`perf_metrics_cat`

## Parameters
* `model_output`
  * an R dataset where the first column is the `patient_id`, the second column is the `outcome_variable` and the third column is the `predicted_scores` from the model.
* `prob_thrsh`
  * The threshold which is applied to the `predicted_scores`
* `tp_vals`
    * A list of values defined by the user that represent the numbers of true positives for which the
  corresponding false positive count and predicted score threshold should be computed.
* `roc_curve_flag`
  * This flag indicates whether a receiver operator characteristic (ROC) curve should be saved as a graphic. This can be either "TRUE" or "FALSE". The default value is FALSE.
* `pr_curve_flag`
  * This flag indicates whether a precision-recall (PR) curve should be generated and saved as a graphic. This can be either "TRUE" or "FALSE". The default value is FALSE.


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
 * Calculate the sensitivity (recall) - TP/(TP + FN)
 * Calculate the specificity - TN/(FP + TN)
 * Calculate the precision - TP/(TP + FP)
 * Calculate the accuracy - (TP + TN)/(TP + FN + FP + TN)
 * Calculate the F1-score - 2TP/(2TP + FP + FN)
* Calculate the area under the receiver operator characteristic curve (AUROC). The ROC curve is creating by plotting the sensitivity (recall) against the false positive rate (1 - specificity) across a range of operating thresholds (for e.g. the thresholds could be represented as an ordered list of the unique values in `predicted_scores`). This could be achieved using the pROC package. If `roc_curve_flag` is set to "True" then save out a graphic of the curve created using ggplot where the y-axis is labelled as 'Sensitivity (Recall)' and the x-axis is labelled as 'False Positive Rate (1 - Specificity)'. The graph object should be saved in rds format and as an png of size <xxx>. The file name should be `roc_curve`.  
* Calculate the area under the precision-recall curve (AUPR). The PR curve is creating by plotting the precision against the sensitivity (recall) across a range of operating thresholds. In addition to the aupr, the following outputs will also be available:
  * The output of the curve should be post-processed so that the recall is presented across recall bins defined as ([0,0.05], [0.05, 0.1], ...., [0.95, 1]) and the precision is reported at the upper bound of the bin, i.e. for the bin [0, 0.05] the corresponding precision is reported at 0.05 recall; to compute the precision at a given level of recall value look for the closest available recall value and use this as the corresponding precision (note that there is no interpolation involved); if two recall values are equidistant to the 0.05 level then average the closest corresponding precision values. For e.g., given the following recall and precision pairs [{0.04, 0.25}, {0.04, 0.22}, {0.06, 0.18}, {0.06, 0.17}],  the corresponding recall at 0.05 is the average of all the precision values (i.e. mean(0.25,0.22,0.18,0.17)); given the following recall and precision pairs [{0.08,0.25}, {0.10, 0.24}, {0.10, 0.23}, {0.12, 0.25}], the corresponding value at 0.10 is the average of 0.24 and 0.23. This should be stored in `pr_curve_bins.csv` where the first column is the recall in the defined bins and corresponding post-processed precision scores.  If `pr_curve_flag` is set to "True" then produce a graphic of the post-processed PR curve using ggplot and label the x-axis as 'Precision' and the y-axis as 'Recall'. This should be saved in rds format and as an png. The file name should be `pr_curve`.
* If `tp_vals` has been provided by user:
  * Check that `tp_vals` contains a list of numerical values.
  * Check that the maximum value in this list is less than or equal to the total number of positive observations in `outcome_variable`, i.e. sum(`outcome_variable`== `lpc`).
  * If `tp_vals` has been provided then produce `pr_top_counts.csv` where the columns names are `TP`, `FP` and `score_thrsh`. To calculate the first row of `pr_top_counts.csv`, populate the first column as `tp_vals[1]`. Next, subset the `predicted_scores` to the positive class and sort it in descending order. Select the top number of true positives (value stored in `tp_vals[1]`) from the sorted positive predicted scores and now count the number of false positives that are greater than the minimum predicted score for the top number of true positives; this is the entry of the second column. That is, to compute the number of FP when TP is equal to `tp_vals[1]` then `pos_scores` = sort(`predicted_scores`[`outcome_variable`== 1]); `ps_thrsh` = `pos_scores`[`tp_vals[1]`]; `FP` = sum(((`predicted_scores`[`outcome_variable`== 0])>=`os_thrsh`). `ps_thrsh` should be stored in the third column. This process should be repeated for all entries in `tp_vals`.

## Output
* `metrics.csv`
* If `roc_curve_flag` is "True", `roc_curve.png/.rds`
* If `pr_curve_flag` is "True", `pr_curve_flag.png/.rds`
* `pr_curve_bins.csv`
* `pr_top_counts.csv`

## Defaults
```
perf_metrics_cat(
  model_output = ,
  prob_thrsh = 0.5,
  tp_vals = ,
  roc_curve_flag = 'FALSE',
  pr_curve_flag = 'FALSE'
  )
```  
## Tests
* All outputs should have the correct format and structure as specified.
* Using the provided toy example provided [here](/example_data/model_output.csv) for  model_output.csv - all outputs produced should exactly match the provided examples results: [metrics.csv](/example_output_csvs/metrics.csv), [pr_curve_bins.csv](/example_output_csvs/pr_curve_bins.csv) and [pr_top_counts.csv](/example_output_csvs/pr_top_counts.csv) with `prob_thrsh` set to 0.5 and `tp_vals` contains the following values (5,10,15,50). 
