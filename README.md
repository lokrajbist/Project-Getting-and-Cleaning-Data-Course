# Getting-and-Cleaning-Data-Course-Project

##Requirements
* Download the script `run_analysis.R`.
* Download the raw data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to same directory and unzip it.

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:
* Loading the activity and feature information
* Loading both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
* Loading the activity and subject data for each dataset, and merging those columns with the dataset
* Merging of the two datasets
* Conversion of the `activity` and `subject` columns into factors
* Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The end result is shown in the file `tidy.txt`.


## Codebook
Information about the datasets is provided in `Codebook.md`.     

## Code 
The code contains detailed commments explaining the steps in which the original data was transformed to `tidy.txt`.