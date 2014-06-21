##run_analysis.R that does the following. 
##Merges the training and the test sets to create one data set.
##Extracts only the measurements on the mean and standard deviation for each measurement. 
##Uses descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names. 
##Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

run_analysis <- function(){
  ## Read outcome data
  ## perform operations on x-data
  stest <- read.table("./test/subject_test.txt")
  xtest <- read.table("./test/X_test.txt")
  ytest <- read.table("./test/Y_test.txt")
  hrow <- read.table("features.txt") #read feature headers
  acti <- read.table("activity_labels.txt") #read activity labels
  
  DFtest <- data.frame(stest, ytest, xtest)

  ## fill in the features
  for (i in 3:length(DFtest)){
    names(DFtest)[i] <- paste(hrow[i-2,2])
  }
  
  ## Extracts only the measurements on the mean and standard deviation 
  ## for each measurement. 
  dfTestStd <- DFtest[,grepl("std", names(DFtest))]
  dfTestMean <- DFtest[,grepl("mean", names(DFtest))]
  dfTestSub <- DFtest[,1]
  dfTestAct <- DFtest[,2]
  
  ## fill in the rest of the column labels
  dfTestF <- data.frame(dfTestSub, dfTestAct, dfTestMean, dfTestStd)
  names(dfTestF)[1] <- paste("SubjectID")
  names(dfTestF)[2] <- paste("ActivityID")
  dfTestF$ActivityID <- gsub("6", "LAYING", dfTestF$ActivityID)
  dfTestF$ActivityID <- gsub("5", "STANDING", dfTestF$ActivityID)
  dfTestF$ActivityID <- gsub("4", "SITTING", dfTestF$ActivityID)
  dfTestF$ActivityID <- gsub("3", "WALKING_DOWNSTAIRS", dfTestF$ActivityID)
  dfTestF$ActivityID <- gsub("2", "WALKING_UPSTAIRS", dfTestF$ActivityID)
  dfTestF$ActivityID <- gsub("1", "WALKING", dfTestF$ActivityID)
  
  ## Repeat for y-data
  
  strain <- read.table("./train/subject_train.txt")
  xtrain <- read.table("./train/X_train.txt")
  ytrain <- read.table("./train/Y_train.txt")
  
  DFtrain <- data.frame(strain, ytrain, xtrain)

  ## fill in the features
  for (i in 3:length(DFtrain)){
    names(DFtrain)[i] <- paste(hrow[i-2,2])
  }
  
  ## Extracts only the measurements on the mean and standard deviation 
  ## for each measurement.
  dftrainStd <- DFtrain[,grepl("std", names(DFtrain))]
  dftrainMean <- DFtrain[,grepl("mean", names(DFtrain))]
  dftrainSub <- DFtrain[,1]
  dftrainAct <- DFtrain[,2]

  ## fill in the rest of the column labels
  dftrainF <- data.frame(dftrainSub, dftrainAct, dftrainMean, dftrainStd)
  names(dftrainF)[1] <- paste("SubjectID")
  names(dftrainF)[2] <- paste("ActivityID")
  dftrainF$ActivityID <- gsub("6", "LAYING", dftrainF$ActivityID)
  dftrainF$ActivityID <- gsub("5", "STANDING", dftrainF$ActivityID)
  dftrainF$ActivityID <- gsub("4", "SITTING", dftrainF$ActivityID)
  dftrainF$ActivityID <- gsub("3", "WALKING_DOWNSTAIRS", dftrainF$ActivityID)
  dftrainF$ActivityID <- gsub("2", "WALKING_UPSTAIRS", dftrainF$ActivityID)
  dftrainF$ActivityID <- gsub("1", "WALKING", dftrainF$ActivityID)
  
  # merge x- and y-data set
  dfComb <- rbind(dfTestF, dftrainF) 
  
  # output tidyData to text file
  tidyData <- aggregate(.~SubjectID+ActivityID, data=dfComb, FUN="mean")
  write.table(tidyData,"Means_of_mean_and_stdev_type_features.txt")
}
