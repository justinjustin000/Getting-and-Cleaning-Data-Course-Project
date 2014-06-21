Getting-and-Cleaning-Data-Course-Project
========================================
The objective of run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

To merge the training and the test sets to one data, we first read the data from the downloaded text files in the workspace.
Funtions used are read.table(). 

To extracts the mean and standard deviation columns, we used the grepl() function to look for "std" and "mean". 
This operation is done after the replacement of the activity labels. 

Point 3 and 4 are done by two parts. First by a For loop and second by straightforward replacement using the gsub() function.

Finally, to create an independent tidy data set, we applied the aggregate() function to a text file. 
  # output tidyData to text file
  tidyData <- aggregate(.~SubjectID+ActivityID, data=dfComb, FUN="mean")
  write.table(tidyData,"Means_of_mean_and_stdev_type_features.txt")
