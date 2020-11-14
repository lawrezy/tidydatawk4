# tidydatawk4
# Peer-Graded-Assignment-Getting-and-Cleaning-Data-Course-Project
My Submission for the Coursera Data Science Specialization week 4 project 
# Introduction
My submission for Peer Graded Assignment: Getting and Cleaning Data Course Project.

## Source of data
Data for this project was obtained from the course website and it represented data collected from the accelerometers of Samsung Galaxy S smartphones. The link to the 
Data for the project is:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

## Analysis File Description
The run_analysis.R can be run from your working directory to the UCI HAR Dataset folder. plyr package was required to run this script.

Analysis will read all the test data and train data merge them into one data set. Each variables were names accordingly based on the features listed in the features.txt file.

Using the combined data set, independent tidy data set with the average of each variable for each activity and each subject was created and written into tidydataset.txt file.
Enjoy!
