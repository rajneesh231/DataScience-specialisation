# Getting and Cleaning Data Project
Author: Rajneesh Bansal 

Data Zip File Location: [UC Irvine Repo](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "Clicking will download the data")

## Goal of this Project
The purpose of the project is to showcase your proficiency in collecting, processing, and cleaning a dataset. The primary objective is to prepare a tidy dataset that can be used for further analysis. A tidy dataset is one that is easy to manipulate, model, and visualize, and has a specific structure: each variable is a column, each observation is a row, and each type of observational unit is a table.

## Methodology
This script is used to process and clean the "Human Activity Recognition Using Smartphones" dataset. Here's a step-by-step explanation of what it does:

1. **Download and Load Data**: The script first downloads a zipped data file from a given URL and saves it as `dat.zip`. It then loads the necessary libraries, `reshape2` and `data.table`.

2. **Read Activity Labels and Features**: It reads the `activity_labels.txt` and `features.txt` files, storing the data in `activityLabels` and `features` data frames, respectively.

3. **Extract Mean and Standard Deviation Measurements**: The script identifies the indices of the columns that contain the mean and standard deviation measurements. It then extracts the names of these columns and removes the parentheses from the names.

4. **Read and Combine Training Data**: The script reads the training data files (`X_train.txt`, `Y_train.txt`, and `subject_train.txt`) and combines them into a single data frame called `train`.

5. **Read and Combine Test Data**: Similarly, it reads the test data files (`X_test.txt`, `Y_test.txt`, and `subject_test.txt`) and combines them into a single data frame called `test`.

6. **Combine Training and Test Data**: The `train` and `test` data frames are then combined into a single data frame called `combined`.

7. **Replace Activity Codes with Descriptive Activity Names**: The script replaces the activity codes in the `Activity` column with descriptive activity names.

8. **Convert `SubjectNum` Column to a Factor**: The `SubjectNum` column is converted to a factor.

9. **Reshape Data and Calculate Mean**: The data is reshaped into a tidy format and the mean of each variable for each activity and each subject is calculated.

10. **Write Tidy Data to a File**: Finally, the tidy data set is written to a file called `tidyData.txt` in the current working directory.

In summary, this script is a comprehensive guide to cleaning and processing the "Human Activity Recognition Using Smartphones" dataset. It ensures that the final output is a tidy dataset that can be used for further analysis.
