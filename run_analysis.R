
  ## setting up the right working environment
  setwd("C:/Users/paccaudp/Dropbox/coursera/John Hopkins - the data scientist toolbox/Session 3 - Getting and Cleaning data/project/UCI HAR Dataset/UCI HAR Dataset")
  library(stringr)
  library(plyr)
  
  ## loading the data
  featuresList <- read.table("features.txt", colClasses = "character")

  ## stringr1. we merge the trainwe calculate the mean for each column
  testData <- read.table("./test/X_test.txt")
  names(testData) <- featuresList[,2]
  testSubject <- read.table("./test/subject_test.txt")
  names(testSubject) <- "subject"
  testTidyData <- cbind(testSubject,testData)
  
  trainData <- read.table("./train/X_train.txt")
  names(trainData) <- featuresList[,2]  
  trainSubject <- read.table("./train/subject_train.txt")
  names(trainSubject) <- "subject"
  trainTidyData <- cbind(trainSubject,trainData) 
  
  ## merging the test and train data sets
  mergedData <- rbind(testTidyData, trainTidyData)
  
  ## extracting the measurements on the mean and standard deviation
  ## stringr package required
  featuresNames <- names(mergedData)
  filter <- str_detect(featuresNames, "mean()") | str_detect(featuresNames,"std()") | str_detect(featuresNames, "subject")
  mergedDataFiltered <- mergedData[,filter]
  
  ## calculating the mean for each column - consolidated by subject
  ## pplyr package required

  meanPerColumnPerSubject <- ddply(mergedDataFiltered,.(subject),colwise(mean))
  
  ## creating the output files
  write.table(mergedDataFiltered, file = "merged_data_set.txt")
  write.table(meanPerColumnPerSubject, file = "means_per_subject.txt")