#Create paired sequence variables.

## Purpose
This function will create an exhaustive set of paired sequence variables and return the set of variables that occur with a user-defined freuqency.

## Internal Dependencies
`read_and_transform`

## Name
`seq_vars`

## Parameters
* `event_dates`
  * Dataset where each column is a variable and each row is an observation.
  * The outcome variable is represented as a binary variable.
  * For all other variables the nonmissing entries should be in date format.
* `missing_values`
  * A comma delimited string of missing values for all columns.
  * e.g. "-999, 0, -99"
* `freq_thrsh`
  * A user-defined value between 0 and 1 the defines how frequency a pair of events need to be so that it will output as a sequence variable.
  * The default value is 1%




## Function
* Compute the frequency of each event variable in `event_dates`, i.e. the number of date entries divided by the total number of observations (inc missing values).
* Subset the list of event variables to that that occur with a frequency of at least `freq_thrsh`
* Assess which labels pertain to the positive or negative classifier
  * Find the distinct values for the `outcome_variable` the minimum of these values is  considered to be the label for the negative class (likely to be -1 or 0; refer to this as `lnc`) and the maximum of these values is considered to be the label for the positive class (likely to be +1; refer to this as `lpc`).
* From the subsetted list create `seq_var_descriptives.csv`. The rows in this file are the list of unique un-ordered pairs, i.e. for N events; this file would have N(N-1)/2 rows. The output should contain the following column for each unique pair of events:
  * _A_: The variable name of the first event in the pair.
  * _B_: The varialbe name of the second event in the pair.
  * _A and B_: count of the number observations where both events (named in columns A and B) occur, i.e. a valid date entry exists for both events.   
  * _Proportion A and B (total obs)_: Count stored in _A and B_ divided by the total number of observations in the data set.
  * _A and B pos_: count of the number observations where both events (named in columns A and B) occur and the outcome variable is equal to `lpc`
  * _Proportion A and B pos_: count stored in  _A and B pos_ divided by the count stored in  _A and B_
  * _A and B neg_: count of the number observations where both events (named in columns A and B) occur and the outcome variable is equal to `lnc`
  * _Proportion A and B neg_: count stored in  _A and B neg_ divided by the count stored in  _A and B_
  * _A before B_: count of the number observations where the event named in _A_ occurs before the event named in _B_.  
  * _Proportion A before B_: Count stored in _A before B_ divided by the count stored in _A and B_
  * _A before B pos_: count of the number observations where the event named in _A_ occurs before the event named in _B_ and the outcome variable is equal to `lpc`
  * _Proportion A before B pos_: count stored in  _A before B pos_ divided by the count stored in  _A before B_
  * _A before B neg_: count of the number observations where the event named in _A_ occurs before the event named in _B_ and the outcome variable is equal to `lnc`
  * _Proportion A before B neg_: count stored in  _A before B neg_ divided by the count stored in  _A before B_
