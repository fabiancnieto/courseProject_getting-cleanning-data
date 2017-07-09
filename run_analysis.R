##Load Packages
library(dplyr)
library(tidyr)
library(reshape2)

##Set Working Directory
path2files <-"/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Getting-Cleaning-Data/Week4/CourseProject/"
setwd(path2files)

##Load custom functions
source("regExpReadFile.R")
source("getWearableData.R")

##Read Variable Names
pathtemp <- paste0(path2files,"UCI_HAR_Dataset/","features.txt")
variableNames <- regExpReadFile(pathtemp, regexp = "[[:blank:]]+", trans = TRUE)
variableNames <- variableNames[,2]
variableNames <- gsub("[(]|[)]", "", variableNames)
variableNames <- gsub("[-](m|s)","_\\1", variableNames)
variableNames <- append(variableNames, c("subject", "activityCode", "activity"))

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
selectCol <- names(totalData)[grep("^t.*(mean|std)",names(totalData))]
selectCol <- append(selectCol, c("subject", "activityCode", "activity"))
##Subsetting the dataframe in the variable names
totalData <- totalData[,selectCol]

totalData2 <-totalData %>% gather(measurement_axis, mean_std,1:40)

totalData2 <- totalData2 %>% separate(col = measurement_axis, into = c("measurement", "axis"), sep="_") 
totalData2 <- totalData2 %>% separate(col = axis, into = c("value", "axis"), sep="-")
totalData2 %>% dcast(axis ~ value)


grep("[-](mean|std)","tBodyAcc-mean-X")

