######################################################################################## 
# Getting & Cleaning data course
# 
# Process the "Human Activity Recognition Using Smartphones" dataset
######################################################################################## 


######################################################################################## 
## Set Working Directory
## setwd("C:/Users/User_name/Desktop/Coursera/3_Getting_Cleaning_Data/data/")
######################################################################################## 

library(plyr)

######################################################################################## 
# Step 1 - Merges training and test sets to create one single data set.
######################################################################################## 

# training data
train_s <- read.table("UCI HAR Dataset//train/subject_train.txt", col.names="subject")
train_x <- read.table("UCI HAR Dataset//train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train//y_train.txt", col.names="activity")

train_data <- cbind(train_x, train_s, train_y)

# test data
test_s <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names="subject")
test_x <- read.table("UCI HAR Dataset//test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test//y_test.txt", col.names="activity")

test_data <- cbind(test_x, test_s, test_y)


# Merge train and test data
data <- rbind(train_data, test_data)

######################################################################################## 
# Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
########################################################################################

# Read features
feature_list <- read.table("UCI HAR Dataset//features.txt", col.names = c("id", "name"))
# Add the last two columns (subject and activity)
features <- c(as.vector(feature_list[, "name"]),"subject", "activity")

# Filter only features that has mean or std in the name
filtered_feature_ids <- grepl("mean|std|subject|activity", features) & !grepl("meanFreq", features)
filtered_data = data[, filtered_feature_ids]

######################################################################################## 
# Step 3 - Uses descriptive activity names to name the activity in the data set
########################################################################################

activity <- read.table("UCI HAR Dataset//activity_labels.txt", col.names=c("id", "name"))

# Lowercase for activity names and Add correct column name
activity <- data.frame(id = activity$id, name = tolower(activity$name))

# Update values with correct activity names
filtered_data$activity <- activity[filtered_data$activity, 2]

######################################################################################## 
# step 4 - Appropriately labels the data set with descriptive variable names.
######################################################################################## 

# Make feature names more understandable
filtered_feature_names <- features[filtered_feature_ids]
filtered_feature_names <- gsub("\\(\\)", "", filtered_feature_names) # Get rid of ()
filtered_feature_names <- gsub("(Jerk|Gyro)", "-\\1", filtered_feature_names) # Add - between Jerk & Gyro
filtered_feature_names <- gsub("Acc", "-Accelerometer", filtered_feature_names) # Accelerometer
filtered_feature_names <- gsub("Gyro", "Gyroscope", filtered_feature_names) # Gyroscope
filtered_feature_names <- gsub("Mag", "-Magnitude", filtered_feature_names) # Magnitude
filtered_feature_names <- gsub("BodyBody", "Body", filtered_feature_names) # Body
filtered_feature_names <- gsub("^t(.*)$", "\\1-Time", filtered_feature_names) # Add Time at the end
filtered_feature_names <- gsub("^f(.*)$", "\\1-Frequency", filtered_feature_names) # Add frequency at the end
filtered_feature_names <- gsub("std", "Standard", filtered_feature_names) # Standard
filtered_feature_names <- tolower(filtered_feature_names) # Column names in lower case 

# Assign new names to features
names(filtered_data) <- filtered_feature_names

# Reorder to get Subject and activity first
filtered_data <- filtered_data[c(67,68,1:66)]

## Save & Write out the 1st dataset with the name "filtered_data.txt"
write.table(filtered_data, "filtered_data.txt")

######################################################################################## 
# step 5 - From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
######################################################################################## 

data_avg <- ddply(filtered_data, .(subject, activity), function(x) colMeans(x[, 3:68]))

######################################################################################## 
## Save & Write out the 2nd dataset with the name "averages_data.txt"
write.table(data_avg, file="averages_data.txt") 
######################################################################################## 
