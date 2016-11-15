#Create paired sequence variables.

## Purpose
This function will create an exhaustive set of paired sequence variables and return the set of variables that occur with a user-defined freuqency.

## Internal Dependencies
`read_transform`

## Name
`seq_vars`

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
