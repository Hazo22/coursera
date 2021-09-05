# READ ME - Getting and Cleaning Data Course Project
The purpose of this file is to explain how the script works and is connected.

The data used for this assignment is separated into several files that are to be merged into one dataset.
For this, all data files were loaded into R using read.table, which were then merged using cbind and rbind.
Column names were taken from a text file that came with the dataset, and with the colnames() function.

Once the data was all merged together, two main transformation were performed. First, a new column was added with descriptive names for the activities, it was done with a data table containing the code for the numbers and names and then matched by number into the main data frame.

Second transformation was grouping the data by activity and then by subject, and then obtainind the mean for every column grouped in this way. For this, the main data frame was converted into a tibble object for easy grouping with group_by and the summarize() with the mean of each column.

The resulting data was saved to a text file.