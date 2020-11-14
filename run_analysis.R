library(plyr)
##Downloading file
if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "./data/Dataset.zip", method = "curl")
unzip(zipfile="./data/Dataset.zip",exdir="./data")
path <- file.path("./data" , "UCI HAR Dataset")
DS<-list.files(path, recursive=TRUE)


##Activity files
ActivityTest  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)
ActivityTrain <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)

##subject files
SubjectTrain <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
SubjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)

##Features files
FeaturesTest  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
FeaturesTrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)

##Merge both training and test datasets into one
Subject <- rbind(SubjectTrain, SubjectTest)
Activity<- rbind(ActivityTrain, ActivityTest)
Features<- rbind(FeaturesTrain, FeaturesTest)

## Renaming variable names
names(Subject)<-c("subject")
names(Activity)<- c("activity")
FeaturesNames <- read.table(file.path(path, "features.txt"),head=FALSE)
names(Features)<- FeaturesNames$V2

##Merging columns to get the data frame Total
dataMerge <- cbind(Subject, Activity)
Total <- cbind(Features, dataMerge)

##Select only the measurements on the mean and standard deviation for each measurement
subsetFeaturesNames<-FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]

##Subset the data frame Total by seleted names of Features
selectedNames<-c(as.character(subsetFeaturesNames), "subject", "activity" )
Ftotal<-subset(Total,select=selectedNames)

##Use descriptive activity names to name the activities in the data set
Activitylabel <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)

##Appropriately label the data set with descriptive variable names
names(Ftotal)<-gsub("^t", "time", names(Ftotal))
names(Ftotal)<-gsub("^f", "frequency", names(Ftotal))
names(Ftotal)<-gsub("Acc", "Accelerometer", names(Ftotal))
names(Ftotal)<-gsub("Gyro", "Gyroscope", names(Ftotal))
names(Ftotal)<-gsub("Mag", "Magnitude", names(Ftotal))
names(Ftotal)<-gsub("BodyBody", "Body", names(Ftotal))

## create a second, independent tidy data set
Tdata<-aggregate(. ~subject + activity, Ftotal, mean)
Tdata<-Tdata[order(Tdata$subject,Tdata$activity),]
write.table(Tdata, file = "tidydata.txt",row.name=FALSE)

