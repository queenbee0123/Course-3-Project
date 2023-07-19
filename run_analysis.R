# Load necessary packages
library(dplyr)

# Define the URL and file name for the dataset
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip_filename <- "Coursera_Week4_FinalAssignment.zip"
data_folder <- "UCI HAR Dataset"

# Download the dataset if it doesn't exist
if (!file.exists(zip_filename)) {
  download.file(file_url, zip_filename)
}

# Unzip the dataset if the folder doesn't exist
if (!file.exists(data_folder)) { 
  unzip(zip_filename) 
}

# Read the required datasets
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

# Merge the datasets
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

# Extract only the measurements on the mean and standard deviation for each measurement
TidyData <- Merged_Data %>% 
  select(subject, code, contains("mean"), contains("std"))

# Use descriptive activity names to name the activities in the data set
TidyData$code <- activities[TidyData$code, 2]

# Label the data set with descriptive variable names
names(TidyData) <- gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData) <- gsub("Gyro", "Gyroscope", names(TidyData))
# ... (other substitutions for variable names)

# Create a second, independent tidy data set with the average of each variable for each activity and each subject
FinalData <- TidyData %>%
  group_by(subject, code) %>%
  summarise_all(mean)

# Write the final tidy data to a file
write.table(FinalData, "FinalTidyData.txt", row.name = FALSE)
