# Model aggregation

## Purpose
The purpose of this function is to aggrgate the output of multiple models.

## Name
`model_aggregation`

## Internal Dependencies
None

## Parameters
* `models`
  * Name of R data frame containing the predictions of multiple models.
  * Each model will have 1 column in this dataset, and the column will contain the predicted probability of class 1 (P(Class1)).
* `key`
  * Name of the column containing the key, e.g. patient_id
  * All other columns in the data frame are presumed to be model predicitons.
* `predict.thresh`
  * The threshold above which to classify a prediction as in the positve class.
  * This value must be between 0 and 1.
* `perf.thresh`
  * The performance threshold above which a model has to perform to be included in the aggregation.
  * This value must be between 0 and 1.
* `corr.thresh`
  * The correlation threshold above which model pairs are not considered for aggregation.
  * This value must be between 0 and 1.

## Function
* An overview of this function is:
  1. Find out how well each model is performing - model performance will be calculated using area under the PR curve.
  2. Find out how independant the models are - calcuated using correlation.
  3. Aggregate those which have a decent performance and are not heavily correlated.  
* Produce a data frame called `model_stats` with the following columns:
  * _Model1_: Name of first model in model pair (taken from column headings of `models` data frame)
  * _Model2_: Name of second model in model pair
    * Note that each model should appear in the _Model1_ column once, and in the _Model2_ column once. This will mean duplication of some information in the data frame, but it will ensure that if either column is filtered by a particular model, all information will be displayed, rather than having to look for that model in other other column too.  
  * _Spearman's correlation coefficient_: Spearman's correlation coefficient between the P(Class1) for _Model1_ and P(Class1) for _Model2_. The result should be rounded to two decimal places.
    * p-value is not needed here as all models will have the same number of observations.
  * _Class 1 Consensus_: The percentage of _Model1_'s Class 1 prediction that _Model2_'s class prediction agrees with.
    * This should make use of the `predict.thresh` parameter to transform the P(Class1) for each model into a prediciton for class 1.
    * Example: Let us say that _Model1_ predicts 20k out of 100k observations as positve. Of those 20k, _Model2_ predicts 15k as positive. This column should then read 75%.
    * This column is realtive to _Model1_ only.
  * _Model1 PR AUC_: Area under the PR curve for Model 1.
  * _Model2 PR AUC_: Area under the PR curve for Model 2.
* Select model pairs which meet the following criteria:
  * Model performance of both models in the pair is above `perf.thresh`
  * Correlation between both models is below `corr.thresh`
  * Add a column to the data frame `model_stats` called _aggregate_.
    * This should be 1 if the model pair passes the above tests and 0 is the model pair does not.
    * The purpose of this column is to let the user know which models have been aggregated amongst the ones in `models`
* Create a new data frame called `aggregated` containing the aggregated output of the models in a pair that has been selected for aggregation. It should have the following columns:
  * `key` column from `model`
  * _agg.prob.mean_: the mean prediction of P(Class1) across each of the selected models.
  * _agg.prob.median_: the median prediction of P(Class1) across each of the selected models.
  * _agg.prob.max_: the maximum prediction of P(Class1) across each of the selected models.
  * _agg.prob.min_: the minimum prediction of P(Class1) across each of the selected models.
  * _agg.vote_: the total number of "votes" across each of the selected models.
    * This is calculated by first using `predict.thresh` to transform the P(Class1) for each model into a prediciton for class 1.
    * Then the number of models which predict Class 1 for a particular piece observations are counted.
    * For example, if there are 10 models overall and 6 of them predict Class 1 for a paritucalr observation, the value of this column should be 6 for this observation.

## Return
A list containing the following data frames:
* `model_stats`
* `aggregated`

## Output
There is no output to CSV for this function

## Defaults
```
agg <- model_aggregation(
  models =,
  key =,
  predict.thresh = 0.5,
  perf.thresh = 0.5,
  corr.thresh = 0.9
  )
```

## Example call
```
agg <- model_aggregation(
  models = all_models_1213,
  key = PATIENT_ID,
  perf.thresh = 0.5,
  corr.thresh = 0.75
  )
```
