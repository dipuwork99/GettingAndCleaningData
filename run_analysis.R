filename <- "Coursera_GettingAndCleaningData.zip"
extractDir <- "UCI HAR Dataset"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  


if (!file.exists(extractDir)) { 
  unzip(filename) 
}

file_path <- file.path("UCI HAR Dataset")
files<-list.files(file_path, recursive=TRUE)
print(files)

featuresFile = file.path(extractDir , "features.txt")
activityLableFile =  file.path(extractDir , "activity_labels.txt")
subjectTestDataFile = file.path(extractDir , "test" ,"subject_test.txt")
x_testDataFile = file.path(extractDir , "test" ,"X_test.txt")
y_testDataFile = file.path(extractDir , "test" ,"Y_test.txt")
x_trainDataFile = file.path(extractDir , "train" ,"X_train.txt")
y_trainDatFile = file.path(extractDir , "train" ,"Y_train.txt")
subjectTrainDataFile = file.path(extractDir , "train" ,"subject_train.txt")

features <- read.table(featuresFile, col.names = c("id","functions") )
activities <- read.table(activityLableFile, col.names = c("id", "activity"))

subject_testData <- read.table(subjectTestDataFile, col.names = "subject" )
x_testData <- read.table(x_testDataFile )
y_testData <- read.table(y_testDataFile, col.names = "code" , header = FALSE)
subject_train <- read.table(subjectTrainDataFile , col.names = "subject" , header = FALSE)
x_trainData <- read.table(x_trainDataFile)
y_trainData <- read.table(y_trainDatFile, col.names = "code" , header = FALSE)




x_data_merged <- rbind(x_trainData, x_testData)

names(x_data_merged) <- features$functions
  
y_data_merged <- rbind(y_trainData, y_testData)
subject_data_merged <- rbind(subject_train, subject_testData)

Merged_Data_Set <- cbind(subject_data_merged, y_data_merged, x_data_merged)


Merged_Data_Set$code <- activities[Merged_Data_Set$code, 2]

Merged_Data_Set <-  Merged_Data_Set %>% select(subject, code, contains("-mean()"), contains("-std()"))

names(Merged_Data_Set)<-gsub("code", "activity", names(Merged_Data_Set))
names(Merged_Data_Set)<-gsub("Acc", "Accelerometer", names(Merged_Data_Set))
names(Merged_Data_Set)<-gsub("Gyro", "Gyroscope", names(Merged_Data_Set))
names(Merged_Data_Set)<-gsub("BodyBody", "Body", names(Merged_Data_Set))
names(Merged_Data_Set)<-gsub("Mag", "Magnitude", names(Merged_Data_Set))
names(Merged_Data_Set)<-gsub("^t", "Time", names(Merged_Data_Set))
names(Merged_Data_Set)<-gsub("^f", "Frequency", names(Merged_Data_Set))
names(Merged_Data_Set)<-gsub("tBody", "TimeBody", names(Merged_Data_Set))
names(Merged_Data_Set)<-gsub("-mean\\(\\)", "Mean", names(Merged_Data_Set), ignore.case = TRUE)
names(Merged_Data_Set)<-gsub("-std\\(\\)", "STD", names(Merged_Data_Set), ignore.case = TRUE)
names(Merged_Data_Set)<-gsub("-freq\\(\\)", "Frequency", names(Merged_Data_Set), ignore.case = TRUE)
names(Merged_Data_Set)<-gsub("angle", "Angle", names(Merged_Data_Set))
names(Merged_Data_Set)<-gsub("gravity", "Gravity", names(Merged_Data_Set))
names(Merged_Data_Set)<-gsub("-", "", names(Merged_Data_Set))


# 
FinalData <- Merged_Data_Set %>%  group_by(subject, activity) %>%  summarise_all(mean)
write.table(FinalData, "TidyData.txt", row.name=FALSE, quote = FALSE)
