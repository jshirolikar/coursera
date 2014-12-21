library(plyr)
library(gdata)

trainingset <- read.table("C:\\coursera\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt")
testset <- read.table("C:\\coursera\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt" )

features_set <- read.table("C:\\coursera\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\features.txt")


traininglabels <- read.table("C:\\coursera\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\Y_train.txt" )
testinglabels <- read.table("C:\\coursera\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\Y_test.txt" )

subject_test <- read.table("C:\\coursera\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt")

subject_train <- read.table("C:\\coursera\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt")

colnames(trainingset) <- unlist(features_set_names)

colnames(testset) <- unlist(features_set_names)
 
 trainingset <- cbind(subject_train, trainingset)
 
 trainingset <- cbind(traininglabels, trainingset)
 colnames(trainingset)[1] <- "Activity"
 colnames(trainingset)[2] <- "Subject"
 
 testset <- cbind(subject_test, testset)
 testset <- cbind (testinglabels, testset)
 colnames(testset)[1] <-"Activity"
 colnames(testset)[2] <- "Subject"
 
 combinedset <- rbind(trainingset, testset)

 
combinedset$Activity <- gsub("1", "WALKING", combinedset$Activity)
combinedset$Activity <- gsub("2", "WALKING_UPSTAIRS", combinedset$Activity)
combinedset$Activity <- gsub("3", "WALKING_DOWNSTAIRS", combinedset$Activity)
combinedset$Activity <- gsub("4", "SITTING", combinedset$Activity)
combinedset$Activity <- gsub("5", "STANDING", combinedset$Activity)
combinedset$Activity <- gsub("6", "LAYING", combinedset$Activity)


finalset <- matchcols(combinedset, with = c("mean", "std"), method = "or")
combinedset2 <- subset(combinedset, select = c("Activity", "Subject", finalset$mean, finalset$std))
combinedset3 <- aggregate(combinedset2[, 3:81], list(combinedset2$Activity, combinedset2$Subject), mean)

colnames(combinedset3)[1] <- "Activity"
colnames(combinedset3)[2]<- "Subject"

write.table(combinedset3, "C:\\coursera\\tidyset.txt", row.names = FALSE)
