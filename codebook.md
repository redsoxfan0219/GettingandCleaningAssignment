# Getting and Cleaning Data Project

The text below describes the processes operating within my script submission for the Getting and Cleaning Data course project.


1.  **Download the dataset**
    
    -   Dataset downloaded and extracted to the folder called  `Data Science`, which is also my local working directory for this project.
    
      
    
2.  **Assign each data to variables**
    
    -   `featuresNames`  <-  `"features.txt"`  : 561 rows, 2 columns  
        _The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ._
    -   `activityLabels`  <-  `"activity_labels.txt"`  : 6 rows, 2 columns  
        _List of activities performed when the corresponding measurements were taken and its codes (labels)_
    -   `subject_test`  <-  `"subject_test.txt"`  : 2947 rows, 1 column  
        _contains test data of 9/30 volunteer test subjects being observed_
    -   `featuresTest`  <-  `"X_test.txt"`  : 2947 rows, 561 columns  
        _contains recorded features test data_
    -   `activityTest`  <-  `"y_test.txt"`  : 2947 rows, 1 columns  
        _contains test data of activities’code labels_
    -   `subjectTrain`  <-  `"subject_train.txt"`  : 7352 rows, 1 column  
        _contains train data of 21/30 volunteer subjects being observed_
    -   `featuresTrain`  <-  `"X_train.txt"`  : 7352 rows, 561 columns  
        _contains recorded features train data_
    -   `activityTrain`  <-  `"y_train.txt"`  : 7352 rows, 1 columns  
        _contains train data of activities’code labels_
    
      
    
3.  **Merges the training and the test sets to create one data set**
    
    -   `subject`  (10299 rows, 1 column) is created by merging  `subjectTrain`  and  `subjectTest`  using  **rbind()**  function
    -   `activity`  (10299 rows, 1 column) is created by merging  `activityTrain`  and  `activityTest`  using  **rbind()**  function
    -   `features`  (10299 rows, 561 column) is created by merging  `featuresTrain`  and  `featuresTest`  using  **rbind()**  function
    -   
    - `completeData`  (10299 rows, 563 column) is created by merging  `subject`,  `activity`  and  `features`  using  **cbind()**  function
    
      
    
4.  **Extracts only the measurements on the mean and standard deviation for each measurement**
    
    -   `extractedData`  (10299 rows, 88 columns) is created by subsetting  `completData`, using **grep()**  function to retrieve  `mean`  and  _standard deviation_  (`std`) for each measurement
    
      
    
5.  **Uses descriptive activity names to name the activities in the data set**
    
    -   Entire numbers in  `code`  column of the  `completeData`  replaced with corresponding activity taken from second column of the  `activities`  variable
    
      
    
6.  **Appropriately labels the data set with descriptive variable names**
    
    -   `code`  column in  `completeData`  renamed into  `activities`
    -   All  `Acc`  in column’s name replaced by  `Accelerometer`
    -   All  `Gyro`  in column’s name replaced by  `Gyroscope`
    -   All  `BodyBody`  in column’s name replaced by  `Body`
    -   All  `Mag`  in column’s name replaced by  `Magnitude`
    -   All start with character  `f`  in column’s name replaced by  `Frequency`
    -   All start with character  `t`  in column’s name replaced by  `Time`
    
      
    
7.  **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**
    -   `tidyData`  (180 rows, 88 columns) is created by summarizing  `extractedData`, taking the means of each variable for each activity and each subject, after grouped by subject and activity.
    -   Export  `tidyData`  into  `Tidy.csv`  file.
