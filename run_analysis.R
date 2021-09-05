##############################################################
# Merges the training and the test sets to create one data set.
##############################################################
# First I read all the files to variables as tables
library(tidyverse)
#first the test files

testsub <-  read.table("./UCI HAR Dataset/test/subject_test.txt")
testx <-  read.table("./UCI HAR Dataset/test/X_test.txt")
testy <-  read.table("./UCI HAR Dataset/test/Y_test.txt")

#Now the training files, copying the calls above
trainsub <-  read.table("./UCI HAR Dataset/train/subject_train.txt")
trainx <-  read.table("./UCI HAR Dataset/train/X_train.txt")
trainy <-  read.table("./UCI HAR Dataset/train/Y_train.txt")

#features.txt contain the names of the x data files, so we read those too

names <-  read.table("./UCI HAR Dataset/features.txt")

#Use it to name the columns of the x datasets, names are on the second columns and put both together on a single database

colnames(testx) <- names[,2]
colnames(trainx) <- names[,2]
#Y are the activities coded in "activity_label" sub is the subject number so we name those columns

colnames(testy) <- "Activity"
colnames(testsub) <- "Id"
colnames(trainy) <- "Activity"
colnames(trainsub) <- "Id"
#Create a new factor column to differentiate test from train data, then merge them into test and train data frames

factortest <- data.frame(matrix("test",ncol = 1, nrow = 2947))
colnames(factortest) <- c("dataphase")
factortrain <- data.frame(matrix("train",ncol = 1, nrow = 7352))
colnames(factortrain) <-  c("dataphase")  #these data.frames are then binded to the others


traindata <-  cbind(trainx, trainsub, trainy, factortrain) #first the train dataset
testdata <-  cbind(testx, testsub, testy, factortest) #then the test data

xdata <-  rbind(traindata, testdata) #all together, this should complete all merging of data into one tidy data set

##########################################################################################
##Extracts only the measurements on the mean and standard deviation for each measurement. 
##########################################################################################

#For this, I'll use grepl to match the mean and std columns from the column names, along with the id

meanstd <-  (grepl("Id", colnames(xdata)) | 
             grepl("mean..", colnames(xdata)) | 
             grepl("std..", colnames(xdata))
             )
#Subset using above vector

xdatameanastd <- xdata[, meanstd == TRUE]


###########################################################################
#Uses descriptive activity names to name the activities in the data set####
###########################################################################

#Activities are named in the Activity_labels.txt, so I'll import that into R and match the numbers an words in the complete dataset
#First importing the data

aclabels <-  read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(aclabels) <- c("Activity", "ActName")

xdatanames <-  merge(xdata, aclabels, by="Activity", all.x = TRUE)
#this merges both datasets merging by Activity, creating a new column named "ActName" that contains the label for each activity

#########################################################################
#Appropriately labels the data set with descriptive variable names.#####
#######################################################################

#The data set is already named in previous steps

#################################################################################################################################################
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.##
################################################################################################################################################


xdata2 <- tibble(xdatanames, .name_repair = "unique") #convert to tibble for better handling, use name repair because of duplicate names errors

newdata <-  xdata2 %>% group_by(ActName, Id) %>% summarise(across(everything(), mean)) #groups by activity and subject and then we get the mean of each column using summarize and across

write.table(newdata, "Secondset.txt", row.names = FALSE) #write the file


