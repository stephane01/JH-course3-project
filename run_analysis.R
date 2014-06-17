## 1. setting up the right working environment (note: we use the stringr and plyr packages)
setwd("C:/Users/paccaudp/Dropbox/coursera/John Hopkins - the data scientist toolbox/Session 3 - Getting and Cleaning data/project/UCI HAR Dataset/UCI HAR Dataset")
library(stringr)
library(plyr)

## 2. loading the data
featuresList <- read.table("features.txt", colClasses = "character")
testData <- read.table("./test/X_test.txt")
testSubject <- read.table("./test/subject_test.txt")
trainData <- read.table("./train/X_train.txt")
trainSubject <- read.table("./train/subject_train.txt")

## 3. adding the names and a column with the subject
names(testData) <- featuresList[,2]  
names(testSubject) <- "subject"
testTidyData <- cbind(testSubject,testData)  

names(trainData) <- featuresList[,2]  
names(trainSubject) <- "subject"
trainTidyData <- cbind(trainSubject,trainData) 

## 4. merging the test and train data sets
mergedData <- rbind(testTidyData, trainTidyData)

## 5. extracting the measurements on the mean and standard deviation
featuresNames <- names(mergedData)
filter <- str_detect(featuresNames, "mean()") | str_detect(featuresNames,"std()") | str_detect(featuresNames, "subject")
mergedDataFiltered <- mergedData[,filter]

## 6. calculating the mean for each column - consolidated by subject
meanPerColumnPerSubject <- ddply(mergedDataFiltered,.(subject),colwise(mean))

## 7. creating the output files
write.table(mergedDataFiltered, file = "merged_data_set.txt")
write.table(meanPerColumnPerSubject, file = "means_per_subject.txt")