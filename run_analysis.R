##Load Packages
library(dplyr)
library(tidyr)
library(reshape2)

##Set Working Directory
path2files <-
    "/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Getting-Cleaning-Data/Week4/CourseProject/"
setwd(path2files)

##Load custom functions
source("regExpReadFile.R")
source("getWearableData.R")

##Read Variable Names
pathtemp <- paste0(path2files, "UCI_HAR_Dataset/", "features.txt")
variableNames <-
    regExpReadFile(pathtemp, regexp = "[[:blank:]]+", trans = TRUE)
variableNames <- variableNames[, 2]
variableNames <- gsub("[(]|[)]", "", variableNames)
variableNames <- gsub("[-](m|s)", "_\\1", variableNames)
variableNames <-
    append(variableNames, c("subject", "activityCode", "activity"))

##Read test data
testData <- getWearableData(path2files, "test")

##Read test data
trainData <- getWearableData(path2files, "train")

##Merges the training and the test sets to create one data set.
totalData <- rbind(testData, trainData)

##Assign names to the columsn
colnames(totalData) <- variableNames

##Extracts only the measurements on the mean and standard deviation for each measurement.
##Only the measurements that start with the letter "t" will be include
##beacuase of just that variables are measurments These time domain signals (prefix 't' to denote time) [features_info.txt]
##Using regular expresion search for variables names with start with the letter "t" and has in the name the word "mean" or "std"
selectCol <-
    names(totalData)[grep("^t.*(mean|std)", names(totalData))]
selectCol <-
    append(selectCol, c("subject", "activityCode", "activity"))
##Subsetting the dataframe in the variable names
totalData <- totalData[, selectCol]
##Add a measurement number ID to identify each measurment
totalData$measurementid <- seq.int(nrow(totalData))

##Gather the columns related to the values of the same measurement
totalData <- totalData %>% gather(measurement_axis, mean_std, 1:40)
##Separate the column measurement from the Axis (X,Y,Z) and value (Mean, Std)
totalData <-
    totalData %>% separate(col = measurement_axis,
                           into = c("measurement", "axis"),
                           sep = "_")
##Separate the column the Axis (X,Y,Z) from value (Mean, Std)
totalData <-
    totalData %>% separate(col = axis,
                           into = c("value", "axis"),
                           sep = "-")
##Spread the value column to get 2 variables mean and std per axis (X,Y,Z) and measurement
totalData <- totalData %>% spread(key = value, value = mean_std)

##Set the apropiate data type for each variable
tidyData <- totalData %>% mutate(
    subject = factor(subject),
    measurement = factor(measurement),
    axis = factor(axis),
    mean = as.numeric(mean),
    std = as.numeric(std)
)

##From the data set in step 4, creates a second, independent tidy data set with the average of each 
##variable for each activity and each subject.
avgTidyData <-
    tidyData %>% group_by(subject, activity, measurement, axis) %>% 
    summarize(avgmean = mean(mean), avgstd = mean(std))