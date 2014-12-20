#file name: run_analysis.R
##Purpose: This is a R script which processes the Smartphones Data set - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
##Arthor: Wilson Lau

#read source data from text files
trainx <- read.table("./UCI/train/X_train.txt", header=F,sep="") #sensor data
trainy <- read.table("./UCI/train/Y_train.txt", header=F,sep="") #corresponding activity data related to sensor data
trains <- read.table("./UCI/train/subject_train.txt", header=F,sep="") #user identifier from who sensor data is collected
testx <- read.table("./UCI/test/X_test.txt", header=F,sep="") #sensor data
testy <- read.table("./UCI/test/Y_test.txt", header=F,sep="") #corresponding activity data related to sensor data
tests <- read.table("./UCI/test/subject_test.txt", header=F,sep="") #user identifier from who sensor data is collected
flabels <- read.table("./UCI/features.txt", header=F,sep="") #feature labels
alabels <- read.table("./UCI/activity_labels.txt", header=F,sep="") #activity labels


#1. Merges the training and the test sets to create one data set.
##merge sensor data, activity and subject into one data frame
train <- cbind(trainx,trainy,trains)
test <- cbind(testx,testy,tests)
##Merges the training and the test sets to create one data set
data <- rbind(train,test)

#4. Add original dataset column labels to the data frame
featurelabels <- as.character(flabels[,2])  #assign sensor data feature's labels
columnlabels <- c(featurelabels,"activity","subjectId") #aggregate activity and subjectid to feature labels
colnames(data) <- columnlabels #assign column names to data frame

#2. Extracts only the measurements on the mean and standard deviation for each measurement
colindex <- c(grep("activity",colnames(data)),grep("subjectId",colnames(data)),grep("mean",colnames(data)),grep("std",colnames(data)))
extractedData <- data[,colindex]
colnames(extractedData) <- make.names(colnames(extractedData))

#3. Uses descriptive activity names to name the activities in the data set
activity <- extractedData$activity #extract activity column from extracted dataset
for (i in seq(dim(alabels)[1])) {
  matchindex <- activity == alabels[i,1]
  activity[matchindex] <- as.character(alabels[i,2])
}
extractedData$activity <- activity

#5. create tidy data group by activity, subject and both
##tidy dataset showing the average group by activity label
tidyDataActivity <- aggregate(extractedData,by = list(activitylabel = extractedData$activity),FUN=mean)
tidyDataActivity$activity <- NULL  #remove duplicated column
tidyDataActivity$subjectId <- NULL #remove duplicated column

##tidy dataset showing the average group by subject
tidyDataSubject <- aggregate(extractedData,by = list(subject = extractedData$subjectId),FUN=mean)
tidyDataSubject$activity <- NULL  #remove duplicated column
tidyDataSubject$subjectId <- NULL #remove duplicated column

##tidy dataset showing the average group by activity activity and then subject
tidyDataActivitySubject <- aggregate(extractedData,by = list(activitylabel = extractedData$activity,subject = extractedData$subjectId),FUN=mean)
tidyDataActivitySubject$activity <- NULL  #remove duplicated column
tidyDataActivitySubject$subjectId <- NULL #remove duplicated column

#write tidy dataset to disk
tidyDataActivity <- format(tidyDataActivity, width = 15, justify = "left")
tidyDataSubject <- format(tidyDataSubject, width = 15, justify = "left")
tidyDataActivitySubject <- format(tidyDataActivitySubject, width = 15, justify = "left")
write.table(tidyDataActivity, file="tidyDataActivity.txt",quote = FALSE,row.names = FALSE)
write.table(tidyDataSubject, file="tidyDataSubject.txt",quote = FALSE,row.names = FALSE)
write.table(tidyDataActivitySubject, file="tidyDataActivitySubject.txt",quote = FALSE,row.names = FALSE)

