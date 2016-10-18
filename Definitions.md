# Definitions

## Commonly used terms
* Input dataset
  * This is the data that is to be analysed.It is sometimes called the design matrix.
* Observation
  * A row in the input dataset.
  * There is usally one row per patient.
* Attributes
  * A column in the input dataset which is descriptive but no intended as an input to a statistical algorthm. For example, an ID (patient ID, hospitalID) or a date (index date)
* Variable
  * A column in the input dataset which is intended as an input into a statistical algorithm.
  * Also known as predictors, independant variables.
* Categorical variable
  * A variable which has a distinct number of unique values which are not related numericlly, i.e. Gender, Treatment type, Comorbidity.
* Numerical variable  
  * A variable which has values on a continous scale, e.g. Height
* Count variables
  * A variable which is a count of something. The values in these types of variables are always expected to be positve integers. They can sometimes be treated as categorical variables if there is a small range.
* Outcome variable
  * A variable which will will be used to train a supervised model
  * Also known as Response variable, Target variable, Dependant variable

## Concepts
* Index date
  * The date on which the information of interest is taken from.
* Lookback period
  * The period of time over which information is aggregated at the index date.
  * It is the difference between the index date and the date for which we first have information about the patient.
* Follow up period/ Study period
  * The period of time over which the outcome variable is determined.
  * It is the difference between the index date and the date on which the outcome variable is determined.
* Cohort
  * A group of observations, usually patients. The positive cohort is the group that has a postive outcome, e.g. tests positively for a disease. The negative cohort is the group that has a negative outcome, e.g. patients who have not been diagnosed with the disease, and is usually much larger than the positve cohort. It is important to ensure that the positive and negatvie cohorts are matched.
* Matching
  * The process of ensuring that the main variation between postive and negative cohorts comes from the variables rather than the attributes of the patients. Matching process will ensure that the distribution of attributes is similar in both the positve and negative cohorts.
