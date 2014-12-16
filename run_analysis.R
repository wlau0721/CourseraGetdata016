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

#merge sensor data, activity and subject into one data frame
train <- cbind(trainx,trainy,trains)
test <- cbind(testx,testy,tests)

#merge the training and testing datasets
data <- rbind(train,test)

#Extract mean and standard deviation measurements from original datasets

#(optional) convert the activity label variables from numbers into factor strings


#Add correct column names to the extracted dataset
##use make.names function - https://class.coursera.org/getdata-016/forum/thread?thread_id=136









