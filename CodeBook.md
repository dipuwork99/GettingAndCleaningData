
# Introduction

The R script  run_analysis.R is used to prepare tidy data from a zip file that contains data obtained as part of various subjects wearing a smartphone and performing various activites.

This documents the various steps involved in creating the tidy data from the raw data. The script provides the ability to recreate the tidy data from the raw data repeatedly. 

There are no manual steps required to create the tidy data from the raw data.

## The key steps performed by the R script are.

* Download the data contained in a zip file from a given web link.
* Extract the data in the zip file to the local file system.
* The extracted data is then found in a folder called UCI HAR Dataset.
* The extracted data is assigned to variables.
* The different datasets are merged to create a consolidated data set.
* The column names are made descriptive.
* A tidy data set is created by grouping the variables based on subject and activity

## The Following section details the r_analysis R script.


**Data Assigmnment to variables happens as follows in the R script**

Assign each data to variables

|Variable | Data File | Data dimension | 
|-------- | --------- | -------------  |
|features    | features.txt    | 561 rows, 2 columns       |
|activities    | activity_labels.txt    | 6 rows, 2 columns       |
|subject_testData    | test/subject_test.txt   | 2947 rows, 1 column      |
|x_testData    | test/X_test.txt    | 2947 rows, 561 columns        |
|y_testData  | test/y_test.txt   |  2947 rows, 1 columns        |
|subject_train   | test/subject_train.txt     | 7352 rows, 1 column        |
|x_trainData   | test/X_train.txt   |  7352 rows, 561 columns        |
|y_trainData | test/y_train.txt  |  7352 rows, 1 columns         |



```
Merges the training and the test sets to create one data set

y_data_merged (10299 rows, 1 column) is created by merging y_trainData and y_testData using rbind() function
Subject (10299 rows, 1 column) is created by merging subject_train and subject_testData using rbind() function

x_data_merged (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function

The column names of X are set up as defined in the features file.

Merged_Data_Set (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

```

```
The Merged Data set is then updated with the values corrensponding to the activities by looking it up from the activities variable.


Next from the merged data  set only the subject , code and columns for mean and standard deviation are selected 

Merged_Data_Set is updated to (10299 rows, 68 columns) 

```

The variable names for the columns are then renamed as per the following logic so that the column names are descriptive of their purpose.

* The columne code is  renamed to activity 
* Acc  replaced by Accelerometer
* Gyro  replaced by Gyroscope
* BodyBody replaced by Body
* Mag  replaced by Magnitude
* start with character f  replaced by Frequency
* start with character t replaced by  Time
* All start with character t  replaced by  Time
* -mean replaced by Mean
* -std() replaced by STD
* -freq()  replaced by Frequency
* angle replaced by Angle
* gravity replaced by Gravity
* "-"" is Removed 

```
Next a Tidy data set is created by getting the mean of the variables grouped by subject and activity 

FinalData (180 rows, 68 columns)

Export FinalData into TidyData.txt file.

```

The TidyData contains the following variables and their description does not change from the raw dataset. 
The variables howerver after subject and activity are all means grouped by subject and activity when the tidy data set was created.

* subject
* activity
* TimeBodyAccelerometerMeanX
* TimeBodyAccelerometerMeanY
* TimeBodyAccelerometerMeanZ
* TimeGravityAccelerometerMeanX
* TimeGravityAccelerometerMeanY
* TimeGravityAccelerometerMeanZ
* TimeBodyAccelerometerJerkMeanX
* TimeBodyAccelerometerJerkMeanY
* TimeBodyAccelerometerJerkMeanZ
* TimeBodyGyroscopeMeanX
* TimeBodyGyroscopeMeanY
* TimeBodyGyroscopeMeanZ
* TimeBodyGyroscopeJerkMeanX
* TimeBodyGyroscopeJerkMeanY
* TimeBodyGyroscopeJerkMeanZ
* TimeBodyAccelerometerMagnitudeMean
* TimeGravityAccelerometerMagnitudeMean
* TimeBodyAccelerometerJerkMagnitudeMean
* TimeBodyGyroscopeMagnitudeMean
* TimeBodyGyroscopeJerkMagnitudeMean
* FrequencyBodyAccelerometerMeanY
* FrequencyBodyAccelerometerMeanZ
* FrequencyBodyAccelerometerJerkMeanX
* FrequencyBodyAccelerometerJerkMeanY
* FrequencyBodyAccelerometerJerkMeanZ
* FrequencyBodyGyroscopeMeanX
* FrequencyBodyGyroscopeMeanY
* FrequencyBodyGyroscopeMeanZ
* FrequencyBodyAccelerometerMagnitudeMean
* FrequencyBodyAccelerometerJerkMagnitudeMean
* FrequencyBodyGyroscopeMagnitudeMean
* FrequencyBodyGyroscopeJerkMagnitudeMean
* TimeBodyAccelerometerSTDX
* TimeBodyAccelerometerSTDY
* TimeBodyAccelerometerSTDZ
* TimeGravityAccelerometerSTDX
* TimeGravityAccelerometerSTDY
* TimeGravityAccelerometerSTDZ
* TimeBodyAccelerometerJerkSTDX
* TimeBodyAccelerometerJerkSTDY
* TimeBodyAccelerometerJerkSTDZ
* TimeBodyGyroscopeSTDX
* TimeBodyGyroscopeSTDY
* TimeBodyGyroscopeSTDZ
* TimeBodyGyroscopeJerkSTDX
* TimeBodyGyroscopeJerkSTDY
* TimeBodyGyroscopeJerkSTDZ
* TimeBodyAccelerometerMagnitudeSTD
* TimeGravityAccelerometerMagnitudeSTD
* TimeBodyAccelerometerJerkMagnitudeSTD
* TimeBodyGyroscopeMagnitudeSTD
* TimeBodyGyroscopeJerkMagnitudeSTD
* FrequencyBodyAccelerometerSTDX
* FrequencyBodyAccelerometerSTDY
* FrequencyBodyAccelerometerSTDZ
* FrequencyBodyAccelerometerJerkSTDX
* FrequencyBodyAccelerometerJerkSTDY
* FrequencyBodyAccelerometerJerkSTDZ
* FrequencyBodyGyroscopeSTDX
* FrequencyBodyGyroscopeSTDY
* FrequencyBodyGyroscopeSTDZ
* FrequencyBodyAccelerometerMagnitudeSTD
* FrequencyBodyAccelerometerJerkMagnitudeSTD
* FrequencyBodyGyroscopeMagnitudeSTD
* FrequencyBodyGyroscopeJerkMagnitudeSTD

* SubjectID - The ID for the subject participating in the experiment
   Ranges from 1 to 30

* Activity - The type of activity performed by the subject 
  * WALKING
  * WALKING_UPSTAIRS
  * WALKING_DOWNSTAIRS
  * SITTING
  * STANDING
  * LAYING