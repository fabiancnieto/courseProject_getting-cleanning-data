## Read the file from the path (parameter path2file) 
## Parameters 
##  @path2file --> character value to the complete path file
##  @regexp --> regular expresion to apply for each row
##  @trans --> define if the matrix would be transposed before transform in a data set 
## Result
##  resultObject --> Contains the dataframe with the file information
getWearableData <- function (path2file, type) {
    ##Load custom functions
    source("regExpReadFile.R")
    
    ##Read Activities
    pathtemp <- paste0(path2files,"UCI_HAR_Dataset/","activity_labels.txt")
    activityLabel <- regExpReadFile(pathtemp, regexp = "[[:blank:]]+", trans = TRUE)
    colnames(activityLabel) <- c("code", "activity")
    
    ##Read Subject
    pathtemp <- paste0(path2files,"UCI_HAR_Dataset/",type,"/subject_",type,".txt")
    subject <- regExpReadFile(pathtemp)

    ##Read Activities
    pathtemp <- paste0(path2files,"UCI_HAR_Dataset/",type,"/y_",type,".txt")
    activity <- regExpReadFile(pathtemp)
    activity <- data.frame(activity)
    ##Add ID column to preserve the order of the activities
    activity$id <- seq.int(nrow(activity))
    colnames(activity) <- c("codeactivity", "idactivity")
    activities <- merge(activity, activityLabel, by.x = 1, by.y = 1)
    ##Add the activity description to the activities data frame
    activities <- activities[order(activities$idactivity),]

    ##Read Test Data 
    pathtemp <- paste0(path2files,"UCI_HAR_Dataset/",type,"/X_",type,".txt")
    data <- regExpReadFile(pathtemp, regexp = "[[:blank:]]+", trans = TRUE)
    data <- tbl_df(data)
    ##Join Subject & Activity columns
    data$subject <- subject
    data$activityCode <- activities$codeactivity
    data$activity <- activities$activity
    data
}