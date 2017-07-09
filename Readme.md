**Coursera Data Science specialization - Course Getting and Cleaning Data**

**Final Course Project Assignment**

**Readme** ⇒ Describe the assumptions, decisions and strategies used in this project.

**Understanding the Input data:** The data its separated in 2 groups "test" (30% of the total amount) and "train" (70% of the total amount), under this folder structure are located the following files:

1.  **File subject_*.txt:** Contain the identifier of the people that are included in this data group. The dimensions of this data its 2947 rows and 1 column for the "test" group and 7352 rows and 1 column for the "train" group.
2.  **File y_*.txt:** Contain the identifier of the activity that was happening while the samples was taken. The dimensions of this data its 2947 rows and 1 column for the "test" group and 7352 rows and 1 column for the "train" group.
3.  **File X_*.txt:** Contain the different values for the measurements (features) taken per sample. The dimensions of this data its 2947 rows and 561 columns for the "test" group and 7352 rows and 561 columns for the "train" group.

Additional files with data included: 

*   **features.txt:** Contain the names of the columns for the x_*.txt files. The column names that start with the letter "t" refers to a values taken in the original sample and the columns names that start with a different letters are transformations of the original values.
*   **activity_labels.txt:** Contain de identifier code and description of the possible activities

The original merge data is assembled in the following way (**Table 1 Merging strategy**):

| Column #1                  | Column #2            | Columns 3 to 564     |
|----------------------------|----------------------|----------------------|
| subject_test.txt2947 Rows  | y_test.txt2947 Rows  | X_test.txt2947 Rows  |
| subject_train.txt7352 Rows | y_train.txt2947 Rows | X_train.txt2947 Rows |

**Getting and cleaning program:** The program are composed by the following scripts and functions:

1.  **run_analysis.R:** Main script it coordinate the load for the packages and custom functions and do the main data transformations.
2.  **getWearableData.R:** Function responsible for load and merge the data of the given group.
3.  **regExpReadFile.R:** Function responsible for load the given file an split the rows according the regular expression given in the parameter "regexp".

Additional packages: dplyr, tidyr and reshape2

**Process description:**

1.  The process start loading the additional packages, setting the working directory and loading the custom functions (getWearableData and regExpReadFile).
2.  Then assign to the object "variableNames" the content of the features.txt file using the regExpReadFile function, because the name of the columns include the symbols () using regular expresion the script remove those symbols and set the columns names with this pattern: measurment + "_" + mean|std + "-" + X|Y|Z (Ex:. original name: tBodyAcc-mean()-X fixed name: tBodyAcc_mean-X).
3.  Then assign to the objects "testData" and "trainData" using the getWearableData function, the data is merge as its explained in the table "Table 1 Merging strategy". The output data include the code and description of the activities per row. 
4.  Merge the the objects "testData" and "trainData" and store the result in the "totalData" object. Assign the columns names to the "totalData" object. **This is the answer for the first point**.
5.  Using regular expressions get the  columns names related of a measurement on the mean and standard deviation. Only the measurements that start with the letter "t" will be include because the column names that start with the letter "t" refers to a values taken in the original sample and the columns names that start with a different letters are transformations of the original values. **This is the answer for the second point.**
6.  Subset the object "totalData" with the columns found in the last step.
7.  Add a new column "measurementid" to the "totalData" object with a sequence to identify the original samples.
8.  The columns 1 to 40 are a combination of measurement + mean or std + axis (X, Y, Y), because of that the column names are composed of values. With gather function make taller the "totalData" object, the resulting columns are: subject, activity, activity, measurementid, measurement_axis, mean_std.
9.  Using the separate function divide the column measurement_axis in 2 columns (by the symbol "_"), the resulting columns are: subject, activity, activity, measurementid, measurement, axis, mean_std. The column "axis" contain a text like "mean-X", finally separate the column "axis" in 2 columns  (by the symbol "-") the resulting columns are: subject, activity, activity, measurementid, measurement, axis, value.
10.  The column contain the following values "mean" or "std", those are variable and should be independient columns, to do this using the spread created 2 new columns and the value for this columns area the "value" column (Created en the last step).
11.  The last step to get the tidy data is to assign the correct class to each variable.
12.  Variable names assigned: **subject** => Represents the person owner of the measurements, **activitycode** => Represents the activity code that the person was doing while the measurement, **activity** => Represents the activity that the person was doing while the measurement, **measurementid** => Represents the measurement identifier of the taken sample, **measurement** => Represents the kind of measurement taken, **axis** => Represents the axis of measurement taken, **mean** => Represents the mean value of the measurements, **std** => Represents the standard deviation value of the measurements. **This is the answer for the 3 and 4 points**.
13.  Finally group by the "tidyData" object and summarize it. **This is the answer for the 5 point.**

tidyData preview:
![tidyData First 20 Rows Preview](https://github.com/fabiancnieto/courseProject_getting-cleanning-data/tidyData-First-20-rows.png)