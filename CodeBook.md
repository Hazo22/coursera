# Class Project of the course "Getting and Cleaning Data"

## Data transformations
1. The original data was separated into several files that contained different aspects of the data, the first step was reading all txt files with read.table function. Another text file had all the column names and it was used to rename the columns of the other files with the colnames function. The data was of two types, a train phase and a test phase, a new data column was created with matrix function to function as a factor variable in the final dataset. Finally, cbind and rbind was used to merge al files into one database.
2. Some data columns were means and standard deviations of measurements. They were extracted with grepl using regular expresions to find and match the columns that contain means and standard deviations. The resulting vector is then used with a simple bracket subset to obtain only the means and standard deviations
3. Activities in the dataset were coded with numbers, and another dataset named "activity_labels" contains the corresponding names to each number. The dataset with the names was loaded into R and then merged (using the merge function) with the main dataset. The data were matched by the activity number, so a new variable was created that contained the activity names.
4. No particular transformations were implemented in renaming the columns or contained data since it was already renamed in previous steps described.
5. Finally, a new dataset was created that containd the average of every variable grouped by subject and activity. For this, the dataset was converted into a tibble object, that was then grouped using group_by into subject and activity and then using summarize function the means of every column was obtained. The resulting dataset was saved into a file

## Script
The scrip named "run_analysis.R" contains all the described work above complying with the requirements of the Getting and Cleaning Data course.

## Variable descriptions
- `testdata`, `testsub`, `testx` and `testy` contain the test data.
- `traindata`. `trainsub`, `trainx`, `trainy`contain the train data.
- `xdata`contains the final merged data set
- `factor`, `factortest`and `factortrain`contain the labels for the different phases (train and test)
- `aclabels`contains the activity labels
- `names`contains the variable names of the main data
- `meanstd`is the vector containing the selected columns for the mean and stf subset
- `xdatanames`contain the original dataset with new activity names
- `xdatameanastf`contains the subseted means and std data
- `xdata2`contains a tibble transformation of the original dataset
- `newdata`contains the new independent tidy dataset grouped by activity and subject
