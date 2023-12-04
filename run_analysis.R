##Download the Dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="Samsung.zip")

##Unzip the dataset to R working directory
unzip("Samsung.zip")

##Load datasets to R
features <- read.table("UCI HAR Dataset/features.txt", col.names=c("","feature_code"))
activities <- read.table("UCI HAR dataset/activity_labels.txt",header=FALSE,col.names=c("class_label", "activity"))
subject_train <- read.table("UCI HAR dataset/train/subject_train.txt", header=FALSE, col.names="subject_id")
x_train <- read.table("UCI HAR dataset/train/X_train.txt", header=FALSE, col.names=features$feature_code)
y_train <- read.table("UCI HAR dataset/train/y_train.txt",header=FALSE, col.names="label")
subject_test <- read.table("UCI HAR dataset/test/subject_test.txt", header=FALSE, col.names="subject_id")
x_test <- read.table("UCI HAR dataset/test/X_test.txt", header=FALSE, col.names=features$feature_code)
y_test <- read.table("UCI HAR dataset/test/y_test.txt",header=FALSE, col.names="label")

##Step 1: Merges the training and the test sets to create one data set.
mergedSubject <- rbind(subject_train, subject_test)
mergedx <- rbind(x_train,x_test)
mergedy <- rbind(y_train,y_test)
merged_data <- cbind(mergedSubject, mergedy, mergedx)

##Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
library(dplyr)
extractedHAR <- merged_data %>% select(subject_id,label,contains(c("mean","std")))

##Step 3: Uses descriptive activity names to name the activities in the data set
extractedHAR$label <- activities[extractedHAR$label,2]

##Step 4: Appropriately labels the data set with descriptive variable names. 
names(extractedHAR) <- gsub("label","activity",names(extractedHAR))
names(extractedHAR) <- gsub("mean()","mean",names(extractedHAR))
names(extractedHAR) <- gsub("std()","standard deviation",names(extractedHAR))
names(extractedHAR) <- gsub("BodyAcc","body acceleration",names(extractedHAR))
names(extractedHAR) <- gsub("GravityAcc","gravity acceleration",names(extractedHAR))
names(extractedHAR) <- gsub("BodyGyro","body gyroscope",names(extractedHAR))
names(extractedHAR) <- gsub("Jerk"," jerk signal",names(extractedHAR))
names(extractedHAR) <- gsub("Mag"," magnitude",names(extractedHAR))
names(extractedHAR) <- gsub("gravityMean"," gravity mean",names(extractedHAR))
names(extractedHAR) <- gsub("Bodybody","body",names(extractedHAR))
names(extractedHAR) <- gsub("^t","time ",names(extractedHAR))
names(extractedHAR) <- gsub("^f","frequency ",names(extractedHAR))
##check all variable names have been labeled appropriately
names(extractedHAR)

##Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
groupeddata<- extractedHAR %>%
        group_by(subject_id, activity)
tidydata <- groupeddata %>%
        summarise_all(.funs=mean)
write.table(tidydata,file="final tidy data.txt", sep="\t", row.name=FALSE)
