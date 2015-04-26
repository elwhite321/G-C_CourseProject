 
run_analysis.R steps:

      1. Download and unzip the file
      2. Read in the text files used for this assignment: X_test, X_train, y_test, y_train, subject_test, 
      subject_train, and the features text files. 
      3. Add the column names to the X_test and X_train using the lables found in the features text file
      4. Add the subject and y text files together for both the train and text files seperatly and add 
      the appropriate column names (Subject and Activity).
      5. Add the X_train and X_test to their respective data frames created in the previous step.
      6. PART ONE: Combine the train and test data frames created in the previous step by row using 
      rbind.
      7. Create logical vectors to state which variables measure mean and standard deviation (one for 
      each).
      8. Using the logical vectors, create a subset of the combined test and train data that only 
      contains measurments of mean and standard deviation. I chose to leave the mean frequancy 
      measurments in as well.
      9. Read in the activity labels and inspect. Swap integers in the y_test and train for their
      activity labels in the text file. 
      10. Convert the measurments to numeric in order to average them in the next step.
      11. Mean across measurments by group in the subsetted data set to create a tidy data set with the
      average of each veriable for each activity and subject per part five of the assignment.
      12. Write the data frame created in the previous step to a text file. 

I chose to create a wide data set with 81 variables and only 180 observations. This makes it easier to 
select and subset each measurment in the data frame using the $ operator. I chose to use the features 
labels for each measurment because they are good labels and it was easy to do. 