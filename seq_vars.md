# Create paired sequence variables.

## Purpose
This function will create a set of paired sequence variables. User-defined thresholds will be used to first filter the number of potential pairs based on how frequent the individual variables are and second, in the case of binary outcome variables, the sequence variables will need to have a minimum difference in frequency across classes (i.e. the levels of the outcome variable). These criteria are introduced to reduce the number of potential sequential variables to those that are likely to be the most relevant so that the user can review these with a clinical team. Note that if data passed to this function include the outcome variable then this data can no longer be considering as independent test data in later modelling stages. The user should take responsibility for this step and no checks are enforced.

For this function reduced running time is a priority so please consider when considering the effort esitmate.

## Internal Dependencies
`read_transform`

## Name
`seq_vars`

## Parameters
* `event_dates`
  * Dataset where each column is a variable and each row is an observation.
  * The outcome variable is represented as a binary variable.
  * For all other variables the nonmissing entries should be in date format (ISO8601, see https://cran.r-project.org/web/packages/readr/vignettes/column-types.html)/
* `outcome`
    * The variable to use as an outcome.
* `missing_values`
  * A comma delimited string of missing values for all columns.
  * e.g. "-999, 0, -99"
  * The default value is NA.
* `freq_thrsh`
  * A user-defined value between 0 and 1 that defines how frequent a pair of events need to be so that it will output as a sequence variable.
  * The default value is 1%
* `xfreq_thrsh`
    * This input is only used for cases when the outcome variable is binary. A user-defined value between 0 and 1 the defines the minimum required difference in the class-specific frequency of a sequence varible, e.g. if the frequency of a variable is 10% for level 1 and 25% for level two then the difference is 15%.
    * The default value is 5%  

## Function
* Compute the frequency of each event variable in `event_dates`, i.e. the number of date entries divided by the total number of observations (inc missing values).
* Subset the list of event variables to those that occur with a frequency of at least `freq_thrsh`
* From the subsetted list create `seq_var_descriptives.csv`. The rows in this file are the list of unique un-ordered pairs, i.e. for N subsetted events; this file would have N(N-1)/2 rows. The output should contain the following column for each unique pair of events:
  * _A_: The variable name of the first event in the pair.
  * _B_: The varialbe name of the second event in the pair.
  * _A and B_: count of the number observations where both events (named in columns A and B) occur regardless of order, i.e. a valid date entry exists for both events.   
  * _Proportion A and B (total obs)_: Count stored in _A and B_ divided by the total number of observations in the data set (i.e. the total number of observations is _A and B_ + _Missing A and B_).
  * _Missing A and B_: the count of number of observations for which both A and B are not present.

  * _A before B_: count of the number observations where the event named in _A_ occurs before the event named in _B_.  
  * _Proportion A before B_: _A before B_ divided by _A and B_

  * _B before A_: count of the number observations where the event named in _B_ occurs before the event named in _A_.  
  * _Proportion B before A_: _B before A_ divided by _A and B_

  * _A equal B_: count of the number observations where the event named in _A_ occurs on the same date as the event named in _B_.  
  * _Proportion A equal B_: _A equal B_ divided by _A and B_

* If the outcome variable is binary then the following columns should be created for both levels of the outcome variable:
  * _A and B Level__X_: count of the number observations where both events (named in columns A and B) occur and the outcome variable is equal to _Level__X_
  * _A and B Proportion Level__X_: _A and B Level__X_ divided by the total number of observations (including missing values) for _Level_X_
  * _Missing A and B Level_X_: the count of number of observations for which both A and B are not present and the outcome variable is _Level__X_.
  * _Delta A and B_: the absolute value of the difference between _A and B Proportion Level__1_ and _A and B Proportion Level__2_

  * _A before B Level__X_: count of the number observations where the event named in _A_ occurs before the event named in _B_ and the outcome variable is _Level__X_.
  * _A before B Proportion Level__X_: count of the number observations where the event named in _A_ occurs before the event named in _B_ and the outcome variable is equal to _Level__X_ divided by the total number of observations (including missing values) for _Level_X_
  * _Delta A before B_: the absolute value of the difference between _A before B Proportion Level__1_ and _A before B Proportion Level__2_
  * _B before A Level__X_: count of the number observations where the event named in _B_ occurs before the event named in _A_ and the outcome variable is _Level__X_.
  * _B before A Proportion Level__X_: count of the number observations where the event named in _B_ occurs before the event named in _A_ and the outcome variable is equal to _Level__X_ divided by the total number of observations (including missing values) for _Level_X_
  * _Delta B before A_: the absolute value of the difference between _B before A Proportion Level__1_ and _A before B Proportion Level__2_
  * _A equal B Level__X_: count of the number observations where the event named in _A_ occurs on the same date as the event named in _B_ and the outcome variable is _Level__X_.
  * _A equal B Proportion Level__X_: count of the number observations where the event named in _A_ occurs on the same date as the event named in _B_ and the outcome variable is _Level__X_ divided by the total number of observations (including missing values) for _Level_X_
  * _Delta A equal B_: the absolute value of the difference between _A equal B Proportion Level__1_ and _A equal B Proportion Level__2_
* Having created all relevant columns the rows should be filtered using the following criteria:
  * _Proportion A and B (total obs)_ should be greater than `freq_thrsh`. Note that it may be more efficient to create this column in isolation first and then only create the other metrics for the rows that will be selected by this criteria.
* If the outcome variable is binary then apply the following additional criteria:
  *  _Delta A and B_ should be greater than `xfreq_thrsh`.

## Output
* `seq_var_descriptives.csv`

## Defaults
```
seq_vars(
  event_dates = ,
  outcome = ,
  missing_values = NA,
  freq_thrsh = 0.01,
  xfreq_thrsh = 0.05
  )
```  
