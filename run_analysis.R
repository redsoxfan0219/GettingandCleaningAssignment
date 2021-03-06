##load libraries

library(dplyr)
library(data.table)

## set working directory
setwd("/Users/benjaminmoran/Desktop/Data Science/")

# initial file load

featureNames <- read.table("features.txt")
activityLabels <- read.table("activity_labels.txt", header = FALSE)
subjectTrain <- read.table("subject_train.txt", header = FALSE)
activityTrain <- read.table("y_train.txt", header = FALSE)
featuresTrain <- read.table("X_train.txt", header = FALSE)
subjectTest <- read.table("subject_test.txt", header = FALSE)
activityTest <- read.table("y_test.txt", header = FALSE)
featuresTest <- read.table("X_test.txt", header = FALSE)

#combining train and test sets

subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

# creating complete data table from separate tables

colnames(features) <- t(featureNames[2])
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completeData <- cbind(features,activity,subject)


#narrow to obtain mean and STD

columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)
requiredColumns <- c(columnsWithMeanSTD, 562, 563)
extractedData <- completeData[,requiredColumns]
extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
        extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}
extractedData$Activity <- as.factor(extractedData$Activity)

## adding descriptive names

names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

## rendering labeled data as a data table

extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

# creating second data table with average of each variable for each activity and subject

tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)

