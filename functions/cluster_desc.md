# Cluster descriptions

## Purpose
This function will describe the characteristics of clusters. It assumes that clustering has already been run and the input dataset contains the cluster ID for each observation.

## Internal Dependencies
NONE

## Name
`cluster_desc`

## Parameters
* `clustered`
  * R data frame containing the clustered data.
  * There should be one column containing the cluster ID. All other columns are considered to be predictors.
* `clusterID`
  * Name of the column which contains the cluster ID.
* `pvalue_thresh`
  * The p-value threshold. Default is 0.2.
* `multi_corr_method`
  * Method of correction of multiple-testing. Possible values: "FDR_BH", "FDR_BY", "Bonferroni". Default="FDR", these methods were described in correlation.md.
* `num_predictors`
  * The number of predictors to keep in the dataset. Default is NULL, which keeps all predictors.  
* `outcome_var`
  * The name of the outcome variable. It must a numerical column with no characters. It must be converted to a numerical value even if it is a factor in `clustered`.
* `prefix`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.

## Function
* The user is expected to have performed some clustering before running this function such that each observation is assigned a cluster ID.

* Produce a table called `cluster_info`, with one row per cluster, and the following columns:
  * _ClusterID_: The ID of the cluster, taken from the `clusterID` column in `clustered`
  * _NumObs_: Number of observations in this cluster
  * _PropObs_: Number of observations in this cluster, divided by total number of observations in `clustered` (3 decimal places)
  * _MeanOutcome_: Mean value of `outcome_var` in this cluster (3 decimal places)

* Produce a table called `cluster_desc`.
  * The aim of this table is to describe each cluster by listing the predictors which are most different in that cluster, compared to other clusters.
  * For each cluster:
    * For each column in `clustered`(including the `outcome_var` and excluding `clusterID`):
      * Perform a Kolmogorov–Smirnov test (K-S test) comparing these 2 sets of observations for this column:
        1. Observations where `clusterID` is the current cluster
        2. Observations where `clusterID` is NOT the current cluster.
      * There will be a _statistic_ and a _p-value_ returned from the K-S test.
    * Only keep the columns for which the K-S test p-value is below `pvalue_thresh` after correcting for multiple-testing with method `multi_corr_method`.
    * After sorting by descending _statistic_, only keep the top `num_predictors`. If `num_predictors` is NULL, then keep all predictors.
  * The final table should have the following columns:
    * _ClusterID_: ID of the cluster
    * _Variable_: Name of predictor
    * _KS Statistic_: The _statistic_ calculated for this predictor and this cluster (3 decimal places)
    * _KS p-value_: The _p-value_ calculated for this predictor and this cluster (5 decimal places)
    * _KS p-value corrected_: The corrected _p-value_ for this predictor and this cluster (5 decimal places)
    * _MeanInCluster_: Mean value of the predictor for observations in this cluster (3 decimal places)
    * _MeanNotInClsuter_: Mean value of the predictor for observations NOT in this cluster (3 decimal places)
  * There will be one row per cluster-predictor.

  * The user may use the two tables together as follows:
    * From `cluster_info`, find a cluster which has a high proportion of observations in the positive class. For a binary outcome variable which has values 0 and 1, this would manifest as a value close to 1 in _MeanOutcome_.
    * Filter the table `cluster_desc` to show just rows where _ClusterID_ equals the cluster found above.
    * Look at the predictors that are listed to understand what is different about this cluster. For example, if "Age" is listed with a high statistic and low p-value, it means that the ages of people in this cluster are very different from other clusters. This should also be clear from the "Mean" columns, i.e. _MeanInCluster_ should be very different from _MeanInCluster_ for Age.

## Return
A list containing the following data frames:
* `cluster_desc`
* `cluster_info`

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* `prefix`cluster_desc.csv
* `prefix`cluster_info.csv

## Defaults
```
cluster_desc(
  clustered =,
  clusterID="clusterID",
  pvalue_thresh=0.2,
  num_predictors=,
  outcome_var=,
  prefix='',
  output_dir =,
  )  
```
## Example call
```
output_dir <- "D:/data/cars1/"

m <- cluster_desc(
  clustered = clustered_cars_dataset,
  clusterID="clusterID",
  pvalue_thresh=0.1,
  num_predictors=10,
  outcome_var="gear",
  prefix="cars",
  output_dir = output_dir,
  )  
```
