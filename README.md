Getting and Cleaning Data Course Project
================

The script "run_analysis.R" starts with the UCI Human Activity Recognition Using Smartphones Data Set and produces a tidy
data set, summarizing the mean of mean and std values in the original data set by test subject and activity performed.

Firs the following 6 files from the UCI data set are read in using read.table(). More information on these files can be found
in the README file inlcude with the original data aset. (All files are listed relative to the working directory.)

	A. features.txt
	B. activity_labels.txt
	C. train\X_train.txt
	D. train\y_train.txt
	E. train\subject_train.txt
	F. test\X_test.txt
	G. test\y_test.txt
	H. test\subject_test.txt

Files D and G are read in using col.names = "Activity".  Files E and H are read in using col.names = "Subject_ID". The column
names for the data frames created from files C and F are set to the values read in from file A. 

The training data and test data are then combined with the test subject id and activity labels into a single data frame. This
combined data frame has 10299 records and 479 variables. The first column is the subject ID. The second column is the activity 
label. The remaining variables are the feature values as described in the original data set's "features.txt" and 
"features_info.txt".

Utilizing select() from the dplyr libary, a new data frame is created from a subset of the combined data frame variables.  The 
subset of variables are the subject ID, the activity label, and any column containing the text "mean()" or "std()", excluding
columns containing "Mean". This exclusions criteria is included to remove values such as "angle(tBodyAccJerkMean)" which is a
function of a mean value and not a mean value itself. The resulting data frame has 10299 records and 81 variables.	

The subset data frame is then converted into a tbl_df and grouped by subject ID and activity. The final tidy data set is 
created by summarizing the groups by mean. The resulting tbl_df has 180 records (6 activities * 30 test subjects = 180) and
81 variables (subject id + activity + 79 mean feature values = 81).   

THe final tidy data set is written to the text file "summarized_data.txt" using write.table with row.names = FALSE.