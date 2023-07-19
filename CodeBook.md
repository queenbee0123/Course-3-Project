# Code Book for the Project

## Dataset Source

The source data for this project comes from the Human Activity Recognition Using Smartphones Data Set. You can find a comprehensive description of the data at the following link: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). To access the project data, please use this URL: [Project Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## R Script Overview

The `run_analysis.R` script performs data preparation and follows five required steps as outlined in the course project's definition.

1. **Downloading the Dataset**

2. **Assigning Data to Variables**
   - `features`: Contains the selected features obtained from accelerometer and gyroscope signals (tAcc-XYZ and tGyro-XYZ).
   - `activities`: Includes a list of activities performed during measurements, along with their corresponding codes (labels).
   - `subject_test`: Contains the test data of 9 out of 30 volunteer test subjects being observed.
   - `x_test`: Contains the recorded features test data.
   - `y_test`: Contains the test data of activities' code labels.
   - `subject_train`: Contains the train data of 21 out of 30 volunteer subjects being observed.
   - `x_train`: Contains the recorded features train data.
   - `y_train`: Contains the train data of activities' code labels.

3. **Merging the Training and Test Sets**
   - `X`: Created by merging `x_train` and `x_test` using the `rbind()` function.
   - `Y`: Created by merging `y_train` and `y_test` using the `rbind()` function.
   - `Subject`: Created by merging `subject_train` and `subject_test` using the `rbind()` function.
   - `Merged_Data`: Created by merging `Subject`, `Y`, and `X` using the `cbind()` function.

4. **Extracting Mean and Standard Deviation Measurements**
   - `TidyData`: Created by subsetting `Merged_Data`, selecting columns "subject," "code," and the measurements related to mean and standard deviation (std) for each measurement.

5. **Using Descriptive Activity Names**
   - Numeric values in the `code` column of `TidyData` are replaced with descriptive activity names taken from the second column of the `activities` variable.

6. **Labeling the Data Set with Descriptive Variable Names**
   - The `code` column in `TidyData` is renamed as `activities`.
   - The text "Acc" in column names is replaced with "Accelerometer."
   - The text "Gyro" in column names is replaced with "Gyroscope."
   - The text "BodyBody" in column names is replaced with "Body."
   - The text "Mag" in column names is replaced with "Magnitude."
   - Column names starting with "f" are replaced with "Frequency."
   - Column names starting with "t" are replaced with "Time."

7. **Creating a Second Independent Tidy Data Set**
   - `FinalData`: Created by summarizing `TidyData` and calculating the means of each variable for each activity and subject after grouping by subject and activity.
   - The resulting `FinalData` is exported to a file named "FinalTinyData.txt".
