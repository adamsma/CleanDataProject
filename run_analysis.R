run_analysis <- function() {
	
	## load helpful libraries
	library(dplyr)
	
	## relevant files
	trainPath = "train\\X_train.txt"
	trainLblPath = "train\\y_train.txt"
	trainSubPath = "train\\subject_train.txt"
	
	testPath = "test\\X_test.txt"
	testLblPath = "test\\y_test.txt"
	testSubPath = "test\\subject_test.txt"
	
	featPath = "features.txt"
	actLblPath = "activity_labels.txt"
	
	## load in relevant files 
	features <- read.table(featPath) [,2]
	actLbl <- read.table(actLblPath)
	
	trainData <- read.table(trainPath)
	trainLbl <- read.table(trainLblPath, col.names = "Activity")
	trainSub <- read.table(trainSubPath, col.names = "Subject_ID")
	
	testData <- read.table(testPath)
	testLbl <- read.table(testLblPath, col.names = "Activity")
	testSub <- read.table(testSubPath, col.names = "Subject_ID")
	
	## rename columns with features names
	colnames(trainData) <- features
	colnames(testData) <- features
	
	## combine all tables with descriptive activities
	cTrainData <- cbind(trainSub, trainLbl, trainData)
	cTestData <- cbind(testSub, testLbl, testData)
	comboData <- rbind(cTrainData, cTestData) %>%
		mutate( Activity = actLbl[Activity, 2])
		
	## create subset of columns for mean and std values
	statSubset <- select(comboData, 1:2, contains("mean()"), contains("std()"), -contains("Mean)"), - contains("Mean,"))
	
	## create new data set with average for variables by activity and subject
	 newData <- tbl_df(statSubset) %>%
		group_by(Subject_ID, Activity) %>%
		summarise_each(funs(mean))
		
	## write table to txt file
	write.table(newData, file = "summarized_data.txt", row.name=FALSE)
	
}