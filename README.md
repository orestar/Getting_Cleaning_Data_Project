# Getting_Cleaning_Data_Project
Getting_Cleaning_Data_Project

Programming Assignments of Coursera.com "Getting and Cleaning Data" course

This file describes how the run_analysis.R script works.

1/ Unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2/ Make sure the folder "UCI HAR Dataset" and the run_analysis.R script are both in the current working directory.

3/ Use source("run_analysis.R") command in RStudio.

4/ You will find an output file generated in the current working directory:
"average_data.txt" (220 Kb): it contains a data frame called "data_avg" with" 180*68 dimension.

Use data <- read.table("average_data.txt") command in RStudio to read the file.

The data set gives us to consider 6 activities and 30 subjects.
As we are required to get the average of each variable for each activity and each subject, we end up with 180 rows for all combinations for each of the 66 features.
