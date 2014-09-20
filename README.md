Getting and Cleaning Data Course Project
================

## Combining the Raw Data
The "run_analysis.R" script utilizes the following 6 files from the 
Human Activity Recognition Using Smartphones Data Set. All files are listed relative to the working directory.

	*train\X_train.txt
	*train\y_train.txt
	*train\subject_train.txt
	*test\X_test.txt
	*test\Y_test.txt
	*test\subject_test.txt
	*features.txt
	*activity_labels.txt
	
A subset of the columns was taken.
The new data frame was grouped by subject and activity.
This was summarize_each to obtain the mean for each measurement by group.
Data was written to a text file "summarized_data.txt" using write.table with row.names = FALSE.