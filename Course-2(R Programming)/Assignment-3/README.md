### Introduction
The Hospital_Revised_Flatfiles contains a lot of imformation about other datasets and we will only look at a small subset for this
assignment. The data files for this assignment are
- outcome-of-care-measures.csv: Contains information about 30-day mortality and readmission rates
for heart attacks, heart failure, and pneumonia for over 4,000 hospitals.
- hospital-data.csv: Contains information about each hospital.


A description of the variables in each of the files is in the included PDF file named Hospital_Revised_Flatfiles.pdf.

This document contains information about many other files that are not included with this programming
assignment. You will want to focus on the variables for Number 19 ("Outcome of Care Measures.csv") and
Number 11 ("Hospital Data.csv"). In particular, the numbers of
the variables for each table indicate column indices in each table (i.e. "Hospital Name" is column 2 in the
outcome-of-care-measures.csv file).

### 1 Plot the 30-day mortality rates for heart attack
Read the outcome data into R via the read.csv function and look at the first few rows.

    > outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    > head(outcome)
    
There are many columns in this dataset. You can see how many by typing ncol(outcome) (you can see
the number of rows with the nrow function). In addition, you can see the names of each column by typing
names(outcome) (the names are also in the PDF document.
To make a simple histogram of the 30-day death rates from heart attack (column 11 in the outcome dataset),
run

    > outcome[, 11] <- as.numeric(outcome[, 11])
    > ## You may get a warning about NAs being introduced; that is okay
    > hist(outcome[, 11])
    
![histogram](https://github.com/rajneesh231/R-programming_assignments/blob/main/Assignment-3/Rplot.png)

Because we originally read the data in as character (by specifying colClasses = "character" we need to
coerce the column to be numeric. You may get a warning about NAs being introduced but that is okay.

### 2 Finding the best hospital in a state

Write a function called best that take two arguments: the 2-character abbreviated name of a state and an
outcome name. The function reads the outcome-of-care-measures.csv file and returns a character vector
with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome
in that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
be one of "heart attack", "heart failure", or "pneumonia". Hospitals that do not have data on a particular
outcome should be excluded from the set of hospitals when deciding the rankings.

__Handling ties__

If there is a tie for the best hospital for a given outcome, then the hospital names should
be sorted in alphabetical order and the first hospital in that set should be chosen (i.e. if hospitals "b", "c", and "f" are tied for best, then hospital "b" should be returned).

The function should use the following template.

    best <- function(state, outcome) {
              ## Read outcome data
              ## Check that state and outcome are valid
              ## Return hospital name in that state with lowest 30-day death
              ## rate
    }

The function should check the validity of its arguments. If an invalid state value is passed to best, the
function should throw an error via the stop function with the exact message "invalid state". If an invalid
outcome value is passed to best, the function should throw an error via the stop function with the exact
message "invalid outcome".

### 3 Ranking hospitals by outcome in a state

Write a function called rankhospital that takes three arguments: the 2-character abbreviated name of a
state (state), an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).
The function reads the outcome-of-care-measures.csv file and returns a character vector with the name
of the hospital that has the ranking specified by the num argument. For example, the call

rankhospital("MD", "heart failure", 5)

would return a character vector containing the name of the hospital with the 5th lowest 30-day death rate
for heart failure. The num argument can take values "best", "worst", or an integer indicating the ranking
(smaller numbers are better). If the number given by num is larger than the number of hospitals in that
state, then the function should return NA. Hospitals that do not have data on a particular outcome should
be excluded from the set of hospitals when deciding the rankings.

__Handling ties__

It may occur that multiple hospitals have the same 30-day mortality rate for a given cause
of death. In those cases ties should be broken by using the hospital name.

The function should use the following template.

    rankhospital <- function(state, outcome, num = "best") {
            ## Read outcome data
            ## Check that state and outcome are valid
            ## Return hospital name in that state with the given rank
            ## 30-day death rate
    }

The function should check the validity of its arguments. If an invalid state value is passed to rankhospital,
the function should throw an error via the stop function with the exact message "invalid state". If an invalid
outcome value is passed to rankhospital, the function should throw an error via the stop function with
the exact message "invalid outcome".

### 4 Ranking hospitals in all states
Write a function called rankall that takes two arguments: an outcome name (outcome) and a hospital rank-
ing (num). The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame
containing the hospital in each state that has the ranking specified in num. For example the function call
rankall("heart attack", "best") would return a data frame containing the names of the hospitals that
are the best in their respective states for 30-day heart attack death rates. The function should return a value
for every state (some may be NA). The first column in the data frame is named hospital, which contains
the hospital name, and the second column is named state, which contains the 2-character abbreviation for
the state name. Hospitals that do not have data on a particular outcome should be excluded from the set of
hospitals when deciding the rankings.

__Handling ties__
The rankall function should handle ties in the 30-day mortality rates in the same way
that the rankhospital function handles ties.

The function should use the following template.

      rankall <- function(outcome, num = "best") {
          ## Read outcome data
          ## Check that state and outcome are valid
          ## For each state, find the hospital of the given rank
          ## Return a data frame with the hospital names and the
          ## (abbreviated) state name
      }

The function should check the validity of its arguments. If an invalid outcome value is passed to rankall,
the function should throw an error via the stop function with the exact message "invalid outcome". The num
variable can take values "best", "worst", or an integer indicating the ranking (smaller numbers are better).
If the number given by num is larger than the number of hospitals in that state, then the function should
return NA.
