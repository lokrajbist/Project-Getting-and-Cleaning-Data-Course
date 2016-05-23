library(reshape2)

#filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
#if (!file.exists(filename)){
##  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
 # download.file(fileURL, filename, method="curl")
#}#  
#if (!file.exists("UCI HAR Dataset")) { 
#  unzip(filename) 
#}

# Load activity labels + features
activity_labels_by_lokraj <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_labels_by_lokraj[,2] <- as.character(activity_labels_by_lokraj[,2])
featuresTOClean <- read.table("UCI HAR Dataset/features.txt")
featuresTOClean[,2] <- as.character(featuresTOClean[,2])

# Extract only the data on mean and standard deviation
featuresWantedInData <- grep(".*mean.*|.*std.*", featuresTOClean[,2])
featuresWantedInData.names <- featuresTOClean[featuresWantedInData,2]
featuresWantedInData.names = gsub('-mean', 'Mean', featuresWantedInData.names)
featuresWantedInData.names = gsub('-std', 'Std', featuresWantedInData.names)
featuresWantedInData.names <- gsub('[-()]', '', featuresWantedInData.names)


# Load the datasets
trainingSets <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWantedInData]
trainActivitiesSets <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjectsSets <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainingSets <- cbind(trainSubjectsSets, trainActivitiesSets, trainingSets)

testData <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWantedInData]
testActivitiesSets <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjectsSets <- read.table("UCI HAR Dataset/test/subject_test.txt")
testData <- cbind(testSubjectsSets, testActivitiesSets, testData)

# merge datasets and add labels
allDataSets <- rbind(trainingSets, testData)
colnames(allDataSets) <- c("subject", "activity", featuresWantedInData.names)

# turn activities & subjects into factors
allDataSets$activity <- factor(allDataSets$activity, levels = activity_labels_by_lokraj[,1], labels = activity_labels_by_lokraj[,2])
allDataSets$subject <- as.factor(allDataSets$subject)

allDataSets.melted <- melt(allDataSets, id = c("subject", "activity"))
allDataSets.mean <- dcast(allDataSets.melted, subject + activity ~ variable, mean)

write.table(allDataSets.mean, "tidy.txt", row.names = FALSE, quote = FALSE)