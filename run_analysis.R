# Merges the training and the test sets to create one data set.
library(reshape2)

run_analysis <- function() {
#Load Data
#Common Data
featuresLabels <- read.table("./data/UCI HAR Dataset/features.txt", colClasses="character")
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", colClasses="character")
names(activityLabels) <- c("Activity", "Activity_Desc")

#Test Data
testData <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
colnames(testData) <- featuresLabels[,2]
testSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
names(testSubject) <- "Subject"
testActivity <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
names(testActivity) <- "Activity"
test.all <- cbind(testActivity, testSubject, testData)

#Train Data
trainData <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
colnames(trainData) <- featuresLabels[,2]
trainSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
names(trainSubject) <- "Subject"
trainActivity <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
names(trainActivity) <- "Activity"
train.all <- cbind(trainActivity, trainSubject, trainData)

#1.Combined Data
all <- rbind(test.all, train.all)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#All column with mean and Standard Deviation in a new data frame, all.mean_std
all.mean_std <- all[,grep("Activity|Subject|(-mean|-std)\\(", names(all))]

#3.Uses descriptive activity names to name the activities in the data set
#Join the combined dataset to activity dataset, to get activity description

all.merged <- merge(activityLabels, all.mean_std, by.x="Activity", by="Activity",all=TRUE)

#4.Appropriately labels the data set with descriptive variable names. 
#All variables retain their names as data is merged in original dataset was named earlier
names(all.merged)

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data_melt <- melt(all.merged, id=c("Activity", "Activity_Desc", "Subject"))
mean_data <- dcast(data_melt, Activity+Activity_Desc+Subject ~variable, mean)

## Create a file with the new tidy dataset
write.table(mean_data,"./tidy_data.txt", row.name=FALSE)

}