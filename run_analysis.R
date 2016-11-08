library(dplyr)

# Read all data files:
xtrain <- read.table("X_train.txt", header = FALSE)

ytrain <- read.table("y_train.txt", header = FALSE)

xtest <- read.table("X_test.txt", header = FALSE)

ytest <- read.table("y_test.txt", header = FALSE)

testsubject <- read.table("subject_test.txt", header = FALSE)
# Apply a relevant variable name:
names(testsubject) <- c("subject")

trainsubject <- read.table("subject_train.txt", header = FALSE)
# Apply a relevant variable name:
names(trainsubject) <- c("subject")

features <- select(read.table("features.txt", header = FALSE), V2)

## Subset out the features of interest--those with mean() or std() or meanFreq() embeded in the name:
relevant.features <- subset(features, grepl("mean()", features$V2) | grepl("std()", features$V2))

## Insert activity labels and names into ytrain:
activity.name <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
# Apply the relevant activity labels:
ytrain$V1 <- activity.name[ytrain$V1]
# Create a relevant variable name:
names(ytrain)[1] <- "activity"

## Add the subject IDs and activity names to xtrain
xtrain <- cbind(trainsubject, ytrain, xtrain)

## Insert activity labels and names into ytest:
# Apply the relevant activity labels:
ytest$V1 <- activity.name[ytest$V1]
# Create a relevant variable name:
names(ytest)[1] <- "activity"

## Add the subject IDs and activity names to xtest
xtest <- cbind(testsubject, ytest, xtest)

## Stack the training and test dataframes:
all.results <- rbind(xtrain, xtest)

## Discard irrelevant variables from all.results:
## Retain the first two columns and those corresponding to means or standard deviations:
Index <- c(TRUE, TRUE, grepl("mean()", features$V2) | grepl("std()", features$V2))
relevant.results <- all.results[ , Index]

## Apply the relevant variable names, retaining the first two ("subject" and "activity":
Index <- Index[3:563]
relevant.names <- as.character(features$V2[Index])
names(relevant.results)[3:81] <- relevant.names
# "relevant.results" is the first of the two dataframes required in this project

# Aggregate the data, returning the dataframe of required means by subject and activity combination:
tidy.summary <- aggregate(relevant.results[3:81], by = list(relevant.results$subject, relevant.results$activity), FUN = mean)
## Rename the generically-named columns added by aggregate:
names(tidy.summary)[1:2] <- c("subject", "activity")
# "tidy.summary" is the second of the two dataframes required in this project.
