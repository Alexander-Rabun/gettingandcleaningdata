---
title: "README.md for Getting and Cleaning Data Project"
author: "Donald Chambless"
date: "November 2016"
output: html_document
---


General Information Concerning the Project Objectives
=====================================================

In this project we were to amalgamate and process inertial sensor data from the accelerometers of Samsung Galaxy S smartphones worn by 30 subjects involved in various physical activities; these data were recorded in a "training" and a "testing" dataset with details provided in a number of ancillary data files.  The specific instructions were to produce a single script that:

1.	Merges the training and the test sets to create one data set.

2.	Extracts only the measurements on the mean and standard deviation for each measurement.
	
3. 	Uses descriptive activity names to name the activities in the data set

4.	Appropriately labels the data set with descriptive variable names.
	
5. 	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The review criteria were:

1.	The submitted data set is tidy.

2.	The GitHub repo contains the required scripts.

3.	GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.

4.	The README that explains the analysis files is clear and understandable.

5.	The work submitted for this project is the work of the student who submitted it.


In conducting this project, the following assumptions were made by the author:
==============================================================================

a)	The measurements that are of interest are those for which the character strings "mean()" or "std()" or "meanFreq()" are embedded in the measurement names in  the features.txt file.  In the case of "meanFreq()" it is not completely clear whether these measurements are of interest: **it was the author's judgment that these "meanFreq()" measurements were also to be included in the submitted dataset.**

b)	There were 30 subjects involved in this study.  **It was the author's judgement that the subject number should be included in the submitted datasets.**

c)	There were six different types of physical activity involved.  **It was the author's judgment that the descriptive labels for these activities should be included in the submitted datasets.**


Description of the analysis:
============================

* First we read the provided data files X_train.txt, y_train.txt, X_test.txt, y_test.txt, subject_test.txt, subject_train.txt and features.txt to produce the dataframes "xtrain", "ytrain", "xtest", "ytest", "testsubject", "trainsubject", and "features"

* Then we subsetted out the features of interest from the dataframe "features"--those with mean() or std() or meanFreq() embedded in the name--to produce the dataframe "relevant.features"

* We next inserted the relevant activity names (WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING") into the ytrain and ytest dataframes and named the field "activity".  We also used cbind() to add the subject IDs and activity names to the dataframes xtrain and xtest.

* We then used rbind() to combine "xtrain" and "xtest" to produce the dataframe "all.results" and removed all variables not related to "mean()" or "std()" using the grepl-produced "Index" to yield the dataframe "relevant.results".  Next we applied the correct feature names to the variables in "relevant.results".  "relevant.results" is the first of the two dataframes required in this project

* Finally, we used the aggregate() function to produce the dataframe "tidy.summary" that gives the means of all the relevant variables by subject and activity combination. "tidy.summary" is the second of the two dataframes required in this project; we created "tidy.summary.txt" which is a text version of this data.frame with tab delimiters using the write.table() function.
