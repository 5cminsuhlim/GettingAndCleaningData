library(dplyr)


## read in files and give column names based on CodeBook
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt', col.names = c('activity_no', 'activity'))
features <- read.table('./UCI HAR Dataset/features.txt', col.names = c('row', 'feature'))

subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt', col.names = 'subject_id')
X_test <- read.table('./UCI HAR Dataset/test/X_test.txt', col.names = features$feature)
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt', col.names = names(activity_labels[1]))

subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt', col.names = 'subject_id')
X_train <- read.table('./UCI HAR Dataset/train/X_train.txt', col.names = features$feature)
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt', col.names = names(activity_labels[1]))


## merge data sets
test <- cbind(subject_test, X_test, y_test)
train <- cbind(subject_train, X_train, y_train)
combined <- rbind(test, train)


## extract subject_id, activity_no, and columns that contain either 'mean' or 'std
combined <- combined %>% 
                select(subject_id, activity_no, contains(c('mean','std')))


## replace activity_no w/ respective activity
combined$activity_no <- factor(combined$activity_no, labels = activity_labels$activity)

## rename activity_no to activity
combined <- combined %>% 
                rename(activity = activity_no)


## create a second, independent tidy data set with the average of each variable for each activity and each subject
tidy <- combined %>%
                group_by(activity, subject_id) %>%
                summarize(across(.fns = mean))

write.table(tidy, 'tidy_data_set.txt', row.names = FALSE)
