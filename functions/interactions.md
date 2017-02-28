# Data driven interaction terms

## Purpose
The purpose of this function is to exhaustively search for pairwise interaction terms.
The table of interaction terms produced by the function will be inspected by the user and used as inspriration to create new variables that will go into the model.
For this function, reduced running time is a priority.

## Name
`interactions`

## Internal Dependencies
`read_transform`

## Parameters
* `input`
  * R data frame output by `read_transform`
* `var_config`
  * Full path and name of the CSV containing the variable configuration.
  * Example file is [here](../example_metadata_files/var_config.csv)
* `sample_size`
  * The number of observations in the sample of `input` for analysis.
  * If this parameter is NULL, then the entirity of  `input` should be used.
* `outcome_var`
  * The variable to use as the outcome. This variable must only have two values, 1 or 0.
* `max_quantiles`
  * The number of quantiles that a numerical variable should be dichotomised into.
* `min_triggers`
  * The minumum number of observations that an interaction term must have.
* `min_prophits`
  * The minimum proportion of hits that an interaction term ust have.
* `prefix`
  * Name of the output file(s). This might need to be postfixed with function specific names, see Output section.
* `output_dir`
  * The directory into which all outputs will be written to.

## Function
* If `sample_size` is not NULL, then `sample_size` observations should be drawn randomly from `input` and all further analysis should be carried out on this sample.
* Make a list of _rules_:
  * For categorical variables, a rule is just the variable equal to any of its levels, or missing.
    * The variable Gender may have 3 rules; "Gender: F", "Gender: M", "Gender: missing". The rules are derived from the data.
  * Numerical variables must be dichotomised to become rules.
    * Each numerical variable must be split into `max_quantiles` bins if possible, and another for missing values.
    * If `max_quantiles` is the default of 3, the variable Age which is continuous from 18 to 99 may have 4 rules; "Age: 18 - 27", "Age: 28 - 40", "Age: 41 - 99", "Age: Missing".
    * If the variable can not be split into `max_quantiles`, it should be split into just 3 rules; Above 0, Zero and below, missing, e.g. "Age: Above 0", "Age: Zero or below", "Age: Missing"
    * The names of the rules are important for interpretability. When a numerical variable is split into quantiles, the lower and upper bounds should be displayed in the rule name.
    * This dichotimisation is just intended as a "first draft". Having run this function once, the user might manually dichotomise a numerical variable and set it to be a categorical variable for the next iteration of running this function.
* Produce a table of interactions which contains a row per rule-pair-combination (i.e. interaction term), with the following columns:
  * _Rule1_: Name and level of first rule in the rule-pair. E.g. "Age: 18 to 25"
  * _Rule2_: Name and level of second rule in the rule-pair. E.g. "Gender: F"
  * _Variable 1_: Name of the variable in _Rule1_
  * _Variable 2_: Name of the variable in _Rule2_
  * _Variable Level 1_: Level of the variable in _Rule1_
  * _Variable Level 2_: Level of the variable in _Rule2_
  * _AND or OR_: Whether the results are for an OR condition between _Rule1_ and _Rule2_, or whether it is an AND condition.
  * _Triggers_: Number of observations in sample where this combination of _Rule1_ and _Rule2_ is true   
  * _Triggers Prop_: Number of observations in sample where this combination of _Rule1_ and _Rule2_ is true   
  * _Class 1 Triggers_: Number of observations in sample where this combination of _Rule1_ and _Rule2_ is true and `outcome_var` equals 1.
  * _Class 0 Triggers_: Number of observations in sample where this combination of _Rule1_ and _Rule2_ is true and `outcome_var` equals 0.
  * _Prop Class 1 Triggers_: _Class 1 Triggers_ / Number of observations in `input` where `outcome_var` = 1
  * _Prop Class 0 Triggers_: _Class 0 Triggers_ / Number of observations in `input` where `outcome_var` = 0
  * _PropHits_: _Class 1 Triggers_ / _Triggers_
    * The table should be sorted by descending _PropHits_.
* Every rule-pair-combination must be in the table once as an AND condition, and once for an OR condition. To ensure this table is not too large, a rule-pair should ONLY be present if:
  * _Triggers_ is greater than `min_triggers`. If a rule itself does not have the minimum required number of triggers, then every pair containing that rule will of course not be in the data frame.
  * _PropHits_ is greater than`min_prophits`.

## Return
A data frame with the table of interactions.

## Output
All CSVs below should be output to the `output_dir`, overwriting a previous version if necessary.
* `prefix`bivar_stats_y_flag.csv

## Defaults
```
interactions <- interactions(
  input = ,
  var_config = ,
  sample_size = ,
  outcome_var = ,
  max_quantiles = 3,
  min_triggers = 100,
  min_prophits = 0.2,
  prefix='',
  output_dir=
  )
```

## Example call
```
interactions <- interactions(
  input = r$data,
  var_config=var_config,
  sample_size = 100000,
  outcome_var = gear,
  min_triggers = 1000,
  min_prophits = 0.5,
  prefix="interactions",
  output_dir="D:/data//"
  )
```
