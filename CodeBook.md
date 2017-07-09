**Coursera Data Science specialization - Course Getting and Cleaning Data**

**Final Course Project Assignment**

**Codebook** ⇒ This codebook describe the final [tidy data](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html "Tidy Data description") result.

Original data source: The input data for this Course project come from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/index.php "UCI Machine Learning Repository"), the data set using in this project is **[Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones "Human Activity Recognition Using Smartphones Data Set").**

**Input Data set summary:** The experiment has been with a group of 30 people recording data through an smarthphone while they were doing they normal activities.

**Output Data set summary:** Data structure that pretend provide an standard data set following the 3 tidy data principles without affecting the original values.

**Data Dictionary**

**Object name: **tidyData

| Variable Position | Variable Name  | Variable Description                                                          | R ClassType | AllowedValues                                                                                                                               |
|------------------|---------------|------------------------------------------------------------------------------|-------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| 1                | subject       | Represents the person owner of the measurements                              | Numeric     | Number from 1 to 30                                                                                                                         |
| 2                | activitycode  | Represents the activity code that the person was doing while the measurement | Numeric     | Number from 1 to 6                                                                                                                          |
| 3                | activity      | Represents the activity that the person was doing while the measurement      | Character   | WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING                                                                    |
| 4                | measurementid | Represents the measurement identifier of the taken sample                    | Numeric     | Autonumeric value                                                                                                                           |
| 5                | measurement   | Represents the kind of measurement taken                                     | Character   | tBodyAcc, tBodyAccJerk, tBodyAccJerkMag, tBodyAccMag, tBodyGyro, tBodyGyroJerk, tBodyGyroJerkMag, tBodyGyroMag, tGravityAcc, tGravityAccMag |
| 6                | axis          | Represents the axis of measurement taken                                     | Character   | X, Y, Z                                                                                                                                     |
| 7                | mean          | Represents the mean value of the measurements                                | Numeric     |                                                                                                                                             |
| 8                | std           | Represents the standard deviation value of the measurements                  | Numeric     |                                                                                                                                             |